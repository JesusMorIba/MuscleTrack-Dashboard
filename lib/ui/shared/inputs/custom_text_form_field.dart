import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_error_alert.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? errorMessage;
  final bool isPassword;
  final String? initialValue;
  final bool isDarkMode;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.errorMessage,
    this.onChanged,
    this.isPassword = false,
    this.initialValue,
    this.isDarkMode = false,
    this.keyboardType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();

  static searchInputDecoration({
    required String hint,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.blueDarkColor,
      ),
      hintText: hint,
      hintStyle: GoogleFonts.urbanist(
        fontWeight: FontWeight.w400,
        color: AppColors.blueDarkColor.withValues(alpha: 0.7),
        fontSize: 14.0,
      ),
      labelStyle: GoogleFonts.urbanist(
        fontWeight: FontWeight.w400,
        color: AppColors.blueDarkColor,
        fontSize: 12.0,
      ),
    );
  }
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        widget.isDarkMode ? AppColors.lightGreyColor : AppColors.whiteColor;
    final Color textColor =
        widget.isDarkMode ? AppColors.whiteColor : AppColors.blueDarkColor;
    final Color hintColor = widget.isDarkMode
        ? AppColors.whiteColor.withAlpha(150)
        : AppColors.blueDarkColor.withAlpha(150);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: backgroundColor,
            border: Border.all(
              color: AppColors.lightGreyColor,
              width: 0.6,
            ),
          ),
          child: TextFormField(
            initialValue: widget.initialValue ?? '',
            onChanged: widget.onChanged,
            obscureText: widget.isPassword ? _isObscured : false,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w400,
              color: textColor,
              fontSize: 12.0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                widget.prefixIcon,
                color: textColor,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: textColor,
                        size: 20,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.only(top: 16.0),
              hintText: widget.hint,
              hintStyle: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                color: hintColor,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty)
          CustomErrorAlert(message: widget.errorMessage!),
      ],
    );
  }
}
