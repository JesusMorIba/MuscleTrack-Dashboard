import 'package:muscletrack_admin_dashboard/models/local/muscle_category.dart';

class HybridExercise {
  final String exerciseId;
  final String title;
  final String? imageUrl;
  final MuscleCategory category;
  final int? sets;
  final int? repetitions;
  final int? time;
  final String? timeUnit;

  HybridExercise({
    required this.exerciseId,
    required this.title,
    required this.category,
    this.sets,
    this.repetitions,
    this.time,
    this.timeUnit,
    this.imageUrl,
  });

  HybridExercise copyWith({
    String? exerciseId,
    String? title,
    MuscleCategory? category,
    int? sets,
    int? repetitions,
    int? time,
    String? timeUnit,
    String? imageUrl,
  }) {
    return HybridExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      title: title ?? this.title,
      category: category ?? this.category,
      sets: sets ?? this.sets,
      repetitions: repetitions ?? this.repetitions,
      time: time ?? this.time,
      timeUnit: timeUnit ?? this.timeUnit,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'HybridExercise(exerciseId: $exerciseId, title: $title, category: ${category.displayName}, sets: $sets, repetitions: $repetitions, time: $time, timeUnit: $timeUnit, imageUrl: $imageUrl)';
  }

  Map<String, dynamic> toExercise() {
    final Map<String, dynamic> exercise = {'exerciseId': exerciseId};

    if (sets != null && repetitions != null) {
      exercise['sets'] = sets;
      exercise['repetitions'] = repetitions;
    } else if (repetitions != null && sets == null) {
      exercise['repetitions'] = repetitions;
    } else if (time != null) {
      exercise['time'] = time;
      exercise['timeUnit'] = timeUnit ?? 'seconds';
    }

    return exercise;
  }
}
