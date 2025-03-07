import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/splash/widgets/custom_title.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(seconds: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTitle(),
              SizedBox(height: 20),
              CircularProgressIndicator(
                color: AppColors.blueDarkColor,
                strokeCap: StrokeCap.round,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
