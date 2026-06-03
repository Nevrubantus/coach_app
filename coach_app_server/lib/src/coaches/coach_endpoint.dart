import '../generated/protocol.dart';
import '../training/workout_delete_helper.dart';
import 'package:serverpod/serverpod.dart';

class CoachEndpoint extends Endpoint {
  Future<User?> attachAthleteByContact(
    Session session,
    int coachId,
    String contact,
  ) async {
    final coach = await User.db.findById(session, coachId);
    if (coach == null || coach.isAthlete) return null;

    final athlete = await User.db.findFirstRow(
      session,
      where: (t) =>
          t.contact.equals(contact.trim().toLowerCase()) &
          t.isAthlete.equals(true),
    );
    if (athlete == null) return null;

    final existing = await CoachAthlete.db.findFirstRow(
      session,
      where: (t) => t.coachId.equals(coachId) & t.athleteId.equals(athlete.id!),
    );

    if (existing == null) {
      await CoachAthlete.db.insertRow(
        session,
        CoachAthlete(
          coachId: coachId,
          athleteId: athlete.id!,
          createdAt: DateTime.now().toUtc(),
        ),
      );
    }

    return athlete;
  }

  Future<List<User>> listAthletes(Session session, int coachId) async {
    final coach = await User.db.findById(session, coachId);
    if (coach == null || coach.isAthlete) return [];

    final links = await CoachAthlete.db.find(
      session,
      where: (t) => t.coachId.equals(coachId),
      orderBy: (t) => t.createdAt,
    );

    final athletes = <User>[];
    for (final link in links) {
      final athlete = await User.db.findById(session, link.athleteId);
      if (athlete != null && athlete.isAthlete) athletes.add(athlete);
    }

    athletes.sort((a, b) => a.name.compareTo(b.name));
    return athletes;
  }

  Future<User?> getCoachForAthlete(
    Session session,
    int athleteId,
  ) async {
    final athlete = await User.db.findById(session, athleteId);
    if (athlete == null || !athlete.isAthlete) return null;

    final link = await CoachAthlete.db.findFirstRow(
      session,
      where: (t) => t.athleteId.equals(athleteId),
      orderBy: (t) => t.createdAt,
    );
    if (link == null) return null;

    final coach = await User.db.findById(session, link.coachId);
    if (coach == null || coach.isAthlete) return null;
    return coach;
  }

  Future<List<Workout>> listAthleteWorkouts(
    Session session,
    int coachId,
    int athleteId,
  ) async {
    if (!await _hasAthleteAccess(session, coachId, athleteId)) return [];

    final workouts = await Workout.db.find(
      session,
      where: (t) => t.userId.equals(athleteId),
      orderBy: (t) => t.scheduledAt,
    );

    workouts.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return workouts;
  }

  Future<Workout?> createWorkoutForAthlete(
    Session session,
    int coachId,
    int athleteId,
    String title,
    DateTime scheduledAt,
  ) async {
    if (!await _hasAthleteAccess(session, coachId, athleteId)) return null;

    return Workout.db.insertRow(
      session,
      Workout(
        userId: athleteId,
        title: title.trim().isEmpty ? 'Новая тренировка' : title.trim(),
        scheduledAt: scheduledAt.toUtc(),
        isCompleted: false,
      ),
    );
  }

  Future<Workout?> updateAthleteWorkout(
    Session session,
    int coachId,
    int workoutId,
    String title,
    DateTime scheduledAt,
    int? durationMinutes,
    String notes,
    bool isCompleted,
  ) async {
    final workout = await Workout.db.findById(session, workoutId);
    if (workout == null) return null;
    if (!await _hasAthleteAccess(session, coachId, workout.userId)) return null;

    return Workout.db.updateRow(
      session,
      workout.copyWith(
        title: title.trim().isEmpty ? workout.title : title.trim(),
        scheduledAt: scheduledAt.toUtc(),
        durationMinutes: durationMinutes,
        notes: notes.trim().isEmpty ? null : notes.trim(),
        isCompleted: isCompleted,
      ),
    );
  }

  Future<bool> deleteAthleteWorkout(
    Session session,
    int coachId,
    int workoutId,
  ) async {
    final workout = await Workout.db.findById(session, workoutId);
    if (workout == null) return false;
    if (!await _hasAthleteAccess(session, coachId, workout.userId)) {
      return false;
    }

    return deleteWorkoutCascade(session, workoutId);
  }

  Future<bool> _hasAthleteAccess(
    Session session,
    int coachId,
    int athleteId,
  ) async {
    final coach = await User.db.findById(session, coachId);
    if (coach == null || coach.isAthlete) return false;

    final athlete = await User.db.findById(session, athleteId);
    if (athlete == null || !athlete.isAthlete) return false;

    final link = await CoachAthlete.db.findFirstRow(
      session,
      where: (t) => t.coachId.equals(coachId) & t.athleteId.equals(athleteId),
    );
    return link != null;
  }
}
