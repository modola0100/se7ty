import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button_custom.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/auth/models/enum_user_type.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.welcomePng, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  Text("hello".tr(), style: TextStyles.boldStyle.copyWith(color: AppColors.primaryColor, fontSize: 30)),
                  Gap(15),
                  Text("booking".tr(), style: TextStyles.regularStyle.copyWith(fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      bool isArabic = context.locale.languageCode == 'ar';
                      context.setLocale(Locale(isArabic ? 'en' : 'ar'));
                    },
                    icon: Icon(Icons.language),
                  ),
                  Spacer(flex: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.primaryColor.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Gap(10),
                          Text("booking2".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.wightColor, fontSize: 18)),
                          Gap(50),
                          MainButtonCustom(
                            title: "doctor".tr(),
                            backgroundColor: AppColors.inputColor.withValues(alpha: 0.8),
                            textColor: AppColors.darkColor,
                            onPressed: () {
                              pushWithReplacement(context, Routes.login, extra: EnumUserType.doctor);
                            },
                          ),
                          Gap(20),
                          MainButtonCustom(
                            title: "patient".tr(),
                            backgroundColor: AppColors.inputColor.withValues(alpha: 0.8),
                            textColor: AppColors.darkColor,
                            onPressed: () {
                              pushWithReplacement(context, Routes.login, extra: EnumUserType.patient);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
