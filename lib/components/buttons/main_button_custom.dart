import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/text_style.dart';

class MainButtonCustom extends StatelessWidget {
  const MainButtonCustom({
    super.key,
    this.height = 70,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width = double.infinity,
  });

  final double height;
  final double width;
  final String title;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyles.semiBoldStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
