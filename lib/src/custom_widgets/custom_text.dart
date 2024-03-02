import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.title,
    this.fontSize = 16,
    this.color,
    this.softWrap = true,
    this.fontWeight = FontWeight.normal,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  final String title;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: textOverflow,
      softWrap: softWrap,
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
