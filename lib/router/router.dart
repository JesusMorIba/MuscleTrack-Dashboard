import 'package:fluro/fluro.dart';
import 'package:muscletrack_admin_dashboard/router/admin_handlers.dart';
import 'package:muscletrack_admin_dashboard/router/dashboard_handlers.dart';
import 'package:muscletrack_admin_dashboard/router/not_found_handlers.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  // Root Router
  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';

  // Dashboard
  static String dashboardRoute = '/dashboard';

  // Analytics
  static String analyticsRoute = '/dashboard/analytics';

  // Exercises
  static String exercisesRoute = '/dashboard/exercises';

  // Workouts
  static String workoutsRoute = '/dashboard/workouts';
  static String createWorkoutRoute = '/dashboard/workouts/create';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);

    // Dashboard Routes
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.none);

    router.define(exercisesRoute,
        handler: DashboardHandlers.exercises,
        transitionType: TransitionType.none);

    router.define(workoutsRoute,
        handler: DashboardHandlers.workouts,
        transitionType: TransitionType.none);

    router.define(createWorkoutRoute,
        handler: DashboardHandlers.createWorkout,
        transitionType: TransitionType.none);

    // 404 - Not Page Found
    router.notFoundHandler = NotFoundHandlers.notPageFound;
  }
}
