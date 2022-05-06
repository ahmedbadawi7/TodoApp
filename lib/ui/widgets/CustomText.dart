import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {
  final Color? color;
  final List<Shadow>? shadows;
  final double? size;
  final String text;
  final Alignment? alignment;
  final FontWeight? fontweight;
  final double? height;
  final TextDecoration? underline;
  const CustomText(
      {this.color,
        this.shadows,
        required this.size,
        required this.text,
        this.alignment,
        this.fontweight,
        this.height,
        this.underline
      });
  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style:  GoogleFonts.lato(
        textStyle:  TextStyle(
        decoration: underline,
        height: height,
        color: color,
        fontSize: size,
        fontWeight: fontweight
    ),
    )
    );
  }
}