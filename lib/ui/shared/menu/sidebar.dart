import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:muscletrack_admin_dashboard/providers/auth_provider.dart';
import 'package:muscletrack_admin_dashboard/providers/side_menu_provider.dart';
import 'package:muscletrack_admin_dashboard/router/router.dart';
import 'package:muscletrack_admin_dashboard/services/navigation_service.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/dashboard/widgets/custom_title.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/dashboard/widgets/text_separator.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/menu/menu_item.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          CustomTitle(),
          SizedBox(height: 30),
          TextSeparator(text: 'Main'),
          MenuItem(
            text: 'Dashboard',
            icon: Icons.dashboard,
            isActive: sideMenuProvider.currentPage == AppRouter.dashboardRoute,
            onPressed: () {
              navigateTo(AppRouter.dashboardRoute);
            },
          ),
          MenuItem(
            text: 'Analytics',
            icon: Icons.analytics_rounded,
            isActive: false,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Exercises',
            icon: Symbols.exercise,
            isActive: sideMenuProvider.currentPage == AppRouter.exercisesRoute,
            onPressed: () {
              navigateTo(AppRouter.exercisesRoute);
            },
          ),
          MenuItem(
            text: 'Workouts',
            icon: Icons.checklist_rounded,
            isActive: sideMenuProvider.currentPage == AppRouter.workoutsRoute,
            onPressed: () {
              navigateTo(AppRouter.workoutsRoute);
            },
          ),
          SizedBox(height: 30),
          TextSeparator(text: 'Exit'),
          MenuItem(
            text: 'Logout',
            icon: Icons.logout_rounded,
            isActive: false,
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: AppColors.blueDarkColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor,
            blurRadius: 10,
          ),
        ],
      );
}
