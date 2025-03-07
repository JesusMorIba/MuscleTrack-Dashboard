import 'dart:convert';

import 'package:muscletrack_admin_dashboard/models/local/muscle_category.dart';

class ExercisesResponse {
  int total;
  List<Exercise> exercises;

  ExercisesResponse({
    required this.total,
    required this.exercises,
  });

  factory ExercisesResponse.fromRawJson(String str) =>
      ExercisesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) =>
      ExercisesResponse(
        total: json["total"],
        exercises: List<Exercise>.from(
            json["exercises"].map((x) => Exercise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
      };
}

class Exercise {
  String id;
  String title;
  String imageUrl;
  MuscleCategory category;
  int v;

  Exercise({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.v,
  });

  factory Exercise.fromRawJson(String str) =>
      Exercise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["_id"]?.toString() ?? "",
        title: json["title"],
        imageUrl: json["imageUrl"],
        category: MuscleCategoryExtension.fromString(json["category"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "imageUrl": imageUrl,
        "category": category.displayName,
        "__v": v,
      };

  @override
  String toString() {
    return 'Exercise: $title, Category: ${category.displayName}';
  }
}
