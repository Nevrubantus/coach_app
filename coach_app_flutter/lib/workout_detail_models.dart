class SetInput {
  final double weight;
  final int reps;
  final String notes;

  const SetInput({
    required this.weight,
    required this.reps,
    required this.notes,
  });
}

class WorkoutInput {
  final String title;
  final DateTime scheduledAt;
  final int? durationMinutes;
  final String notes;

  const WorkoutInput({
    required this.title,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.notes,
  });
}

