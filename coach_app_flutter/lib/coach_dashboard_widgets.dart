part of 'coach_dashboard_screen.dart';

class _CoachHomePage extends StatelessWidget {
  final String coachName;
  final TextEditingController contactController;
  final List<User> athletes;
  final bool isLoading;
  final bool isAttaching;
  final String? loadError;
  final Future<void> Function() onRefresh;
  final VoidCallback onAttach;
  final ValueChanged<User> onAthleteTap;

  const _CoachHomePage({
    required this.coachName,
    required this.contactController,
    required this.athletes,
    required this.isLoading,
    required this.isAttaching,
    required this.loadError,
    required this.onRefresh,
    required this.onAttach,
    required this.onAthleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
        children: [
          Text(
            'Тренер: $coachName',
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: softCardDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Закрепить спортсмена',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  decoration: appInputDecoration(
                    'Телефон или email спортсмена',
                    icon: Icons.search_rounded,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: isAttaching ? null : onAttach,
                    icon: const Icon(Icons.person_add_alt_1_rounded),
                    label: Text(
                      isAttaching ? 'Ищем...' : 'Закрепить спортсмена',
                    ),
                    style: primaryButtonStyle(radius: 16),
                  ),
                ),
              ],
            ),
          ),
          if (loadError != null) ...[
            const SizedBox(height: 12),
            ServerProblemCard(message: loadError!, onRetry: onRefresh),
          ],
          const SizedBox(height: 24),
          const Text(
            'Мои спортсмены',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (athletes.isEmpty)
            const _EmptyCoachCard()
          else
            for (final athlete in athletes)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AthleteTile(
                  athlete: athlete,
                  onTap: () => onAthleteTap(athlete),
                ),
              ),
        ],
      ),
    );
  }
}

class _CoachWorkoutsPage extends StatelessWidget {
  final User? athlete;
  final List<Workout> workouts;
  final List<ProgressPoint> progress;
  final List<Workout> upcomingWorkouts;
  final List<Workout> pastWorkouts;
  final bool isLoading;
  final String? error;
  final Future<void> Function() onRefresh;
  final VoidCallback onCreateWorkout;
  final ValueChanged<Workout> onWorkoutTap;
  final VoidCallback onBackToAthletes;

  const _CoachWorkoutsPage({
    required this.athlete,
    required this.workouts,
    required this.progress,
    required this.upcomingWorkouts,
    required this.pastWorkouts,
    required this.isLoading,
    required this.error,
    required this.onRefresh,
    required this.onCreateWorkout,
    required this.onWorkoutTap,
    required this.onBackToAthletes,
  });

  @override
  Widget build(BuildContext context) {
    final athlete = this.athlete;
    if (athlete == null) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(22, 40, 22, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: softCardDecoration,
            child: Column(
              children: [
                const Icon(
                  Icons.groups_rounded,
                  color: AppColors.primaryBlue,
                  size: 38,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Выберите спортсмена на главной',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Text(
                  'После выбора здесь появятся его предстоящие и прошедшие тренировки.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onBackToAthletes,
                    style: primaryButtonStyle(radius: 16),
                    child: const Text('К спортсменам'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 90),
        children: [
          _SelectedAthleteHeader(athlete: athlete),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: onCreateWorkout,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Назначить новую тренировку'),
              style: primaryButtonStyle(radius: 16),
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            ServerProblemCard(message: error!, onRetry: onRefresh),
          ],
          const SizedBox(height: 18),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            _ProgressPreview(points: progress),
            const SizedBox(height: 24),
            _WorkoutSection(
              title: 'Предстоящие тренировки',
              emptyText: 'Нет назначенных тренировок',
              workouts: upcomingWorkouts,
              actionLabel: 'Редактировать',
              onTap: onWorkoutTap,
            ),
            const SizedBox(height: 24),
            _WorkoutSection(
              title: 'Прошедшие тренировки',
              emptyText: 'История пока пустая',
              workouts: pastWorkouts,
              actionLabel: 'Видео и комментарии',
              onTap: onWorkoutTap,
            ),
          ],
        ],
      ),
    );
  }
}

class _SelectedAthleteHeader extends StatelessWidget {
  final User athlete;

  const _SelectedAthleteHeader({required this.athlete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: softCardDecoration,
      child: Row(
        children: [
          AvatarPreview(
            imagePath: athlete.imagePath,
            radius: 24,
            scale: athlete.imageScale ?? 1,
            offsetX: athlete.imageOffsetX ?? 0,
            offsetY: athlete.imageOffsetY ?? 0,
            fallbackText: _initialsFor(athlete.name),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  athlete.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  athlete.contact,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressPreview extends StatelessWidget {
  final List<ProgressPoint> points;

  const _ProgressPreview({required this.points});

  @override
  Widget build(BuildContext context) {
    final title = points.isEmpty
        ? 'Динамика рабочего веса'
        : points.last.exerciseName;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: softCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          WorkingWeightChart(
            points: points
                .map(
                  (point) => ChartPoint(
                    date: point.date,
                    value: point.weight,
                  ),
                )
                .toList(),
            height: 160,
          ),
        ],
      ),
    );
  }
}

class _WorkoutSection extends StatelessWidget {
  final String title;
  final String emptyText;
  final String actionLabel;
  final List<Workout> workouts;
  final ValueChanged<Workout> onTap;

  const _WorkoutSection({
    required this.title,
    required this.emptyText,
    required this.actionLabel,
    required this.workouts,
    required this.onTap,
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
        const SizedBox(height: 12),
        if (workouts.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: softCardDecoration,
            child: Text(
              emptyText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textGrey,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          for (final workout in workouts)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  onTap: () => onTap(workout),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: softCardDecoration,
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF5FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.fitness_center_rounded,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workout.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatWorkoutDateTime(workout.scheduledAt),
                                style: const TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                actionLabel,
                                style: const TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

class _AthleteTile extends StatelessWidget {
  final User athlete;
  final VoidCallback onTap;

  const _AthleteTile({
    required this.athlete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: softCardDecoration,
          child: Row(
            children: [
              AvatarPreview(
                imagePath: athlete.imagePath,
                radius: 20,
                scale: athlete.imageScale ?? 1,
                offsetX: athlete.imageOffsetX ?? 0,
                offsetY: athlete.imageOffsetY ?? 0,
                fallbackText: _initialsFor(athlete.name),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      athlete.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      athlete.contact,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCoachCard extends StatelessWidget {
  const _EmptyCoachCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: softCardDecoration,
      child: const Text(
        'Добавьте первого спортсмена по телефону или email.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textGrey,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

String _initialsFor(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'А';
  final first = parts.first.substring(0, 1);
  final second = parts.length > 1 ? parts[1].substring(0, 1) : '';
  return '$first$second'.toUpperCase();
}
