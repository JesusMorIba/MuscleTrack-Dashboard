import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:muscletrack_admin_dashboard/models/local/hybrid_exercise.dart';
import 'package:muscletrack_admin_dashboard/providers/workout_provider.dart';
import 'package:muscletrack_admin_dashboard/services/notification_service.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/buttons/custom_outlined_button.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/cards/custom_card.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_dropdown_button.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_text_form_field.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/modals/workout_modal.dart';
import 'package:provider/provider.dart';

class CreateWorkoutView extends StatefulWidget {
  const CreateWorkoutView({super.key});

  @override
  State<CreateWorkoutView> createState() => _CreateWorkoutViewState();
}

class _CreateWorkoutViewState extends State<CreateWorkoutView> {
  String? title;
  String? selectedLevel;
  int? duration;
  String? description;
  int? kcal;
  List<HybridExercise> exercises = [];
  late String? imageUrl;
  late Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    imageUrl = null;
    imageBytes = null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePickerWeb.getImageAsBytes();

    if (pickedFile != null) {
      setState(() {
        imageBytes = pickedFile;
        imageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          CustomCard(
            title: 'Create New Workout',
            goBack: true,
            child: Center(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildLabel('Workout Title'),
                    CustomTextFormField(
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      hint: 'Enter workout title',
                      prefixIcon: Symbols.title,
                    ),
                    const SizedBox(height: 10),
                    _buildLabel('Difficulty Level'),
                    CustomDropdownButton(
                      hint: 'Select Level',
                      options: [
                        'Beginner',
                        'Intermediate',
                        'Advanced',
                        'Athlete'
                      ],
                      selectedValue: selectedLevel,
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value;
                        });
                      },
                      prefixIcon: Symbols.difference,
                    ),
                    const SizedBox(height: 10),
                    _buildLabel('Workout Duration (Minutes)'),
                    CustomTextFormField(
                      onChanged: (value) => setState(
                        () => duration = int.tryParse(value),
                      ),
                      hint: 'Enter duration in minutes',
                      prefixIcon: Symbols.timer,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    _buildLabel('Workout Description'),
                    CustomTextFormField(
                      onChanged: (value) => setState(
                        () => description = value,
                      ),
                      hint: 'Enter description',
                      prefixIcon: Symbols.description,
                    ),
                    const SizedBox(height: 10),
                    _buildLabel('Calories Burned'),
                    CustomTextFormField(
                      onChanged: (value) => setState(
                        () => kcal = int.tryParse(value),
                      ),
                      hint: 'Enter estimated calories burned',
                      prefixIcon: Symbols.local_fire_department,
                    ),
                    const SizedBox(height: 10),
                    _buildLabel('Workout Cover'),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: AppColors.whiteColor, width: 1),
                        ),
                        child: _buildImage(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomOutlinedButton(
                      text: 'Pick Image',
                      onPressed: () {
                        _buildImage();
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildLabel('Exercises'),
                    CustomOutlinedButton(
                      text: 'Add Exercise',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => WorkoutModal(
                            exercises: exercises,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomOutlinedButton(
                      text: 'Save Workout',
                      isFilled: true,
                      onPressed: () async {
                        try {
                          await workoutProvider.createWorkout(
                            title!,
                            selectedLevel!,
                            duration!,
                            description!,
                            kcal!,
                            imageBytes!,
                            exercises,
                          );
                          NotificationService.showSnackBar(
                              'Exercise created successfully');
                        } catch (e) {
                          NotificationService.showSnackBarError(
                            'Error: ${e.toString()}',
                          );
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: AppTextStyles.h6,
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blueDarkColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageBytes != null
            ? Image.memory(
                imageBytes!,
                fit: BoxFit.cover,
              )
            : (imageUrl != null && imageUrl!.isNotEmpty)
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _defaultIcon(),
                  )
                : _defaultIcon(),
      ),
    );
  }

  Widget _defaultIcon() {
    return const Center(
      child: Icon(
        Icons.image,
        size: 40,
        color: AppColors.blueDarkColor,
      ),
    );
  }
}
