import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSeparator extends StatelessWidget {
  final String text;

  const TextSeparator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.urbanist(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
