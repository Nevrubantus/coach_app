/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:coach_app_client/src/protocol/users/user.dart' as _i3;
import 'package:coach_app_client/src/protocol/training/workout.dart' as _i4;
import 'package:coach_app_client/src/protocol/training/exercise.dart' as _i5;
import 'package:coach_app_client/src/protocol/training/workout_exercise.dart'
    as _i6;
import 'package:coach_app_client/src/protocol/training/workout_set.dart' as _i7;
import 'package:coach_app_client/src/protocol/training/workout_video.dart'
    as _i8;
import 'package:coach_app_client/src/protocol/training/video_comment.dart'
    as _i9;
import 'package:coach_app_client/src/protocol/training/progress_point.dart'
    as _i10;
import 'package:coach_app_client/src/protocol/users/body_weight_entry.dart'
    as _i11;
import 'protocol.dart' as _i12;

/// {@category Endpoint}
class EndpointCoach extends _i1.EndpointRef {
  EndpointCoach(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'coach';

  _i2.Future<_i3.User?> attachAthleteByContact(
    int coachId,
    String contact,
  ) => caller.callServerEndpoint<_i3.User?>(
    'coach',
    'attachAthleteByContact',
    {
      'coachId': coachId,
      'contact': contact,
    },
  );

  _i2.Future<List<_i3.User>> listAthletes(int coachId) =>
      caller.callServerEndpoint<List<_i3.User>>(
        'coach',
        'listAthletes',
        {'coachId': coachId},
      );

  _i2.Future<_i3.User?> getCoachForAthlete(int athleteId) =>
      caller.callServerEndpoint<_i3.User?>(
        'coach',
        'getCoachForAthlete',
        {'athleteId': athleteId},
      );

  _i2.Future<List<_i4.Workout>> listAthleteWorkouts(
    int coachId,
    int athleteId,
  ) => caller.callServerEndpoint<List<_i4.Workout>>(
    'coach',
    'listAthleteWorkouts',
    {
      'coachId': coachId,
      'athleteId': athleteId,
    },
  );

  _i2.Future<_i4.Workout?> createWorkoutForAthlete(
    int coachId,
    int athleteId,
    String title,
    DateTime scheduledAt,
  ) => caller.callServerEndpoint<_i4.Workout?>(
    'coach',
    'createWorkoutForAthlete',
    {
      'coachId': coachId,
      'athleteId': athleteId,
      'title': title,
      'scheduledAt': scheduledAt,
    },
  );

  _i2.Future<_i4.Workout?> updateAthleteWorkout(
    int coachId,
    int workoutId,
    String title,
    DateTime scheduledAt,
    int? durationMinutes,
    String notes,
    bool isCompleted,
  ) => caller.callServerEndpoint<_i4.Workout?>(
    'coach',
    'updateAthleteWorkout',
    {
      'coachId': coachId,
      'workoutId': workoutId,
      'title': title,
      'scheduledAt': scheduledAt,
      'durationMinutes': durationMinutes,
      'notes': notes,
      'isCompleted': isCompleted,
    },
  );

  _i2.Future<bool> deleteAthleteWorkout(
    int coachId,
    int workoutId,
  ) => caller.callServerEndpoint<bool>(
    'coach',
    'deleteAthleteWorkout',
    {
      'coachId': coachId,
      'workoutId': workoutId,
    },
  );
}

/// {@category Endpoint}
class EndpointTraining extends _i1.EndpointRef {
  EndpointTraining(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'training';

  _i2.Future<List<_i5.Exercise>> listExercises() =>
      caller.callServerEndpoint<List<_i5.Exercise>>(
        'training',
        'listExercises',
        {},
      );

  _i2.Future<List<_i4.Workout>> listWorkouts(int userId) =>
      caller.callServerEndpoint<List<_i4.Workout>>(
        'training',
        'listWorkouts',
        {'userId': userId},
      );

  _i2.Future<List<_i4.Workout>> getWorkoutsForMonth(
    int userId,
    DateTime month,
  ) => caller.callServerEndpoint<List<_i4.Workout>>(
    'training',
    'getWorkoutsForMonth',
    {
      'userId': userId,
      'month': month,
    },
  );

  _i2.Future<_i4.Workout?> getUpcomingWorkout(int userId) =>
      caller.callServerEndpoint<_i4.Workout?>(
        'training',
        'getUpcomingWorkout',
        {'userId': userId},
      );

  _i2.Future<_i4.Workout> createWorkout(
    int userId,
    String title,
    DateTime scheduledAt,
  ) => caller.callServerEndpoint<_i4.Workout>(
    'training',
    'createWorkout',
    {
      'userId': userId,
      'title': title,
      'scheduledAt': scheduledAt,
    },
  );

  _i2.Future<_i4.Workout?> updateWorkout(
    int workoutId,
    String title,
    DateTime scheduledAt,
    int? durationMinutes,
    String notes,
    bool isCompleted,
  ) => caller.callServerEndpoint<_i4.Workout?>(
    'training',
    'updateWorkout',
    {
      'workoutId': workoutId,
      'title': title,
      'scheduledAt': scheduledAt,
      'durationMinutes': durationMinutes,
      'notes': notes,
      'isCompleted': isCompleted,
    },
  );

  _i2.Future<bool> deleteWorkout(int workoutId) =>
      caller.callServerEndpoint<bool>(
        'training',
        'deleteWorkout',
        {'workoutId': workoutId},
      );

  _i2.Future<_i6.WorkoutExercise?> addExerciseToWorkout(
    int workoutId,
    int exerciseId,
  ) => caller.callServerEndpoint<_i6.WorkoutExercise?>(
    'training',
    'addExerciseToWorkout',
    {
      'workoutId': workoutId,
      'exerciseId': exerciseId,
    },
  );

  _i2.Future<List<_i6.WorkoutExercise>> listWorkoutExercises(int workoutId) =>
      caller.callServerEndpoint<List<_i6.WorkoutExercise>>(
        'training',
        'listWorkoutExercises',
        {'workoutId': workoutId},
      );

  _i2.Future<_i7.WorkoutSet?> addSet(
    int workoutExerciseId,
    double weight,
    int reps,
    String notes,
  ) => caller.callServerEndpoint<_i7.WorkoutSet?>(
    'training',
    'addSet',
    {
      'workoutExerciseId': workoutExerciseId,
      'weight': weight,
      'reps': reps,
      'notes': notes,
    },
  );

  _i2.Future<List<_i7.WorkoutSet>> listSets(int workoutExerciseId) =>
      caller.callServerEndpoint<List<_i7.WorkoutSet>>(
        'training',
        'listSets',
        {'workoutExerciseId': workoutExerciseId},
      );

  _i2.Future<_i8.WorkoutVideo?> uploadSetVideo(
    int workoutSetId,
    String fileName,
    String base64Data,
  ) => caller.callServerEndpoint<_i8.WorkoutVideo?>(
    'training',
    'uploadSetVideo',
    {
      'workoutSetId': workoutSetId,
      'fileName': fileName,
      'base64Data': base64Data,
    },
  );

  _i2.Future<List<_i8.WorkoutVideo>> listSetVideos(int workoutSetId) =>
      caller.callServerEndpoint<List<_i8.WorkoutVideo>>(
        'training',
        'listSetVideos',
        {'workoutSetId': workoutSetId},
      );

  _i2.Future<List<_i8.WorkoutVideo>> listWorkoutVideos(int workoutId) =>
      caller.callServerEndpoint<List<_i8.WorkoutVideo>>(
        'training',
        'listWorkoutVideos',
        {'workoutId': workoutId},
      );

  _i2.Future<_i9.VideoComment?> addVideoComment(
    int videoId,
    int coachId,
    String text,
  ) => caller.callServerEndpoint<_i9.VideoComment?>(
    'training',
    'addVideoComment',
    {
      'videoId': videoId,
      'coachId': coachId,
      'text': text,
    },
  );

  _i2.Future<List<_i9.VideoComment>> listVideoComments(int videoId) =>
      caller.callServerEndpoint<List<_i9.VideoComment>>(
        'training',
        'listVideoComments',
        {'videoId': videoId},
      );

  _i2.Future<List<_i10.ProgressPoint>> getProgress(
    int userId,
    String? exerciseName,
  ) => caller.callServerEndpoint<List<_i10.ProgressPoint>>(
    'training',
    'getProgress',
    {
      'userId': userId,
      'exerciseName': exerciseName,
    },
  );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i3.User?> getUser(int userId) =>
      caller.callServerEndpoint<_i3.User?>(
        'user',
        'getUser',
        {'userId': userId},
      );

  _i2.Future<_i3.User?> register(_i3.User user) =>
      caller.callServerEndpoint<_i3.User?>(
        'user',
        'register',
        {'user': user},
      );

  _i2.Future<_i3.User?> login(
    String contact,
    String password,
  ) => caller.callServerEndpoint<_i3.User?>(
    'user',
    'login',
    {
      'contact': contact,
      'password': password,
    },
  );

  _i2.Future<_i3.User?> updateProfile(
    int userId,
    String height,
    String weight,
    String age,
  ) => caller.callServerEndpoint<_i3.User?>(
    'user',
    'updateProfile',
    {
      'userId': userId,
      'height': height,
      'weight': weight,
      'age': age,
    },
  );

  _i2.Future<_i3.User?> updateAccount(
    int userId,
    String name,
    String contact,
  ) => caller.callServerEndpoint<_i3.User?>(
    'user',
    'updateAccount',
    {
      'userId': userId,
      'name': name,
      'contact': contact,
    },
  );

  _i2.Future<_i3.User?> uploadProfileImage(
    int userId,
    String fileName,
    String base64Data,
  ) => caller.callServerEndpoint<_i3.User?>(
    'user',
    'uploadProfileImage',
    {
      'userId': userId,
      'fileName': fileName,
      'base64Data': base64Data,
    },
  );

  _i2.Future<_i3.User?> removeProfileImage(int userId) =>
      caller.callServerEndpoint<_i3.User?>(
        'user',
        'removeProfileImage',
        {'userId': userId},
      );

  _i2.Future<_i3.User?> updateProfileImageFrame(
    int userId,
    double scale,
    double offsetX,
    double offsetY,
  ) => caller.callServerEndpoint<_i3.User?>(
    'user',
    'updateProfileImageFrame',
    {
      'userId': userId,
      'scale': scale,
      'offsetX': offsetX,
      'offsetY': offsetY,
    },
  );

  _i2.Future<List<_i11.BodyWeightEntry>> listBodyWeights(int userId) =>
      caller.callServerEndpoint<List<_i11.BodyWeightEntry>>(
        'user',
        'listBodyWeights',
        {'userId': userId},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i12.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    coach = EndpointCoach(this);
    training = EndpointTraining(this);
    user = EndpointUser(this);
  }

  late final EndpointCoach coach;

  late final EndpointTraining training;

  late final EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'coach': coach,
    'training': training,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
