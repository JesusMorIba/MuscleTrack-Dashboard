import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/api/muscle_track_api.dart';
import 'package:muscletrack_admin_dashboard/api/cloudinary_api.dart';
import 'package:muscletrack_admin_dashboard/models/local/muscle_category.dart';
import 'package:muscletrack_admin_dashboard/models/local/upload_preset.dart';
import 'package:muscletrack_admin_dashboard/models/remote/response/exercises_response.dart';

class ExercisesProvider extends ChangeNotifier {
  List<Exercise> exercises = [];

  Future<void> getExercises() async {
    try {
      final response = await MuscleTrackApi.httpGet('/exercise/');
      final exercisesResponse = ExercisesResponse.fromJson(response);
      exercises = exercisesResponse.exercises;
      notifyListeners();
    } catch (e) {
      throw 'Error fetching exercises.';
    }
  }

  Future<void> createExercise(
      String name, MuscleCategory category, Uint8List imageBytes) async {
    try {
      String imageUrl =
          await CloudinaryApi.uploadImage(imageBytes, UploadPreset.exercises);

      final data = {
        'title': name,
        'category': category.toString().split('.').last,
        'imageUrl': imageUrl,
      };

      final response = await MuscleTrackApi.httpPost('/exercise/create', data);

      final newExercise = Exercise.fromJson(response["exercise"]);

      exercises.add(newExercise);

      notifyListeners();
    } catch (e) {
      throw 'Error creating exercise.';
    }
  }

  Future<void> updateExercise(
    String id,
    String title,
    MuscleCategory category, {
    Uint8List? imageBytes,
    String? imageUrl,
  }) async {
    try {
      String finalImageUrl;
      if (imageBytes != null) {
        finalImageUrl =
            await CloudinaryApi.uploadImage(imageBytes, UploadPreset.exercises);
      } else if (imageUrl != null) {
        finalImageUrl = imageUrl;
      } else {
        throw Exception("No image data provided");
      }

      final data = {
        'title': title,
        'category': category.toString().split('.').last,
        'imageUrl': finalImageUrl,
      };

      await MuscleTrackApi.httpPut('/exercise/update/$id', data);

      exercises = exercises.map((exercise) {
        if (exercise.id != id) return exercise;
        exercise.title = title;
        exercise.imageUrl = finalImageUrl;
        return exercise;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error updating exercise.';
    }
  }

  Future<void> deleteExercise(String id) async {
    try {
      await MuscleTrackApi.httpDelete('/exercise/delete/$id', {});

      exercises.removeWhere((exercise) => exercise.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error deleting exercise.';
    }
  }
}
