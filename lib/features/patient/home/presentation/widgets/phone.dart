import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class Phone extends StatelessWidget {
  const Phone({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(offset: const Offset(4, 4), blurRadius: 10, color: AppColors.darkColor.withValues(alpha: .1))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyles.semiBoldStyle.copyWith(fontSize: 15)),
          InkWell(
            onTap: onTap,
            child: Icon(Icons.phone, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
