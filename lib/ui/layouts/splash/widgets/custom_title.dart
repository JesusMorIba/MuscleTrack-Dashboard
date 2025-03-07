import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon.svg',
                  width: 60,
                  height: 60,
                  colorFilter: ColorFilter.mode(
                    AppColors.blueDarkColor,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  'Muscle Track',
                  style: GoogleFonts.urbanist(
                    fontSize: 25.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
