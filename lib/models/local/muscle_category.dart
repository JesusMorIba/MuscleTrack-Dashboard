enum MuscleCategory {
  cardio,
  core,
  upper,
  lower,
  fullBody,
  arms,
  chest,
  back,
  shoulders,
  legs,
  glutes;
}

extension MuscleCategoryExtension on MuscleCategory {
  String get displayName {
    switch (this) {
      case MuscleCategory.cardio:
        return "Cardio";
      case MuscleCategory.core:
        return "Core";
      case MuscleCategory.upper:
        return "Upper";
      case MuscleCategory.lower:
        return "Lower";
      case MuscleCategory.fullBody:
        return "Full Body";
      case MuscleCategory.arms:
        return "Arms";
      case MuscleCategory.chest:
        return "Chest";
      case MuscleCategory.back:
        return "Back";
      case MuscleCategory.shoulders:
        return "Shoulders";
      case MuscleCategory.legs:
        return "Legs";
      case MuscleCategory.glutes:
        return "Glutes";
    }
  }

  static MuscleCategory fromString(String value) {
    return MuscleCategory.values.firstWhere(
      (e) => e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => MuscleCategory.core,
    );
  }
}
