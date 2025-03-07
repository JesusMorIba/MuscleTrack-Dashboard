import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/api/cloudinary_api.dart';
import 'package:muscletrack_admin_dashboard/api/muscle_track_api.dart';
import 'package:muscletrack_admin_dashboard/models/local/hybrid_exercise.dart';
import 'package:muscletrack_admin_dashboard/models/local/upload_preset.dart';
import 'package:muscletrack_admin_dashboard/models/remote/response/workout_response.dart';

class WorkoutProvider extends ChangeNotifier {
  List<Workout> workouts = [];

  Future<void> getWorkouts() async {
    try {
      final response = await MuscleTrackApi.httpGet('/workout/');
      final workoutResponse = WorkoutResponse.fromJson(response);
      workouts = workoutResponse.workout;
      notifyListeners();
    } catch (e) {
      throw 'Error fetching exercises.';
    }
  }

  Future<void> createWorkout(
    String title,
    String difficult,
    int duration,
    String description,
    int kcal,
    Uint8List imageBytes,
    List<HybridExercise> exercises,
  ) async {
    try {
      String imageUrl = await CloudinaryApi.uploadImage(
          imageBytes, UploadPreset.workoutCovers);

      final data = {
        'workout': {
          'title': title,
          'level': difficult.toString().split('.').last,
          'minutes': duration,
          'cover': imageUrl,
          'description': description,
          'kcal': kcal,
          'exercises': exercises
              .map((hybridExercise) => hybridExercise.toExercise())
              .toList(),
        },
      };

      final response =
          await MuscleTrackApi.httpPost('/workout/create-workout', data);

      final newWorkout = Workout.fromJson(response["workout"]);

      workouts.add(newWorkout);

      notifyListeners();
    } catch (e) {
      throw 'Error creating workout.';
    }
  }
}
