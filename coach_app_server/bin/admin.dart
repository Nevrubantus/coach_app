import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty || args.first == 'help' || args.first == '--help') {
    _printHelp();
    return;
  }

  try {
    switch (args.first) {
      case 'users':
        await _printUsers();
      case 'links':
        await _printLinks();
      case 'exercises':
        await _printExercises();
      case 'set-role':
        await _setRole(args);
      case 'attach':
        await _attach(args);
      case 'detach':
        await _detach(args);
      case 'add-exercise':
        await _addExercise(args);
      case 'update-exercise':
        await _updateExercise(args);
      case 'delete-exercise':
        await _deleteExercise(args);
      default:
        stderr.writeln('Неизвестная команда: ${args.first}');
        _printHelp();
        exitCode = 64;
    }
  } on AdminException catch (error) {
    stderr.writeln(error.message);
    exitCode = 1;
  }
}

Future<void> _printUsers() async {
  final rows = await _query('''
    SELECT
      id::text,
      name,
      contact,
      CASE WHEN "isAthlete" THEN 'athlete' ELSE 'trainer' END
    FROM "app_user"
    ORDER BY id;
  ''');

  _printTable(
    ['id', 'name', 'contact', 'role'],
    rows,
    emptyMessage: 'Пользователей пока нет.',
  );
}

Future<void> _printLinks() async {
  final rows = await _query('''
    SELECT
      ca.id::text,
      coach.name,
      coach.contact,
      athlete.name,
      athlete.contact,
      ca."createdAt"::text
    FROM "coach_athlete" ca
    JOIN "app_user" coach ON coach.id = ca."coachId"
    JOIN "app_user" athlete ON athlete.id = ca."athleteId"
    ORDER BY ca."createdAt";
  ''');

  _printTable(
    [
      'id',
      'coach',
      'coach_contact',
      'athlete',
      'athlete_contact',
      'created_at',
    ],
    rows,
    emptyMessage: 'Привязок тренер-атлет пока нет.',
  );
}

Future<void> _printExercises() async {
  final rows = await _query('''
    SELECT
      id::text,
      name,
      COALESCE("mediaUrl", ''),
      LEFT(description, 90)
    FROM "exercise"
    ORDER BY name;
  ''');

  _printTable(
    ['id', 'name', 'photo', 'description'],
    rows,
    emptyMessage:
        'Упражнений пока нет. Запусти сервер или добавь первое упражнение.',
  );
}

Future<void> _setRole(List<String> args) async {
  if (args.length != 3) {
    throw AdminException(
      'Формат: dart bin/admin.dart set-role <contact> <trainer|athlete>',
    );
  }

  final user = await _findUserByContact(args[1]);
  if (user == null) {
    throw AdminException('Пользователь не найден: ${args[1]}');
  }

  final role = _parseRole(args[2]);
  if (role == null) {
    throw AdminException('Роль должна быть trainer или athlete.');
  }

  await _exec(
    'UPDATE "app_user" SET "isAthlete" = ${role.isAthlete} '
    'WHERE id = ${user.id};',
  );

  if (role.isAthlete) {
    await _exec('DELETE FROM "coach_athlete" WHERE "coachId" = ${user.id};');
  } else {
    await _exec('DELETE FROM "coach_athlete" WHERE "athleteId" = ${user.id};');
  }

  stdout.writeln(
    '${user.name} (${user.contact}) теперь ${role.label}. '
    'Несовместимые старые привязки очищены.',
  );
}

Future<void> _attach(List<String> args) async {
  if (args.length != 3) {
    throw AdminException(
      'Формат: dart bin/admin.dart attach <coach_contact> <athlete_contact>',
    );
  }

  final coach = await _findUserByContact(args[1]);
  final athlete = await _findUserByContact(args[2]);
  _checkCoachAndAthlete(coach, athlete);

  final existing = await _query(
    'SELECT id::text FROM "coach_athlete" '
    'WHERE "coachId" = ${coach!.id} AND "athleteId" = ${athlete!.id};',
  );

  if (existing.isEmpty) {
    await _exec(
      'INSERT INTO "coach_athlete" ("coachId", "athleteId", "createdAt") '
      "VALUES (${coach.id}, ${athlete.id}, timezone('utc', now()));",
    );
    stdout.writeln('${athlete.name} привязан к тренеру ${coach.name}.');
  } else {
    stdout.writeln('${athlete.name} уже привязан к тренеру ${coach.name}.');
  }
}

Future<void> _detach(List<String> args) async {
  if (args.length != 3) {
    throw AdminException(
      'Формат: dart bin/admin.dart detach <coach_contact> <athlete_contact>',
    );
  }

  final coach = await _findUserByContact(args[1]);
  final athlete = await _findUserByContact(args[2]);
  if (coach == null) throw AdminException('Тренер не найден: ${args[1]}');
  if (athlete == null) throw AdminException('Атлет не найден: ${args[2]}');

  final deletedRows = await _query(
    'DELETE FROM "coach_athlete" '
    'WHERE "coachId" = ${coach.id} AND "athleteId" = ${athlete.id} '
    'RETURNING id::text;',
  );

  if (deletedRows.isEmpty) {
    stdout.writeln('Такой привязки не было.');
  } else {
    stdout.writeln('${athlete.name} отвязан от тренера ${coach.name}.');
  }
}

Future<void> _addExercise(List<String> args) async {
  final options = _parseOptions(args.skip(1).toList());
  final name = _requiredOption(options, 'name').trim();
  final description = _requiredOption(options, 'description').trim();
  final photoPath = options['photo']?.trim();

  if (name.isEmpty) {
    throw AdminException('Название упражнения не может быть пустым.');
  }
  if (description.isEmpty) {
    throw AdminException('Описание упражнения не может быть пустым.');
  }

  final duplicate = await _findExerciseByName(name);
  if (duplicate != null) {
    throw AdminException(
      'Упражнение с таким названием уже есть: id ${duplicate.id}. '
      'Используй update-exercise.',
    );
  }

  final mediaUrl = photoPath == null || photoPath.isEmpty
      ? null
      : await _copyExercisePhoto(photoPath);

  await _exec('''
    INSERT INTO "exercise" (name, description, "mediaUrl", "mediaType")
    VALUES (
      ${_sqlString(name)},
      ${_sqlString(description)},
      ${_nullableSqlString(mediaUrl)},
      ${mediaUrl == null ? 'NULL' : _sqlString('image')}
    );
  ''');

  stdout.writeln('Упражнение добавлено: $name.');
}

Future<void> _updateExercise(List<String> args) async {
  if (args.length < 2) {
    throw AdminException(
      'Формат: dart bin/admin.dart update-exercise <id> '
      '[--name "..."] [--description "..."] [--photo "..."]',
    );
  }

  final id = int.tryParse(args[1]);
  if (id == null) throw AdminException('id упражнения должен быть числом.');

  final exercise = await _findExerciseById(id);
  if (exercise == null) throw AdminException('Упражнение не найдено: $id');

  final options = _parseOptions(args.skip(2).toList());
  if (options.isEmpty) {
    throw AdminException('Укажи хотя бы одно поле для изменения.');
  }

  final updates = <String>[];
  final newName = options['name']?.trim();
  if (newName != null) {
    if (newName.isEmpty) {
      throw AdminException('Название упражнения не может быть пустым.');
    }

    final duplicate = await _findExerciseByName(newName);
    if (duplicate != null && duplicate.id != id) {
      throw AdminException(
        'Такое название уже занято упражнением id ${duplicate.id}.',
      );
    }

    updates.add('name = ${_sqlString(newName)}');
  }

  final newDescription = options['description']?.trim();
  if (newDescription != null) {
    if (newDescription.isEmpty) {
      throw AdminException('Описание упражнения не может быть пустым.');
    }
    updates.add('description = ${_sqlString(newDescription)}');
  }

  if (options.containsKey('photo')) {
    final photoPath = options['photo']?.trim() ?? '';
    if (photoPath.isEmpty ||
        photoPath == '-' ||
        photoPath.toLowerCase() == 'none') {
      updates.add('"mediaUrl" = NULL');
      updates.add('"mediaType" = NULL');
    } else {
      final mediaUrl = await _copyExercisePhoto(photoPath);
      updates.add('"mediaUrl" = ${_sqlString(mediaUrl)}');
      updates.add('"mediaType" = ${_sqlString('image')}');
    }
  }

  if (updates.isEmpty) {
    throw AdminException('Нет данных для обновления.');
  }

  await _exec('UPDATE "exercise" SET ${updates.join(', ')} WHERE id = $id;');
  stdout.writeln('Упражнение обновлено: ${exercise.name} (id $id).');
}

Future<void> _deleteExercise(List<String> args) async {
  if (args.length != 2) {
    throw AdminException('Формат: dart bin/admin.dart delete-exercise <id>');
  }

  final id = int.tryParse(args[1]);
  if (id == null) throw AdminException('id упражнения должен быть числом.');

  final deletedRows = await _query(
    'DELETE FROM "exercise" WHERE id = $id RETURNING name;',
  );

  if (deletedRows.isEmpty) {
    stdout.writeln('Упражнение не найдено.');
  } else {
    stdout.writeln(
      'Упражнение удалено из библиотеки: ${deletedRows.first.first}. '
      'В старых тренировках название упражнения сохранится.',
    );
  }
}

Future<AdminUser?> _findUserByContact(String contact) async {
  final rows = await _query('''
    SELECT
      id::text,
      name,
      contact,
      "isAthlete"::text
    FROM "app_user"
    WHERE contact = ${_sqlString(contact.trim().toLowerCase())}
    LIMIT 1;
  ''');

  if (rows.isEmpty) return null;
  final row = rows.first;
  return AdminUser(
    id: int.parse(row[0]),
    name: row[1],
    contact: row[2],
    isAthlete: row[3] == 'true',
  );
}

Future<AdminExercise?> _findExerciseById(int id) async {
  final rows = await _query('''
    SELECT id::text, name
    FROM "exercise"
    WHERE id = $id
    LIMIT 1;
  ''');

  if (rows.isEmpty) return null;
  return AdminExercise(id: int.parse(rows.first[0]), name: rows.first[1]);
}

Future<AdminExercise?> _findExerciseByName(String name) async {
  final rows = await _query('''
    SELECT id::text, name
    FROM "exercise"
    WHERE LOWER(name) = LOWER(${_sqlString(name.trim())})
    LIMIT 1;
  ''');

  if (rows.isEmpty) return null;
  return AdminExercise(id: int.parse(rows.first[0]), name: rows.first[1]);
}

void _checkCoachAndAthlete(AdminUser? coach, AdminUser? athlete) {
  if (coach == null) throw AdminException('Тренер не найден.');
  if (coach.isAthlete) {
    throw AdminException('${coach.name} сейчас атлет, а не тренер.');
  }

  if (athlete == null) throw AdminException('Атлет не найден.');
  if (!athlete.isAthlete) {
    throw AdminException('${athlete.name} сейчас тренер, а не атлет.');
  }
}

Map<String, String> _parseOptions(List<String> args) {
  final options = <String, String>{};
  var index = 0;

  while (index < args.length) {
    final key = args[index];
    if (!key.startsWith('--') || key.length <= 2) {
      throw AdminException('Неизвестный параметр: $key');
    }

    final name = key.substring(2);
    final hasValue =
        index + 1 < args.length && !args[index + 1].startsWith('--');
    options[name] = hasValue ? args[index + 1] : '';
    index += hasValue ? 2 : 1;
  }

  return options;
}

String _requiredOption(Map<String, String> options, String name) {
  final value = options[name];
  if (value == null || value.trim().isEmpty) {
    throw AdminException('Не указан параметр --$name.');
  }
  return value;
}

Future<String> _copyExercisePhoto(String sourcePath) async {
  final source = File(sourcePath);
  if (!source.existsSync()) {
    throw AdminException('Фото не найдено: $sourcePath');
  }

  final extension = _safeImageExtension(source.path);
  final uploadDirectory = Directory('web/static/uploads/exercises');
  if (!uploadDirectory.existsSync()) {
    uploadDirectory.createSync(recursive: true);
  }

  final storedName =
      'exercise_${DateTime.now().microsecondsSinceEpoch}$extension';
  await source.copy('${uploadDirectory.path}/$storedName');
  return 'uploads/exercises/$storedName';
}

String _safeImageExtension(String fileName) {
  final trimmed = fileName.trim().toLowerCase();
  final dotIndex = trimmed.lastIndexOf('.');
  if (dotIndex < 0 || dotIndex == trimmed.length - 1) {
    throw AdminException('Фото должно быть PNG, JPG, JPEG или WEBP.');
  }

  final extension = trimmed.substring(dotIndex);
  const allowed = {'.png', '.jpg', '.jpeg', '.webp'};
  if (!allowed.contains(extension)) {
    throw AdminException('Поддерживаются только PNG, JPG, JPEG и WEBP.');
  }
  return extension;
}

Role? _parseRole(String value) {
  final normalized = value.trim().toLowerCase();
  if (normalized == 'athlete' ||
      normalized == 'атлет' ||
      normalized == 'спортсмен') {
    return const Role(isAthlete: true, label: 'атлет');
  }
  if (normalized == 'trainer' ||
      normalized == 'coach' ||
      normalized == 'тренер') {
    return const Role(isAthlete: false, label: 'тренер');
  }
  return null;
}

Future<List<List<String>>> _query(String sql) async {
  final result = await _runPsql([
    '-q',
    '-t',
    '-A',
    '-F',
    '\t',
    '-c',
    sql,
  ]);

  final output = result.stdout.toString().trim();
  if (output.isEmpty) return const [];

  return output
      .split('\n')
      .where((line) => line.trim().isNotEmpty)
      .map((line) => line.split('\t'))
      .toList();
}

Future<void> _exec(String sql) async {
  await _runPsql(['-q', '-c', sql]);
}

Future<ProcessResult> _runPsql(List<String> psqlArgs) async {
  final result = await Process.run('docker', [
    'compose',
    'exec',
    '-T',
    'postgres',
    'psql',
    '-U',
    'postgres',
    '-d',
    'coach_app',
    '-v',
    'ON_ERROR_STOP=1',
    '-P',
    'pager=off',
    ...psqlArgs,
  ]);

  if (result.exitCode != 0) {
    throw AdminException(
      'Не удалось выполнить команду в PostgreSQL. '
      'Проверь, что Docker запущен и выполнено docker compose up -d.\n'
      '${result.stderr}',
    );
  }

  return result;
}

String _sqlString(String value) {
  return "'${value.replaceAll("'", "''")}'";
}

String _nullableSqlString(String? value) {
  return value == null ? 'NULL' : _sqlString(value);
}

void _printTable(
  List<String> headers,
  List<List<String>> rows, {
  required String emptyMessage,
}) {
  if (rows.isEmpty) {
    stdout.writeln(emptyMessage);
    return;
  }

  final widths = [
    for (var i = 0; i < headers.length; i++)
      [
        headers[i].length,
        for (final row in rows)
          if (i < row.length) row[i].length,
      ].reduce((a, b) => a > b ? a : b),
  ];

  String formatRow(List<String> cells) {
    return [
      for (var i = 0; i < headers.length; i++)
        (i < cells.length ? cells[i] : '').padRight(widths[i]),
    ].join('  ');
  }

  stdout.writeln(formatRow(headers));
  stdout.writeln(widths.map((width) => '-' * width).join('  '));
  for (final row in rows) {
    stdout.writeln(formatRow(row));
  }
}

void _printHelp() {
  stdout.writeln('''
Административная консоль Coach App.

Запускать из папки coach_app_server при работающем Docker:
  dart bin/admin.dart users
  dart bin/admin.dart links
  dart bin/admin.dart exercises
  dart bin/admin.dart set-role <contact> <trainer|athlete>
  dart bin/admin.dart attach <coach_contact> <athlete_contact>
  dart bin/admin.dart detach <coach_contact> <athlete_contact>

Управление библиотекой упражнений:
  dart bin/admin.dart exercises
  dart bin/admin.dart add-exercise --name "Гиперэкстензия" --description "Короткое описание техники." --photo "C:\\path\\photo.jpg"
  dart bin/admin.dart update-exercise <id> --description "Новое описание" --photo "C:\\path\\photo.jpg"
  dart bin/admin.dart update-exercise <id> --photo none
  dart bin/admin.dart delete-exercise <id>
''');
}

class AdminUser {
  final int id;
  final String name;
  final String contact;
  final bool isAthlete;

  const AdminUser({
    required this.id,
    required this.name,
    required this.contact,
    required this.isAthlete,
  });
}

class AdminExercise {
  final int id;
  final String name;

  const AdminExercise({
    required this.id,
    required this.name,
  });
}

class Role {
  final bool isAthlete;
  final String label;

  const Role({
    required this.isAthlete,
    required this.label,
  });
}

class AdminException implements Exception {
  final String message;

  const AdminException(this.message);
}
