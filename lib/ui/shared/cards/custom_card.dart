import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool goBack;

  const CustomCard({
    super.key,
    this.title,
    required this.child,
    this.goBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (goBack)
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                Expanded(
                  child: Text(
                    title!,
                    style: AppTextStyles.h5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Divider(),
          ],
          child,
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: AppColors.blackColor.withValues(alpha: 0.1),
          blurRadius: 5,
        ),
      ],
    );
  }
}
