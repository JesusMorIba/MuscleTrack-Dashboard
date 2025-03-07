import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/inputs/custom_text_form_field.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: buildBoxDecoration(),
        child: Center(
          child: TextField(
            decoration: CustomTextFormField.searchInputDecoration(
              hint: 'Search',
              prefixIcon: Icons.search,
            ),
          ),
        ));
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greyColor.withValues(alpha: 0.3),
      );
}
