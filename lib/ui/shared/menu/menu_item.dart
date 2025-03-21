import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletrack_admin_dashboard/theme/app_colors.dart';

class MenuItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  const MenuItem(
      {super.key,
      required this.text,
      required this.icon,
      this.isActive = false,
      required this.onPressed});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      color: isHovered
          ? AppColors.whiteColor.withValues(alpha: 0.2)
          : widget.isActive
              ? AppColors.whiteColor.withValues(alpha: 0.3)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: AppColors.whiteColor.withValues(alpha: 0.3),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.text,
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: AppColors.whiteColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
