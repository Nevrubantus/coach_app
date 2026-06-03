const monthNames = [
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

const monthTitles = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];

String formatTime(DateTime date) {
  final localDate = date.toLocal();
  final hour = localDate.hour.toString().padLeft(2, '0');
  final minute = localDate.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

String formatShortDate(DateTime date) {
  final localDate = date.toLocal();
  return '${localDate.day} ${monthNames[localDate.month - 1]}';
}

String formatCalendarTitle(DateTime date) {
  final localDate = date.toLocal();
  return '${monthTitles[localDate.month - 1]} ${localDate.year}';
}

String formatWorkoutDateTime(DateTime date) {
  final localDate = date.toLocal();
  return '${formatShortDate(localDate)}, ${formatTime(localDate)}';
}

String formatWeight(double weight) {
  final isInteger = weight == weight.roundToDouble();
  final value = isInteger
      ? weight.toStringAsFixed(0)
      : weight.toStringAsFixed(1);
  return value.replaceAll('.', ',');
}

String formatCount(
  int count,
  String one,
  String few,
  String many,
) {
  final mod100 = count % 100;
  final mod10 = count % 10;

  if (mod100 >= 11 && mod100 <= 14) {
    return '$count $many';
  }
  if (mod10 == 1) {
    return '$count $one';
  }
  if (mod10 >= 2 && mod10 <= 4) {
    return '$count $few';
  }
  return '$count $many';
}

bool isSameDay(DateTime first, DateTime second) {
  final a = first.toLocal();
  final b = second.toLocal();
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
