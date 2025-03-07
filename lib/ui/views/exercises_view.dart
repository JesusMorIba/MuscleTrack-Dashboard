import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/datatables/exercises_datasource.dart';
import 'package:muscletrack_admin_dashboard/providers/exercises_provider.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/modals/exercise_modal.dart';
import 'package:provider/provider.dart';

class ExercisesView extends StatefulWidget {
  const ExercisesView({super.key});

  @override
  State<ExercisesView> createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<ExercisesProvider>(context, listen: false).getExercises();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = Provider.of<ExercisesProvider>(context).exercises;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(
            height: 10,
          ),
          Theme(
            data: Theme.of(context).copyWith(
              cardTheme: const CardTheme(color: AppColors.whiteColor),
            ),
            child: PaginatedDataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'ID',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Title',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Category',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Image',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: AppTextStyles.h6,
                  ),
                ),
              ],
              source: ExercisesDatasource(exercises, context),
              header: Text('Exercises'),
              onRowsPerPageChanged: (value) {
                _rowsPerPage = value ?? 10;
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ExerciseModal(),
                    );
                  },
                  text: 'Create',
                  icon: Icons.add_outlined,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
