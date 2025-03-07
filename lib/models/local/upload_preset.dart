enum UploadPreset {
  exercises,
  workoutCovers,
  documents,
}

extension UploadPresetExtension on UploadPreset {
  String get name {
    switch (this) {
      case UploadPreset.exercises:
        return 'exercises';
      case UploadPreset.workoutCovers:
        return 'workouts_covers';
      case UploadPreset.documents:
        return 'documents';
    }
  }
}
