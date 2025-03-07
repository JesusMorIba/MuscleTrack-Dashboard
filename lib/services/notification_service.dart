import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class NotificationService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBarError(String message) {
    if (messengerKey.currentState == null) return;

    final snackbar = SnackBar(
      backgroundColor: AppColors.redColor.withValues(alpha: 0.6),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Text(
        message,
        style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
          fontSize: 16.0,
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackbar);
  }

  static void showSnackBar(String message) {
    if (messengerKey.currentState == null) return;

    final snackbar = SnackBar(
      backgroundColor: AppColors.greenColor.withValues(alpha: 0.6),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Text(
        message,
        style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
          fontSize: 16.0,
        ),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
