import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.blueDarkColor,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: color,
            width: 2,
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          isFilled ? color : null,
        ),
      ),
      onPressed: () => onPressed(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          text,
          style: GoogleFonts.urbanist(
            color: isFilled ? Colors.white : color,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
