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

abstract class WeeklyLoadSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WeeklyLoadSummary._({
    required this.currentVolume,
    required this.previousVolume,
    required this.percentChange,
    required this.currentWorkingSets,
    required this.previousWorkingSets,
    required this.recommendedMinSets,
    required this.recommendedMaxSets,
    this.bestExerciseName,
    required this.bestExerciseDelta,
    required this.bestExerciseCurrentWeight,
    required this.currentWeekStart,
    required this.currentWeekEnd,
  });

  factory WeeklyLoadSummary({
    required double currentVolume,
    required double previousVolume,
    required double percentChange,
    required int currentWorkingSets,
    required int previousWorkingSets,
    required int recommendedMinSets,
    required int recommendedMaxSets,
    String? bestExerciseName,
    required double bestExerciseDelta,
    required double bestExerciseCurrentWeight,
    required DateTime currentWeekStart,
    required DateTime currentWeekEnd,
  }) = _WeeklyLoadSummaryImpl;

  factory WeeklyLoadSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeeklyLoadSummary(
      currentVolume: (jsonSerialization['currentVolume'] as num).toDouble(),
      previousVolume: (jsonSerialization['previousVolume'] as num).toDouble(),
      percentChange: (jsonSerialization['percentChange'] as num).toDouble(),
      currentWorkingSets: jsonSerialization['currentWorkingSets'] as int,
      previousWorkingSets: jsonSerialization['previousWorkingSets'] as int,
      recommendedMinSets: jsonSerialization['recommendedMinSets'] as int,
      recommendedMaxSets: jsonSerialization['recommendedMaxSets'] as int,
      bestExerciseName: jsonSerialization['bestExerciseName'] as String?,
      bestExerciseDelta: (jsonSerialization['bestExerciseDelta'] as num)
          .toDouble(),
      bestExerciseCurrentWeight:
          (jsonSerialization['bestExerciseCurrentWeight'] as num).toDouble(),
      currentWeekStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['currentWeekStart'],
      ),
      currentWeekEnd: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['currentWeekEnd'],
      ),
    );
  }

  double currentVolume;

  double previousVolume;

  double percentChange;

  int currentWorkingSets;

  int previousWorkingSets;

  int recommendedMinSets;

  int recommendedMaxSets;

  String? bestExerciseName;

  double bestExerciseDelta;

  double bestExerciseCurrentWeight;

  DateTime currentWeekStart;

  DateTime currentWeekEnd;

  /// Returns a shallow copy of this [WeeklyLoadSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeeklyLoadSummary copyWith({
    double? currentVolume,
    double? previousVolume,
    double? percentChange,
    int? currentWorkingSets,
    int? previousWorkingSets,
    int? recommendedMinSets,
    int? recommendedMaxSets,
    String? bestExerciseName,
    double? bestExerciseDelta,
    double? bestExerciseCurrentWeight,
    DateTime? currentWeekStart,
    DateTime? currentWeekEnd,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeeklyLoadSummary',
      'currentVolume': currentVolume,
      'previousVolume': previousVolume,
      'percentChange': percentChange,
      'currentWorkingSets': currentWorkingSets,
      'previousWorkingSets': previousWorkingSets,
      'recommendedMinSets': recommendedMinSets,
      'recommendedMaxSets': recommendedMaxSets,
      if (bestExerciseName != null) 'bestExerciseName': bestExerciseName,
      'bestExerciseDelta': bestExerciseDelta,
      'bestExerciseCurrentWeight': bestExerciseCurrentWeight,
      'currentWeekStart': currentWeekStart.toJson(),
      'currentWeekEnd': currentWeekEnd.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WeeklyLoadSummary',
      'currentVolume': currentVolume,
      'previousVolume': previousVolume,
      'percentChange': percentChange,
      'currentWorkingSets': currentWorkingSets,
      'previousWorkingSets': previousWorkingSets,
      'recommendedMinSets': recommendedMinSets,
      'recommendedMaxSets': recommendedMaxSets,
      if (bestExerciseName != null) 'bestExerciseName': bestExerciseName,
      'bestExerciseDelta': bestExerciseDelta,
      'bestExerciseCurrentWeight': bestExerciseCurrentWeight,
      'currentWeekStart': currentWeekStart.toJson(),
      'currentWeekEnd': currentWeekEnd.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeeklyLoadSummaryImpl extends WeeklyLoadSummary {
  _WeeklyLoadSummaryImpl({
    required double currentVolume,
    required double previousVolume,
    required double percentChange,
    required int currentWorkingSets,
    required int previousWorkingSets,
    required int recommendedMinSets,
    required int recommendedMaxSets,
    String? bestExerciseName,
    required double bestExerciseDelta,
    required double bestExerciseCurrentWeight,
    required DateTime currentWeekStart,
    required DateTime currentWeekEnd,
  }) : super._(
         currentVolume: currentVolume,
         previousVolume: previousVolume,
         percentChange: percentChange,
         currentWorkingSets: currentWorkingSets,
         previousWorkingSets: previousWorkingSets,
         recommendedMinSets: recommendedMinSets,
         recommendedMaxSets: recommendedMaxSets,
         bestExerciseName: bestExerciseName,
         bestExerciseDelta: bestExerciseDelta,
         bestExerciseCurrentWeight: bestExerciseCurrentWeight,
         currentWeekStart: currentWeekStart,
         currentWeekEnd: currentWeekEnd,
       );

  /// Returns a shallow copy of this [WeeklyLoadSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeeklyLoadSummary copyWith({
    double? currentVolume,
    double? previousVolume,
    double? percentChange,
    int? currentWorkingSets,
    int? previousWorkingSets,
    int? recommendedMinSets,
    int? recommendedMaxSets,
    Object? bestExerciseName = _Undefined,
    double? bestExerciseDelta,
    double? bestExerciseCurrentWeight,
    DateTime? currentWeekStart,
    DateTime? currentWeekEnd,
  }) {
    return WeeklyLoadSummary(
      currentVolume: currentVolume ?? this.currentVolume,
      previousVolume: previousVolume ?? this.previousVolume,
      percentChange: percentChange ?? this.percentChange,
      currentWorkingSets: currentWorkingSets ?? this.currentWorkingSets,
      previousWorkingSets: previousWorkingSets ?? this.previousWorkingSets,
      recommendedMinSets: recommendedMinSets ?? this.recommendedMinSets,
      recommendedMaxSets: recommendedMaxSets ?? this.recommendedMaxSets,
      bestExerciseName: bestExerciseName is String?
          ? bestExerciseName
          : this.bestExerciseName,
      bestExerciseDelta: bestExerciseDelta ?? this.bestExerciseDelta,
      bestExerciseCurrentWeight:
          bestExerciseCurrentWeight ?? this.bestExerciseCurrentWeight,
      currentWeekStart: currentWeekStart ?? this.currentWeekStart,
      currentWeekEnd: currentWeekEnd ?? this.currentWeekEnd,
    );
  }
}
