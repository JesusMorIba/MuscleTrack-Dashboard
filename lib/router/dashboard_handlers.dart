import 'package:fluro/fluro.dart';
import 'package:muscletrack_admin_dashboard/providers/auth_provider.dart';
import 'package:muscletrack_admin_dashboard/providers/side_menu_provider.dart';
import 'package:muscletrack_admin_dashboard/router/router.dart';
import 'package:muscletrack_admin_dashboard/ui/views/create_workout_view.dart';
import 'package:muscletrack_admin_dashboard/ui/views/dashboard_view.dart';
import 'package:muscletrack_admin_dashboard/ui/views/exercises_view.dart';
import 'package:muscletrack_admin_dashboard/ui/views/login_view.dart';
import 'package:muscletrack_admin_dashboard/ui/views/workouts_view.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    if (context == null) return null;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(AppRouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return DashboardView();
    }

    return LoginView();
  });

  static Handler exercises = Handler(handlerFunc: (context, params) {
    if (context == null) return null;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(AppRouter.exercisesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return ExercisesView();
    }

    return LoginView();
  });

  static Handler workouts = Handler(handlerFunc: (context, params) {
    if (context == null) return null;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(AppRouter.workoutsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return WorkoutsView();
    }

    return LoginView();
  });

  static Handler createWorkout = Handler(handlerFunc: (context, params) {
    if (context == null) return null;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(AppRouter.workoutsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return CreateWorkoutView();
    }

    return LoginView();
  });
}
