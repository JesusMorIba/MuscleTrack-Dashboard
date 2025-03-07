import 'dart:convert';

class WorkoutResponse {
  final List<Workout> workout;

  WorkoutResponse({
    required this.workout,
  });

  factory WorkoutResponse.fromRawJson(String str) =>
      WorkoutResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkoutResponse.fromJson(Map<String, dynamic> json) =>
      WorkoutResponse(
        workout:
            List<Workout>.from(json["workout"].map((x) => Workout.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workout": List<dynamic>.from(workout.map((x) => x.toJson())),
      };
}

class Workout {
  final String title;
  final String level;
  final int minutes;
  final String cover;
  final String description;
  final int workouts;
  final int kcal;
  final List<Exercise> exercises;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Workout({
    required this.title,
    required this.level,
    required this.minutes,
    required this.cover,
    required this.description,
    required this.workouts,
    required this.kcal,
    required this.exercises,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Workout.fromRawJson(String str) => Workout.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        title: json["title"],
        level: json["level"],
        minutes: json["minutes"],
        cover: json["cover"],
        description: json["description"],
        workouts: json["workouts"],
        kcal: json["kcal"],
        exercises: List<Exercise>.from(
            json["exercises"].map((x) => Exercise.fromJson(x))),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "level": level,
        "minutes": minutes,
        "cover": cover,
        "description": description,
        "workouts": workouts,
        "kcal": kcal,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Exercise {
  final String exerciseId;
  final int? sets;
  final int? repetitions;
  final String id;
  final int? time;
  final String? timeUnit;

  Exercise({
    required this.exerciseId,
    this.sets,
    this.repetitions,
    required this.id,
    this.time,
    this.timeUnit,
  });

  factory Exercise.fromRawJson(String str) =>
      Exercise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        exerciseId: json["exerciseId"],
        sets: json["sets"],
        repetitions: json["repetitions"],
        id: json["_id"],
        time: json["time"],
        timeUnit: json["timeUnit"],
      );

  Map<String, dynamic> toJson() => {
        "exerciseId": exerciseId,
        "sets": sets,
        "repetitions": repetitions,
        "_id": id,
        "time": time,
        "timeUnit": timeUnit,
      };
}
