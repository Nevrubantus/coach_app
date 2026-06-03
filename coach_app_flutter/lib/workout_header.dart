import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'training_formatters.dart';

class WorkoutHeader extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutHeader({
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
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  workout.isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.schedule_rounded,
                  color: workout.isCompleted
                      ? Colors.green
                      : AppColors.primaryBlue,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      formatWorkoutDateTime(workout.scheduledAt),
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 14,
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

class AddExerciseCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddExerciseCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_rounded, size: 30),
        label: const Text('Добавить упражнение'),
        style: primaryButtonStyle().copyWith(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class EmptyWorkoutCard extends StatelessWidget {
  const EmptyWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: softCardDecoration(context).copyWith(
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Center(
        child: Text(
          'Добавьте первое упражнение',
          style: TextStyle(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
