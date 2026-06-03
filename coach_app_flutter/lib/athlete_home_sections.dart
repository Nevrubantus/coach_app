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
        decoration: softCardDecoration,
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
        decoration: softCardDecoration,
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
      decoration: softCardDecoration,
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
