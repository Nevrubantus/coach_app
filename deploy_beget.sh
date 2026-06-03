#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/coach_app"
SERVER_DIR="$APP_DIR/coach_app_server"
UPLOADS_DIR="$APP_DIR/uploads"
IMAGE_NAME="coach-app-server"
CONTAINER_NAME="coach-app-api"

cd "$SERVER_DIR"

cat > config/passwords.yaml <<'EOF'
shared:
  mySharedPassword: 'my password'

development:
  database: '0gq_ra9c1bG94g_Yw6r_hNd4RvGyzDGj'
  redis: 'kyUWo4xSW_IXYqtUAneuDotRMrNk1r9-'
  serviceSecret: 'z8l4XidfaQ0_QdnCQte4GGG-_Vrm1QJg'
  emailSecretHashPepper: 'g0PlVCdHpvVyoaEHDH73558Akqqp5EvY'
  jwtHmacSha512PrivateKey: 'qjFXy5mMdTaJPmNcOQtnixwAkMlPv2VB'
  jwtRefreshTokenHashPepper: 'ytAWcICuVS9kqSV70WIMWREIhxZKqvjB'

test:
  database: '8cQXUfdE4iudDSC3tBtFfICli_9KOdvp'
  redis: '2hZBzQXnubmK559wUA3VI6HAzfTMxfyg'
  emailSecretHashPepper: 'qHH9TShPs9NqJn2as9mxsYspFvmA6fP5'
  jwtHmacSha512PrivateKey: 'xugs3D5VQUQBFQiV7Yg9qsu8tGr7rcwZ'
  jwtRefreshTokenHashPepper: 'EvU3wMOqKSHsKAGOlwVeHWDJqGhm8Z2K'

staging:
  database: 'c8omL40JidpmdqoJjDynJDslABsx4b2y'
  serviceSecret: 'OdgQ_jBc8WkK0kNJwdvPrLMuJNEof00n'
  emailSecretHashPepper: 'UclDJBjhMPXiTgRZRa1xctxCi68N7TOz'
  jwtHmacSha512PrivateKey: 'tGVg6HQh-pQvnvJS8cYErh7OeGDCOnMo'
  jwtRefreshTokenHashPepper: 'npmlLpAwjb9KRn2y-6p7_AlAvIqO0Npn'

production:
  database: 'S2752Nh1GdOLmZABSqwSN9vnD_7UCVTy'
  serviceSecret: 'Q1putrOsGJ5DjU7oy8R_PThfDYyICYdo'
  emailSecretHashPepper: 'v9QH1E8TNu2sgqbhpd4Xs6BuNZmiSX5H'
  jwtHmacSha512PrivateKey: 'adhBQF2LOL26PywQAKBq8-mOJSxGDN3z'
  jwtRefreshTokenHashPepper: 'NMB5sIfD98CdHsPTzrcqsqvLdG6zBLCg'
EOF

docker compose up -d postgres redis

mkdir -p "$UPLOADS_DIR/videos" "$UPLOADS_DIR/avatars"

cd "$APP_DIR"
docker build -f coach_app_server/Dockerfile -t "$IMAGE_NAME" .
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker run -d \
  --name "$CONTAINER_NAME" \
  --network host \
  --restart unless-stopped \
  -e runmode=development \
  -e serverid=default \
  -e logging=normal \
  -e role=monolith \
  -v "$UPLOADS_DIR:/web/static/uploads" \
  "$IMAGE_NAME" --apply-migrations

cat > /etc/nginx/sites-available/coach_app <<'EOF'
server {
    listen 80;
    server_name _;

    client_max_body_size 100m;

    location /serverpod/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
    }

    location / {
        proxy_pass http://127.0.0.1:8082;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
    }
}
EOF

ln -sf /etc/nginx/sites-available/coach_app /etc/nginx/sites-enabled/coach_app
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl reload nginx

echo "Waiting for Serverpod..."
for _ in $(seq 1 30); do
  if curl -fsS http://127.0.0.1:8080/ >/dev/null; then
    break
  fi
  sleep 1
done

echo
echo "Deployment complete."
echo "Open: http://212.8.228.9/app/"
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
