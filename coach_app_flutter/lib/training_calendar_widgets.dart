import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'training_formatters.dart';

class NewWorkoutCard extends StatelessWidget {
  final VoidCallback onTap;

  const NewWorkoutCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_rounded, size: 32),
        label: const Text('Новая тренировка'),
        style: primaryButtonStyle(radius: 22).copyWith(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class CalendarCard extends StatelessWidget {
  final DateTime month;
  final DateTime selectedDate;
  final List<Workout> workouts;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarCard({
    super.key,
    required this.month,
    required this.selectedDate,
    required this.workouts,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final leadingCells = firstDay.weekday - 1;
    final totalCells = leadingCells + daysInMonth;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
      decoration: softCardDecoration(context),
      child: Column(
        children: [
          const Row(
            children: [
              _WeekdayLabel('ПН'),
              _WeekdayLabel('ВТ'),
              _WeekdayLabel('СР'),
              _WeekdayLabel('ЧТ'),
              _WeekdayLabel('ПТ'),
              _WeekdayLabel('СБ'),
              _WeekdayLabel('ВС'),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              if (index < leadingCells) return const SizedBox.shrink();

              final day = index - leadingCells + 1;
              final date = DateTime(month.year, month.month, day);
              final isSelected = isSameDay(date, selectedDate);
              final hasWorkout = workouts.any(
                (workout) => isSameDay(workout.scheduledAt, date),
              );

              return _CalendarDay(
                day: day,
                isSelected: isSelected,
                hasWorkout: hasWorkout,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WorkoutScheduleCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutScheduleCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE4FBFF),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  workout.isCompleted
                      ? Icons.check_rounded
                      : Icons.schedule_rounded,
                  color: workout.isCompleted
                      ? Colors.green
                      : AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _workoutSubtitle(workout),
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 13,
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
        ),
      ),
    );
  }

  String _workoutSubtitle(Workout workout) {
    final time = formatTime(workout.scheduledAt);
    final duration = workout.durationMinutes;
    if (duration == null) return time;
    return '$time · $duration мин';
  }
}

class EmptyScheduleCard extends StatelessWidget {
  const EmptyScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: softCardDecoration(context),
      child: const Center(
        child: Text(
          'На выбранную дату тренировок нет',
          style: TextStyle(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;

  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool hasWorkout;
  final VoidCallback onTap;

  const _CalendarDay({
    required this.day,
    required this.isSelected,
    required this.hasWorkout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primaryBlue : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (hasWorkout)
              Positioned(
                bottom: 5,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
