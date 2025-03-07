import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = AppColors.blueDarkColor,
      this.isFilled = false,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          StadiumBorder(),
        ),
        backgroundColor: WidgetStatePropertyAll(color),
        overlayColor: WidgetStatePropertyAll(color.withValues(alpha: 0.5)),
      ),
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(icon, color: AppColors.whiteColor),
          SizedBox(
            width: 2,
          ),
          Text(
            text,
            style: AppTextStyles.button.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
