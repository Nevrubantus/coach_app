# Быстрый деплой Progress Fit

Этот файл нужен, чтобы быстро обновить сервер, когда TimeWeb восстановит нормальный внешний доступ.

## Что уже подготовлено

- Flutter Web собран в `coach_app_server/web/app`.
- Web-сборка не привязана к одному домену.
- Flutter получает адрес Serverpod из `/app/assets/assets/config.json`.
- Сервер формирует API-адрес от текущего домена: `/serverpod/`.
- Загруженные видео и аватары нужно хранить вне Docker-контейнера, чтобы они не пропали после пересборки.

## Локальная сборка Flutter Web

Команда выполняется на Windows в PowerShell:

```powershell
cd C:\Users\artem\coach_app\coach_app\coach_app_flutter

flutter build web `
  --base-href /app/ `
  --no-wasm-dry-run
```

После сборки скопировать результат:

```powershell
$src = "C:\Users\artem\coach_app\coach_app\coach_app_flutter\build\web\*"
$dst = "C:\Users\artem\coach_app\coach_app\coach_app_server\web\app"
Remove-Item $dst -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $dst | Out-Null
Copy-Item -Path $src -Destination $dst -Recurse -Force
```

Потом отправить изменения в GitHub:

```powershell
cd C:\Users\artem\coach_app\coach_app
git add coach_app_server/web/app coach_app_server/.gitignore DEPLOYMENT_FAST_START.md
git commit -m "Prepare web deployment"
git push
```

## Обновление проекта на сервере

Команды выполняются в консоли сервера:

```bash
cd /opt/coach_app
git pull
```

Поднять PostgreSQL и Redis:

```bash
cd /opt/coach_app/coach_app_server
docker compose up -d postgres redis
```

Собрать Serverpod:

```bash
cd /opt/coach_app
docker build -f coach_app_server/Dockerfile -t coach-app-server .
```

Создать постоянную папку для загрузок:

```bash
mkdir -p /opt/coach_app/uploads/videos
mkdir -p /opt/coach_app/uploads/avatars
```

Запустить API-контейнер с подключенной папкой загрузок:

```bash
docker rm -f coach-app-api 2>/dev/null || true

docker run -d \
  --name coach-app-api \
  --network host \
  --restart unless-stopped \
  -e runmode=development \
  -e serverid=default \
  -e logging=normal \
  -e role=monolith \
  -v /opt/coach_app/uploads:/web/static/uploads \
  coach-app-server --apply-migrations
```

Важно: параметр `-v /opt/coach_app/uploads:/web/static/uploads` сохраняет видео и аватары на сервере, а не внутри контейнера.

## Nginx

Конфигурация для `/etc/nginx/sites-available/progress-fit`:

```nginx
server {
    listen 80;
    server_name progress-fit.ru www.progress-fit.ru xn----etbgn0afhckanw.xn--p1ai www.xn----etbgn0afhckanw.xn--p1ai;

    client_max_body_size 100m;
    client_body_timeout 300s;

    location /serverpod/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_http_version 1.1;
        proxy_connect_timeout 75s;
        proxy_send_timeout 300s;
        proxy_read_timeout 300s;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /uploads/ {
        alias /opt/coach_app/uploads/;
        try_files $uri =404;
        add_header Cache-Control "public, max-age=3600";
    }

    location / {
        proxy_pass http://127.0.0.1:8082;
        proxy_http_version 1.1;
        proxy_hide_header Cache-Control;
        add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate" always;
        add_header Pragma "no-cache" always;
        add_header Expires "0" always;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Применить:

```bash
ln -s /etc/nginx/sites-available/progress-fit /etc/nginx/sites-enabled/progress-fit 2>/dev/null || true
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl reload nginx
```

## Проверка на сервере

```bash
curl -I http://127.0.0.1:8082/app
curl http://127.0.0.1:8080/
curl -I http://127.0.0.1/
docker logs coach-app-api --tail 80
```

Ожидаемо:

- `/app` возвращает `200 OK`;
- `8080` возвращает строку `OK ...`;
- Nginx на `80` возвращает страницу приложения или Serverpod web.

## Проверка с Windows

```powershell
curl.exe -4 -v --max-time 10 http://progress-fit.ru/app
```

Если на сервере локально всё работает, а с Windows снова timeout и в `/var/log/nginx/access.log` нет запроса, значит проблема остаётся на стороне сетевого доступа TimeWeb.

## Быстрый временный публичный доступ без карты

Если TimeWeb всё ещё не отвечает снаружи, можно быстро открыть приложение через Cloudflare Quick Tunnel. Это не требует Zero Trust и банковской карты.

На сервере:

```bash
docker rm -f cloudflared-demo 2>/dev/null || true

docker run -d \
  --name cloudflared-demo \
  --network host \
  --restart unless-stopped \
  cloudflare/cloudflared:latest tunnel \
  --no-autoupdate \
  --url http://127.0.0.1:80
```

Посмотреть временную ссылку:

```bash
docker logs -f cloudflared-demo
```

В логах нужно найти адрес вида:

```text
https://что-то.trycloudflare.com
```

Открывать приложение:

```text
https://что-то.trycloudflare.com/app/
```

Это временная ссылка для демонстрации. После перезапуска tunnel она может измениться.
