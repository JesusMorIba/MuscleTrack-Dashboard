import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/models/remote/response/workout_response.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';

class WorkoutsDatasource extends DataTableSource {
  final List<Workout> workouts;
  final BuildContext context;

  WorkoutsDatasource(this.workouts, this.context);

  @override
  DataRow? getRow(int index) {
    if (index < 0 || index >= workouts.length) {
      return null;
    }

    final workout = workouts[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(workout.id)),
        DataCell(Text(workout.title)),
        DataCell(Text(workout.level)),
        DataCell(Text(workout.minutes.toString())),
        DataCell(_buildImage(workout.cover)),
        DataCell(Text(workout.kcal.toString())),
        DataCell(_buildActionButtons(workout)),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 64,
      height: 64,
      fit: BoxFit.contain,
      placeholder: (context, url) =>
          const CircularProgressIndicator(strokeCap: StrokeCap.round),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildActionButtons(workout) {
    return Row(
      children: [
        _buildIconButton(
          Icons.edit_outlined,
          AppColors.blueDarkColor,
          () {},
        ),
        _buildIconButton(
          Icons.delete_outline,
          AppColors.redColor.withValues(alpha: 0.7),
          () => _showDeleteDialog(workout),
        ),
      ],
    );
  }

  void _showDeleteDialog(Workout workout) {
    final dialog = AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(
        'Delete Exercise',
        style: AppTextStyles.h4,
      ),
      content: Text(
        'Are you sure you want to permanently\ndelete ${workout.title}?',
        style: AppTextStyles.body1,
      ),
      actions: [
        _buildDialogButton('No', AppColors.blueDarkColor, () {
          Navigator.of(context).pop();
        }),
        _buildDialogButton('Yes', AppColors.redColor, () async {
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

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => workouts.length;

  @override
  int get selectedRowCount => 0;
}
