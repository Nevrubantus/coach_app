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
import 'package:serverpod/serverpod.dart' as _i1;
import '../coaches/coach_endpoint.dart' as _i2;
import '../training/training_endpoint.dart' as _i3;
import '../users/user_endpoint.dart' as _i4;
import 'package:coach_app_server/src/generated/users/user.dart' as _i5;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'coach': _i2.CoachEndpoint()
        ..initialize(
          server,
          'coach',
          null,
        ),
      'training': _i3.TrainingEndpoint()
        ..initialize(
          server,
          'training',
          null,
        ),
      'user': _i4.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['coach'] = _i1.EndpointConnector(
      name: 'coach',
      endpoint: endpoints['coach']!,
      methodConnectors: {
        'attachAthleteByContact': _i1.MethodConnector(
          name: 'attachAthleteByContact',
          params: {
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'contact': _i1.ParameterDescription(
              name: 'contact',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['coach'] as _i2.CoachEndpoint)
                  .attachAthleteByContact(
                    session,
                    params['coachId'],
                    params['contact'],
                  ),
        ),
        'listAthletes': _i1.MethodConnector(
          name: 'listAthletes',
          params: {
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['coach'] as _i2.CoachEndpoint).listAthletes(
                session,
                params['coachId'],
              ),
        ),
        'getCoachForAthlete': _i1.MethodConnector(
          name: 'getCoachForAthlete',
          params: {
            'athleteId': _i1.ParameterDescription(
              name: 'athleteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['coach'] as _i2.CoachEndpoint).getCoachForAthlete(
                    session,
                    params['athleteId'],
                  ),
        ),
        'listAthleteWorkouts': _i1.MethodConnector(
          name: 'listAthleteWorkouts',
          params: {
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'athleteId': _i1.ParameterDescription(
              name: 'athleteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['coach'] as _i2.CoachEndpoint).listAthleteWorkouts(
                    session,
                    params['coachId'],
                    params['athleteId'],
                  ),
        ),
        'createWorkoutForAthlete': _i1.MethodConnector(
          name: 'createWorkoutForAthlete',
          params: {
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'athleteId': _i1.ParameterDescription(
              name: 'athleteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['coach'] as _i2.CoachEndpoint)
                  .createWorkoutForAthlete(
                    session,
                    params['coachId'],
                    params['athleteId'],
                    params['title'],
                    params['scheduledAt'],
                  ),
        ),
        'updateAthleteWorkout': _i1.MethodConnector(
          name: 'updateAthleteWorkout',
          params: {
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isCompleted': _i1.ParameterDescription(
              name: 'isCompleted',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['coach'] as _i2.CoachEndpoint)
                  .updateAthleteWorkout(
                    session,
                    params['coachId'],
                    params['workoutId'],
                    params['title'],
                    params['scheduledAt'],
                    params['durationMinutes'],
                    params['notes'],
                    params['isCompleted'],
                  ),
        ),
        'deleteAthleteWorkout': _i1.MethodConnector(
          name: 'deleteAthleteWorkout',
          params: {
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['coach'] as _i2.CoachEndpoint)
                  .deleteAthleteWorkout(
                    session,
                    params['coachId'],
                    params['workoutId'],
                  ),
        ),
      },
    );
    connectors['training'] = _i1.EndpointConnector(
      name: 'training',
      endpoint: endpoints['training']!,
      methodConnectors: {
        'listExercises': _i1.MethodConnector(
          name: 'listExercises',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .listExercises(session),
        ),
        'listWorkouts': _i1.MethodConnector(
          name: 'listWorkouts',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).listWorkouts(
                    session,
                    params['userId'],
                  ),
        ),
        'getWorkoutsForMonth': _i1.MethodConnector(
          name: 'getWorkoutsForMonth',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .getWorkoutsForMonth(
                    session,
                    params['userId'],
                    params['month'],
                  ),
        ),
        'getUpcomingWorkout': _i1.MethodConnector(
          name: 'getUpcomingWorkout',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .getUpcomingWorkout(
                    session,
                    params['userId'],
                  ),
        ),
        'createWorkout': _i1.MethodConnector(
          name: 'createWorkout',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).createWorkout(
                    session,
                    params['userId'],
                    params['title'],
                    params['scheduledAt'],
                  ),
        ),
        'updateWorkout': _i1.MethodConnector(
          name: 'updateWorkout',
          params: {
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isCompleted': _i1.ParameterDescription(
              name: 'isCompleted',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).updateWorkout(
                    session,
                    params['workoutId'],
                    params['title'],
                    params['scheduledAt'],
                    params['durationMinutes'],
                    params['notes'],
                    params['isCompleted'],
                  ),
        ),
        'deleteWorkout': _i1.MethodConnector(
          name: 'deleteWorkout',
          params: {
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).deleteWorkout(
                    session,
                    params['workoutId'],
                  ),
        ),
        'addExerciseToWorkout': _i1.MethodConnector(
          name: 'addExerciseToWorkout',
          params: {
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'exerciseId': _i1.ParameterDescription(
              name: 'exerciseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .addExerciseToWorkout(
                    session,
                    params['workoutId'],
                    params['exerciseId'],
                  ),
        ),
        'listWorkoutExercises': _i1.MethodConnector(
          name: 'listWorkoutExercises',
          params: {
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .listWorkoutExercises(
                    session,
                    params['workoutId'],
                  ),
        ),
        'addSet': _i1.MethodConnector(
          name: 'addSet',
          params: {
            'workoutExerciseId': _i1.ParameterDescription(
              name: 'workoutExerciseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'weight': _i1.ParameterDescription(
              name: 'weight',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'reps': _i1.ParameterDescription(
              name: 'reps',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint).addSet(
                session,
                params['workoutExerciseId'],
                params['weight'],
                params['reps'],
                params['notes'],
              ),
        ),
        'listSets': _i1.MethodConnector(
          name: 'listSets',
          params: {
            'workoutExerciseId': _i1.ParameterDescription(
              name: 'workoutExerciseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).listSets(
                    session,
                    params['workoutExerciseId'],
                  ),
        ),
        'uploadSetVideo': _i1.MethodConnector(
          name: 'uploadSetVideo',
          params: {
            'workoutSetId': _i1.ParameterDescription(
              name: 'workoutSetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'base64Data': _i1.ParameterDescription(
              name: 'base64Data',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .uploadSetVideo(
                    session,
                    params['workoutSetId'],
                    params['fileName'],
                    params['base64Data'],
                  ),
        ),
        'listSetVideos': _i1.MethodConnector(
          name: 'listSetVideos',
          params: {
            'workoutSetId': _i1.ParameterDescription(
              name: 'workoutSetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).listSetVideos(
                    session,
                    params['workoutSetId'],
                  ),
        ),
        'listWorkoutVideos': _i1.MethodConnector(
          name: 'listWorkoutVideos',
          params: {
            'workoutId': _i1.ParameterDescription(
              name: 'workoutId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .listWorkoutVideos(
                    session,
                    params['workoutId'],
                  ),
        ),
        'addVideoComment': _i1.MethodConnector(
          name: 'addVideoComment',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'coachId': _i1.ParameterDescription(
              name: 'coachId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .addVideoComment(
                    session,
                    params['videoId'],
                    params['coachId'],
                    params['text'],
                  ),
        ),
        'listVideoComments': _i1.MethodConnector(
          name: 'listVideoComments',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['training'] as _i3.TrainingEndpoint)
                  .listVideoComments(
                    session,
                    params['videoId'],
                  ),
        ),
        'getProgress': _i1.MethodConnector(
          name: 'getProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'exerciseName': _i1.ParameterDescription(
              name: 'exerciseName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['training'] as _i3.TrainingEndpoint).getProgress(
                    session,
                    params['userId'],
                    params['exerciseName'],
                  ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i4.UserEndpoint).getUser(
                session,
                params['userId'],
              ),
        ),
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'user': _i1.ParameterDescription(
              name: 'user',
              type: _i1.getType<_i5.User>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i4.UserEndpoint).register(
                session,
                params['user'],
              ),
        ),
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'contact': _i1.ParameterDescription(
              name: 'contact',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i4.UserEndpoint).login(
                session,
                params['contact'],
                params['password'],
              ),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'height': _i1.ParameterDescription(
              name: 'height',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'weight': _i1.ParameterDescription(
              name: 'weight',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'age': _i1.ParameterDescription(
              name: 'age',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i4.UserEndpoint).updateProfile(
                session,
                params['userId'],
                params['height'],
                params['weight'],
                params['age'],
              ),
        ),
        'updateAccount': _i1.MethodConnector(
          name: 'updateAccount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'contact': _i1.ParameterDescription(
              name: 'contact',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i4.UserEndpoint).updateAccount(
                session,
                params['userId'],
                params['name'],
                params['contact'],
              ),
        ),
        'uploadProfileImage': _i1.MethodConnector(
          name: 'uploadProfileImage',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'base64Data': _i1.ParameterDescription(
              name: 'base64Data',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i4.UserEndpoint).uploadProfileImage(
                    session,
                    params['userId'],
                    params['fileName'],
                    params['base64Data'],
                  ),
        ),
        'removeProfileImage': _i1.MethodConnector(
          name: 'removeProfileImage',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i4.UserEndpoint).removeProfileImage(
                    session,
                    params['userId'],
                  ),
        ),
        'updateProfileImageFrame': _i1.MethodConnector(
          name: 'updateProfileImageFrame',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scale': _i1.ParameterDescription(
              name: 'scale',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'offsetX': _i1.ParameterDescription(
              name: 'offsetX',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'offsetY': _i1.ParameterDescription(
              name: 'offsetY',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i4.UserEndpoint)
                  .updateProfileImageFrame(
                    session,
                    params['userId'],
                    params['scale'],
                    params['offsetX'],
                    params['offsetY'],
                  ),
        ),
        'listBodyWeights': _i1.MethodConnector(
          name: 'listBodyWeights',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i4.UserEndpoint).listBodyWeights(
                    session,
                    params['userId'],
                  ),
        ),
      },
    );
  }
}
