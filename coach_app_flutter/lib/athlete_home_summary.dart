import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'core/app_colors.dart';
import 'training_formatters.dart';

class MotivationBanner extends StatelessWidget {
  final int monthWorkoutCount;

  const MotivationBanner({super.key, required this.monthWorkoutCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appFieldColor(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.bolt_rounded, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              monthWorkoutCount == 0
                  ? 'Сегодня хороший день для первой записи.'
                  : 'В этом месяце уже ${formatCount(
                      monthWorkoutCount,
                      'тренировка',
                      'тренировки',
                      'тренировок',
                    )}.',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryGrid extends StatelessWidget {
  final Workout? upcomingWorkout;
  final List<ProgressPoint> progressPoints;
  final int monthWorkoutCount;
  final String weight;
  final VoidCallback onWorkoutTap;
  final VoidCallback onProgressTap;
  final VoidCallback onAnthropometryTap;

  const SummaryGrid({
    super.key,
    required this.upcomingWorkout,
    required this.progressPoints,
    required this.monthWorkoutCount,
    required this.weight,
    required this.onWorkoutTap,
    required this.onProgressTap,
    required this.onAnthropometryTap,
  });

  @override
  Widget build(BuildContext context) {
    final lastPoint = progressPoints.isEmpty ? null : progressPoints.last;
    final firstPoint = progressPoints.isEmpty ? null : progressPoints.first;
    final delta =
        progressPoints.length < 2 || lastPoint == null || firstPoint == null
        ? null
        : lastPoint.weight - firstPoint.weight;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                icon: Icons.schedule_rounded,
                iconColor: AppColors.primaryBlue,
                value: upcomingWorkout == null
                    ? '—'
                    : formatTime(upcomingWorkout!.scheduledAt),
                label: upcomingWorkout == null
                    ? 'календарь'
                    : formatShortDate(upcomingWorkout!.scheduledAt),
                title: upcomingWorkout?.title ?? 'Новая тренировка',
                onTap: onWorkoutTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                icon: Icons.trending_up_rounded,
                iconColor: Colors.green,
                value: lastPoint == null
                    ? '—'
                    : delta == null
                    ? '${formatWeight(lastPoint.weight)} кг'
                    : '${delta >= 0 ? '+' : ''}${formatWeight(delta)} кг',
                label: lastPoint?.exerciseName ?? 'нет подходов',
                title: 'Рабочий вес',
                onTap: onProgressTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                icon: Icons.check_circle_outline_rounded,
                iconColor: Colors.green,
                value: '$monthWorkoutCount',
                label: 'в этом месяце',
                title: 'Тренировки',
                onTap: onWorkoutTap,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                icon: Icons.monitor_weight_outlined,
                iconColor: AppColors.primaryBlue,
                value: weight.trim().isEmpty ? '—' : '$weight кг',
                label: 'текущий вес',
                title: 'Антропометрия',
                onTap: onAnthropometryTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final String title;
  final VoidCallback onTap;

  const _SummaryCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isAppDark(context)
          ? const Color(0xFF182C34)
          : const Color(0xFFE4FBFF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 106,
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 27),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      label.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isAppDark(context)
                            ? const Color(0xFFB0B3BD)
                            : Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
