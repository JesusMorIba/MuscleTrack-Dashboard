import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:muscletrack_admin_dashboard/models/local/hybrid_exercise.dart';
import 'package:muscletrack_admin_dashboard/providers/exercises_provider.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_dropdown_button.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class WorkoutModal extends StatefulWidget {
  final List<HybridExercise> exercises;

  const WorkoutModal({super.key, required this.exercises});

  @override
  State<WorkoutModal> createState() => _WorkoutModalState();
}

class _WorkoutModalState extends State<WorkoutModal> {
  HybridExercise? hybridExercise;
  String query = '';
  String measurementType = 'Repetitions';
  String value = '';
  String? secondaryValue;
  int? sets;
  int? repetitions;
  int? time;
  String? timeUnit;

  @override
  void initState() {
    super.initState();
    Provider.of<ExercisesProvider>(context, listen: false).getExercises();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesProvider = Provider.of<ExercisesProvider>(context);
    final filteredExercises = exercisesProvider.exercises
        .where((exercise) =>
            exercise.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        'Add Exercise',
        style: AppTextStyles.h4,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
              hint: 'Search Exercise',
              prefixIcon: Symbols.search,
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises[index];
                  return ListTile(
                    title: Text(
                      exercise.title,
                      style: AppTextStyles.body1,
                    ),
                    tileColor: hybridExercise?.title == exercise.title
                        ? Colors.blue.shade100
                        : null,
                    onTap: () {
                      setState(() {
                        hybridExercise = HybridExercise(
                          exerciseId: exercise.id,
                          title: exercise.title,
                          category: exercise.category,
                          imageUrl: exercise.imageUrl,
                          sets: null,
                          repetitions: null,
                          time: null,
                          timeUnit: null,
                        );
                      });
                    },
                  );
                },
              ),
            ),
            if (hybridExercise != null) ...[
              const SizedBox(height: 10),
              Text('Selected: ${hybridExercise!.title}',
                  style: AppTextStyles.body1),
            ],
            const SizedBox(height: 10),
            CustomDropdownButton(
              hint: 'Select Type',
              options: [
                'Minutes',
                'Seconds',
                'Repetitions',
                'Sets & Repetitions'
              ],
              selectedValue: measurementType,
              onChanged: (val) {
                setState(() {
                  measurementType = val!;
                  secondaryValue = null;
                  sets = null;
                  repetitions = null;
                  time = null;
                  timeUnit = null;
                });
              },
              prefixIcon: Symbols.timer,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
              hint: measurementType == 'Sets & Repetitions'
                  ? 'Enter Sets'
                  : 'Enter ${measurementType.toLowerCase()}',
              prefixIcon: Symbols.numbers,
            ),
            if (measurementType == 'Sets & Repetitions') ...[
              const SizedBox(height: 10),
              CustomTextFormField(
                onChanged: (val) {
                  setState(() {
                    secondaryValue = val;
                  });
                },
                hint: 'Enter Repetitions',
                prefixIcon: Symbols.numbers,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (hybridExercise != null) {
              if (measurementType == 'Sets & Repetitions') {
                hybridExercise = hybridExercise!.copyWith(
                  sets: int.tryParse(value),
                  repetitions: int.tryParse(secondaryValue ?? ''),
                );
              } else if (measurementType == 'Repetitions') {
                hybridExercise = hybridExercise!.copyWith(
                  repetitions: int.tryParse(value),
                );
              } else if (measurementType == 'Minutes' ||
                  measurementType == 'Seconds') {
                hybridExercise = hybridExercise!.copyWith(
                  time: int.tryParse(value),
                  timeUnit: measurementType.toLowerCase(),
                );
              }
              widget.exercises.add(hybridExercise!);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
