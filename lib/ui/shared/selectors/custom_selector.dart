import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class CustomSelector extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String) onChanged;

  const CustomSelector({
    super.key,
    required this.options,
    this.selectedOption,
    required this.onChanged,
  });

  @override
  State<CustomSelector> createState() => _CustomSelectorState();
}

class _CustomSelectorState extends State<CustomSelector> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: widget.options.map((option) {
        bool isSelected = selected == option;

        return GestureDetector(
          onTap: () {
            setState(() {
              selected = option;
            });
            widget.onChanged(option);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.mainBlueColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.mainBlueColor.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  : [],
            ),
            child: Text(
              option,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:
                    isSelected ? AppColors.whiteColor : AppColors.blueDarkColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
