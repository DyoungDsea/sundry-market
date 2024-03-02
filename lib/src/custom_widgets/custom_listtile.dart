import 'package:flutter/material.dart';

import './custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.borderBottomColor,
    this.splashColor = Colors.grey,
    required this.icon,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Color borderBottomColor;
  final Color? splashColor;
  final IconData icon;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderBottomColor,
          ),
        ),
      ),
      child: InkWell(
        splashColor: splashColor,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    const SizedBox(width: 20),
                    CustomText(
                      title: title,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ],
                ),
                const Icon(Icons.arrow_right, color: Color(0xFF198754))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
