import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'progress_chart.dart';
import 'training_formatters.dart';

class UpcomingWorkoutSection extends StatelessWidget {
  final Workout? workout;
  final bool isLoading;
  final VoidCallback onTap;
  final VoidCallback onCreateTap;

  const UpcomingWorkoutSection({
    super.key,
    required this.workout,
    required this.isLoading,
    required this.onTap,
    required this.onCreateTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'Предстоящая тренировка',
      child: Container(
        decoration: softCardDecoration(context),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: workout == null ? onCreateTap : onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF5FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.fitness_center_rounded,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: isLoading
                        ? const LinearProgressIndicator(minHeight: 3)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workout?.title ?? 'Новая тренировка',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                workout == null
                                    ? 'Открыть календарь'
                                    : formatWorkoutDateTime(
                                        workout!.scheduledAt,
                                      ),
                                style: const TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                  ),
                  if (workout != null)
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textGrey,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressSection extends StatelessWidget {
  final List<ProgressPoint> points;
  final bool isLoading;

  const ProgressSection({
    super.key,
    required this.points,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final exerciseName = points.isEmpty ? null : points.last.exerciseName;
    final delta = points.length < 2
        ? null
        : points.last.weight - points.first.weight;

    return _SectionContainer(
      title: 'Анализ прогресса рабочего веса',
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        decoration: softCardDecoration(context),
        child: isLoading
            ? const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exerciseName ?? 'Рабочий вес',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (delta != null)
                        Text(
                          '${delta >= 0 ? '+' : ''}${formatWeight(delta)} кг',
                          style: TextStyle(
                            color: delta >= 0 ? Colors.green : Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  WorkingWeightChart(
                    points: points
                        .map(
                          (point) =>
                              ChartPoint(date: point.date, value: point.weight),
                        )
                        .toList(),
                    height: 150,
                  ),
                ],
              ),
      ),
    );
  }
}

class WeeklyLoadSection extends StatelessWidget {
  final WeeklyLoadSummary? summary;
  final bool isLoading;

  const WeeklyLoadSection({
    super.key,
    required this.summary,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final data = summary;
    final hasData = data != null && data.currentWorkingSets > 0;
    final percent = data == null ? 0.0 : data.percentChange;
    final percentColor = percent >= 0 ? Colors.green : Colors.redAccent;
    final percentText = data == null
        ? ''
        : data.previousVolume <= 0
        ? 'первая неделя с данными'
        : '${_formatSignedPercent(percent)} к прошлой неделе';
    final bestExercise = data?.bestExerciseName?.trim();

    return _SectionContainer(
      title: 'Нагрузка недели',
      child: Container(
        decoration: softCardDecoration(context),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _showWeeklyLoadInfo(context),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF5FF),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.analytics_rounded,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasData
                                  ? 'Всего: ${_formatVolume(data.currentVolume)} кг'
                                  : isLoading
                                  ? 'Считаем нагрузку...'
                                  : 'Данных пока нет',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hasData
                                  ? percentText
                                  : 'Добавьте рабочие подходы в тренировке',
                              style: TextStyle(
                                color: hasData
                                    ? percentColor
                                    : AppColors.textGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textGrey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _LoadChip(
                        label: 'Рабочие подходы',
                        value: data == null
                            ? '-'
                            : '${data.currentWorkingSets}',
                      ),
                      const SizedBox(width: 10),
                      _LoadChip(
                        label: 'Ориентир/группа',
                        value: data == null
                            ? '10-20'
                            : '${data.recommendedMinSets}-${data.recommendedMaxSets}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Самый прогрессирующий:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bestExercise == null || bestExercise.isEmpty
                        ? 'Появится после двух недель записей'
                        : '$bestExercise ${_formatSignedWeight(data!.bestExerciseDelta)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showWeeklyLoadInfo(BuildContext context) {
    showAppBottomSheet(
      context,
      const _WeeklyLoadInfoSheet(),
    );
  }
}

class _LoadChip extends StatelessWidget {
  final String label;
  final String value;

  const _LoadChip({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyLoadInfoSheet extends StatelessWidget {
  const _WeeklyLoadInfoSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Что такое нагрузка недели?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            const _InfoParagraph(
              text:
                  'Недельный объём показывает, сколько работы вы сделали за 7 дней. Он считается просто: вес умножается на повторы во всех рабочих подходах.',
            ),
            const _InfoParagraph(
              text:
                  'Рабочий подход — это подход, где есть реальный вес и количество повторений. Разминка и пустые записи в расчёт не попадают.',
            ),
            const _InfoParagraph(
              text:
                  'Для роста мышц важна постепенная прогрессия: объём и количество рабочих подходов должны расти постепенно, без резких скачков. Поэтому приложение сравнивает текущую неделю с прошлой.',
            ),
            const _InfoParagraph(
              text:
                  'В исследованиях по гипертрофии часто используют ориентир 10-20 рабочих подходов на мышечную группу в неделю. В этом блоке показан общий недельный счётчик, чтобы быстро видеть динамику нагрузки.',
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: primaryButtonStyle(radius: 16),
                child: const Text(
                  'Понятно',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoParagraph extends StatelessWidget {
  final String text;

  const _InfoParagraph({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 14,
          height: 1.35,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

String _formatVolume(double value) {
  final rounded = value.round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < rounded.length; i++) {
    final positionFromEnd = rounded.length - i;
    buffer.write(rounded[i]);
    if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
      buffer.write(' ');
    }
  }
  return buffer.toString();
}

String _formatSignedPercent(double value) {
  final sign = value >= 0 ? '+' : '';
  return '$sign${formatWeight(value)}%';
}

String _formatSignedWeight(double value) {
  if (value == 0) return 'без сравнения';
  final sign = value >= 0 ? '+' : '';
  return '$sign${formatWeight(value)} кг';
}

class AnthropometrySection extends StatelessWidget {
  final String height;
  final String weight;
  final String age;

  const AnthropometrySection({
    super.key,
    required this.height,
    required this.weight,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'Антропометрия',
      child: Row(
        children: [
          Expanded(
            child: _MetricCard(
              label: 'Рост',
              value: height.trim().isEmpty ? '—' : height,
              unit: 'см',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _MetricCard(
              label: 'Вес',
              value: weight.trim().isEmpty ? '—' : weight,
              unit: 'кг',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _MetricCard(
              label: 'Возраст',
              value: age.trim().isEmpty ? '—' : age,
              unit: 'лет',
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(12),
      decoration: softCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4),
                Text(unit, style: const TextStyle(color: AppColors.textGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionContainer({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        child,
      ],
    );
  }
}
