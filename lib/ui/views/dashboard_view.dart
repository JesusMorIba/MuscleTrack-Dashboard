import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/providers/auth_provider.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/cards/custom_card.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            'Dashboard View',
            style: AppTextStyles.h1,
          ),
          SizedBox(
            height: 10,
          ),
          CustomCard(
            title: user?.firstName,
            child: Text(user!.email),
          ),
        ],
      ),
    );
  }
}
