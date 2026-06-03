import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'exercise_image.dart';
import 'exercise_library_screen.dart';
import 'training_formatters.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final WorkoutExercise workoutExercise;
  final List<WorkoutSet> sets;
  final Map<int, List<WorkoutVideo>> videosBySetId;
  final Exercise? libraryExercise;
  final bool canAddSet;
  final VoidCallback onAddSet;
  final ValueChanged<WorkoutSet> onAttachVideo;
  final ValueChanged<WorkoutSet> onOpenVideos;

  const WorkoutExerciseCard({
    super.key,
    required this.workoutExercise,
    required this.sets,
    required this.videosBySetId,
    required this.libraryExercise,
    required this.canAddSet,
    required this.onAddSet,
    required this.onAttachVideo,
    required this.onOpenVideos,
  });

  @override
  Widget build(BuildContext context) {
    final topWeight = sets.isEmpty
        ? null
        : sets.map((set) => set.weight).reduce((a, b) => a > b ? a : b);
    final lastSet = sets.isEmpty ? null : sets.last;
    final exercise = libraryExercise;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: canAddSet ? onAddSet : null,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: softCardDecoration.copyWith(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (exercise != null) ...[
                ExerciseImage(
                  exercise: exercise,
                  height: 190,
                  borderRadius: BorderRadius.circular(18),
                ),
                const SizedBox(height: 14),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      workoutExercise.exerciseName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                    ),
                  ),
                  if (exercise != null)
                    IconButton.filledTonal(
                      tooltip: 'Техника',
                      onPressed: () =>
                          showExerciseTechniqueDialog(context, exercise),
                      icon: const Icon(Icons.play_arrow_rounded),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _ExerciseStat(
                      label: 'Подходы',
                      value: '${sets.length}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ExerciseStat(
                      label: 'Рабочий вес',
                      value: topWeight == null
                          ? '—'
                          : '${formatWeight(topWeight)} кг',
                    ),
                  ),
                ],
              ),
              if (lastSet != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Последний: ${formatWeight(lastSet.weight)} кг x ${formatCount(
                    lastSet.reps,
                    'повторение',
                    'повторения',
                    'повторений',
                  )}',
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              if (sets.isNotEmpty) ...[
                const SizedBox(height: 14),
                for (final set in sets)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SetTile(
                      set: set,
                      videos: videosBySetId[set.id] ?? const [],
                      canAttachVideo: canAddSet,
                      onAttachVideo: () => onAttachVideo(set),
                      onOpenVideos: () => onOpenVideos(set),
                    ),
                  ),
              ],
              if (canAddSet) ...[
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: onAddSet,
                    icon: const Icon(Icons.add_rounded, size: 24),
                    label: Text(
                      sets.isEmpty ? 'Первый подход' : 'Добавить подход',
                    ),
                    style:
                        primaryButtonStyle(
                          background: const Color(0xFFEAF5FF),
                          foreground: AppColors.primaryBlue,
                          radius: 18,
                        ).copyWith(
                          textStyle: const WidgetStatePropertyAll(
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SetTile extends StatelessWidget {
  final WorkoutSet set;
  final List<WorkoutVideo> videos;
  final bool canAttachVideo;
  final VoidCallback onAttachVideo;
  final VoidCallback onOpenVideos;

  const _SetTile({
    required this.set,
    required this.videos,
    required this.canAttachVideo,
    required this.onAttachVideo,
    required this.onOpenVideos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Подход ${set.setIndex}',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${formatWeight(set.weight)} кг x ${formatCount(
                        set.reps,
                        'повторение',
                        'повторения',
                        'повторений',
                      )}',
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if ((set.notes ?? '').trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        set.notes!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: videos.isEmpty ? null : onOpenVideos,
                icon: const Icon(Icons.video_library_rounded),
                label: Text('${videos.length} видео'),
              ),
            ],
          ),
          if (canAttachVideo) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: onAttachVideo,
                icon: const Icon(Icons.video_call_rounded),
                label: const Text('Прикрепить видео к подходу'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: Color(0xFFD7E6FF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ExerciseStat extends StatelessWidget {
  final String label;
  final String value;

  const _ExerciseStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
