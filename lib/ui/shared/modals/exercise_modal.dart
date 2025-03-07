import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:muscletrack_admin_dashboard/models/local/muscle_category.dart';
import 'package:muscletrack_admin_dashboard/models/remote/response/exercises_response.dart';
import 'package:muscletrack_admin_dashboard/providers/exercises_provider.dart';
import 'package:muscletrack_admin_dashboard/services/notification_service.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/buttons/custom_outlined_button.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_text_form_field.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/selectors/custom_selector.dart';
import 'package:provider/provider.dart';

class ExerciseModal extends StatefulWidget {
  final Exercise? exercise;

  const ExerciseModal({super.key, this.exercise});

  @override
  State<ExerciseModal> createState() => _ExerciseModalState();
}

class _ExerciseModalState extends State<ExerciseModal> {
  late String? id;
  late String? title;
  late MuscleCategory? category;
  late String? imageUrl;
  late Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    id = widget.exercise?.id;
    title = widget.exercise?.title;
    category = widget.exercise?.category;
    imageUrl = widget.exercise?.imageUrl;
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

  Widget _buildImage() {
    if (imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          imageBytes!,
          fit: BoxFit.contain,
          width: 64,
          height: 64,
        ),
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, color: Colors.white),
        ),
      );
    } else {
      return const Icon(Icons.image, color: Colors.white70);
    }
  }

  Widget _buildButton(String text, void Function() onPressed) {
    return Center(
      child: CustomOutlinedButton(
        onPressed: onPressed,
        text: text,
        color: AppColors.whiteColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercisesProvider =
        Provider.of<ExercisesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 550,
      width: 600,
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id == null ? 'New Exercise' : 'Edit Exercise',
                style: AppTextStyles.h4.copyWith(color: AppColors.whiteColor),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: AppColors.whiteColor),
              ),
            ],
          ),
          Divider(color: AppColors.whiteColor.withValues(alpha: 0.3)),
          const SizedBox(height: 20),
          CustomTextFormField(
            onChanged: (value) {
              title = value;
            },
            initialValue: title,
            hint: 'Exercise',
            prefixIcon: Symbols.exercise,
          ),
          const SizedBox(height: 20),
          CustomSelector(
            options: MuscleCategory.values.map((e) => e.displayName).toList(),
            selectedOption: category?.displayName,
            onChanged: (value) {
              setState(() {
                category = MuscleCategory.values
                    .firstWhere((e) => e.displayName == value);
              });
            },
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.whiteColor, width: 1),
              ),
              child: _buildImage(),
            ),
          ),
          const SizedBox(height: 15),
          _buildButton('Pick Image', _pickImage),
          const SizedBox(height: 20),
          _buildButton(
            id == null ? 'Save' : 'Edit',
            () async {
              try {
                if (id == null) {
                  if (imageBytes != null) {
                    await exercisesProvider.createExercise(
                        title!, category!, imageBytes!);
                    NotificationService.showSnackBar(
                        'Exercise created successfully');
                  }
                } else {
                  await exercisesProvider.updateExercise(id!, title!, category!,
                      imageBytes: imageBytes, imageUrl: imageUrl);
                  NotificationService.showSnackBar(
                      'Exercise updated successfully');
                }
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
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.blueDarkColor,
        boxShadow: [BoxShadow(color: AppColors.greyColor)],
      );
}
