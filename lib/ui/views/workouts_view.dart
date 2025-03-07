import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/datatables/workouts_datasource.dart';
import 'package:muscletrack_admin_dashboard/providers/workout_provider.dart';
import 'package:muscletrack_admin_dashboard/router/router.dart';
import 'package:muscletrack_admin_dashboard/services/navigation_service.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:provider/provider.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key});

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutProvider>(context, listen: false).getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    final workouts = Provider.of<WorkoutProvider>(context).workouts;

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
                    'Level',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Total',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Cover',
                    style: AppTextStyles.h6,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Kcal',
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
              source: WorkoutsDatasource(workouts, context),
              header: Text('Workout'),
              onRowsPerPageChanged: (value) {
                _rowsPerPage = value ?? 10;
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    NavigationService.navigateTo(AppRouter.createWorkoutRoute);
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
