import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/providers/side_menu_provider.dart';
import 'package:muscletrack_admin_dashboard/ui/layouts/dashboard/widgets/custom_search_box.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/menu/navbar_avatar.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/menu/notification_indicator.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width < 700)
            IconButton(
              onPressed: () => SideMenuProvider.openMenu(),
              icon: Icon(Icons.menu_rounded),
            ),
          SizedBox(width: 5),
          if (size.width > 390)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: CustomSearchBox(),
            ),
          Spacer(),
          NotificationIndicator(),
          SizedBox(width: 10),
          NavbarAvatar(),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
