import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class NotificationIndicator extends StatelessWidget {
  const NotificationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.notifications_none_outlined,
          color: AppColors.blueDarkColor,
        ),
        Positioned(
          left: 2,
          child: Container(
            width: 5,
            height: 5,
            decoration: buildBoxDecoration(),
          ),
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(100),
      );
}
