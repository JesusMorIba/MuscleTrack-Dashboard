import 'package:flutter/material.dart';
import 'package:muscletrack_admin_dashboard/theme/app_text_styles.dart';
import 'package:muscletrack_admin_dashboard/ui/shared/cards/custom_card.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
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
            title: 'Users Stadistics',
            child: Text('Hola Mundo'),
          ),
        ],
      ),
    );
  }
}
