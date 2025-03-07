import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/api/cloudinary_api.dart';
import 'package:muscletrack_admin_dashboard/api/muscle_track_api.dart';
import 'package:muscletrack_admin_dashboard/providers/auth_provider.dart';
import 'package:muscletrack_admin_dashboard/providers/exercises_provider.dart';
import 'package:muscletrack_admin_dashboard/providers/side_menu_provider.dart';
import 'package:muscletrack_admin_dashboard/providers/workout_provider.dart';
import 'package:muscletrack_admin_dashboard/router/router.dart';
import 'package:muscletrack_admin_dashboard/services/environment_service.dart';
import 'package:muscletrack_admin_dashboard/services/local_storage.dart';
import 'package:muscletrack_admin_dashboard/services/navigation_service.dart';
import 'package:muscletrack_admin_dashboard/services/notification_service.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  await Environment.initEnvironment();
  MuscleTrackApi.configureDio();
  CloudinaryApi.configureCloudinary();
  AppRouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => SideMenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExercisesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutProvider(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MuscleTrack Admin Dashboard',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationService.messengerKey,
      builder: (_, child) {
        final auth = Provider.of<AuthProvider>(context);

        if (auth.authStatus == AuthStatus.checking) {
          return SplashLayout();
        }

        if (auth.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        }

        return AuthLayout(child: child!);
      },
      theme: ThemeData.light().copyWith(
        primaryColor: AppColors.whiteColor,
        dialogBackgroundColor: Colors.white,
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: WidgetStatePropertyAll(
            AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
