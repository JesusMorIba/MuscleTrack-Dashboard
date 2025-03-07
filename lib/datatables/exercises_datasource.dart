import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/models/local/muscle_category.dart';
import 'package:muscletrack_admin_dashboard/models/remote/response/exercises_response.dart';
import 'package:muscletrack_admin_dashboard/providers/exercises_provider.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/modals/exercise_modal.dart';
import 'package:provider/provider.dart';

class ExercisesDatasource extends DataTableSource {
  final List<Exercise> exercises;
  final BuildContext context;

  ExercisesDatasource(this.exercises, this.context);

  @override
  DataRow? getRow(int index) {
    if (index < 0 || index >= exercises.length) {
      return null;
    }

    final exercise = exercises[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(exercise.id)),
        DataCell(Text(exercise.title)),
        DataCell(Text(exercise.category.displayName)),
        DataCell(_buildImage(exercise.imageUrl)),
        DataCell(_buildActionButtons(exercise)),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 48,
      height: 48,
      fit: BoxFit.contain,
      placeholder: (context, url) =>
          const CircularProgressIndicator(strokeCap: StrokeCap.round),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildActionButtons(Exercise exercise) {
    return Row(
      children: [
        _buildIconButton(
          Icons.edit_outlined,
          AppColors.blueDarkColor,
          () {
            showModalBottomSheet(
              context: context,
              builder: (_) => ExerciseModal(
                exercise: exercise,
              ),
            );
          },
        ),
        _buildIconButton(
          Icons.delete_outline,
          AppColors.redColor.withValues(alpha: 0.7),
          () => _showDeleteDialog(exercise),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
    );
  }

  void _showDeleteDialog(Exercise exercise) {
    final dialog = AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        'Delete Exercise',
        style: AppTextStyles.h4,
      ),
      content: Text(
        'Are you sure you want to permanently\ndelete ${exercise.title}?',
        style: AppTextStyles.body1,
      ),
      actions: [
        _buildDialogButton('No', AppColors.blueDarkColor, () {
          Navigator.of(context).pop();
        }),
        _buildDialogButton('Yes', AppColors.redColor, () async {
          await Provider.of<ExercisesProvider>(context, listen: false)
              .deleteExercise(exercise.id);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  Widget _buildDialogButton(String label, Color color, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => exercises.length;

  @override
  int get selectedRowCount => 0;
}
