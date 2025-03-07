import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class CustomDropdownButton extends StatelessWidget {
  final String hint;
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final IconData prefixIcon;

  const CustomDropdownButton({
    super.key,
    required this.hint,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.whiteColor,
        border: Border.all(
          color: AppColors.lightGreyColor,
          width: 0.6,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.blueDarkColor,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        dropdownColor: AppColors.whiteColor,
        onChanged: onChanged,
        hint: Text(
          hint,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w400,
            color: AppColors.blueDarkColor.withAlpha(150),
            fontSize: 12.0,
          ),
        ),
        items: options
            .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w400,
          color: AppColors.blueDarkColor.withAlpha(150),
          fontSize: 12.0,
        ),
      ),
    );
  }
}
