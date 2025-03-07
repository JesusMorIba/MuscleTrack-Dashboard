import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/auth/widgets/custom_background.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopAuthLayout(child: child)
              : _MobileAuthLayout(child: child),
        ],
      ),
    );
  }
}

class _DesktopAuthLayout extends StatelessWidget {
  final Widget child;

  const _DesktopAuthLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        children: [
          Expanded(child: CustomBackground()),
          Container(
            width: 600,
            height: double.infinity,
            color: AppColors.backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 20),
                CustomTitle(),
                SizedBox(height: 20),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileAuthLayout extends StatelessWidget {
  final Widget child;

  const _MobileAuthLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 445,
            child: CustomBackground(),
          )
        ],
      ),
    );
  }
}
