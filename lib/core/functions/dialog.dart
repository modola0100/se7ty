import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primaryColor,
      margin: EdgeInsets.all(20),
      elevation: 0,
      content: Text(
        message,
        style: TextStyles.regularStyle.copyWith(
          color: AppColors.wightColor,
          fontSize: 16,
        ),
      ),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(child: Lottie.asset(AppImages.lottie));
    },
  );
}
