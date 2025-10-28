import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se7ety/components/buttons/main_button_custom.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/intro/onBoarding/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

var pageController = PageController();
int currentIndex = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.wightColor,
        actions: [
          if (currentIndex != onboardingList.length - 1)
            TextButton(
              style: TextButton.styleFrom(overlayColor: Colors.transparent),
              onPressed: () {
                pushWithReplacement(context, Routes.welcome);
              },
              child: Text("skip".tr(), style: TextStyles.mediumStyle.copyWith(color: AppColors.primaryColor)),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SvgPicture.asset(onboardingList[index].image, width: MediaQuery.sizeOf(context).width * 0.8),
                      Spacer(),
                      Text(onboardingList[index].title, style: TextStyles.semiBoldStyle.copyWith(color: AppColors.primaryColor)),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(onboardingList[index].description, style: TextStyles.regularStyle.copyWith(fontSize: 15), textAlign: TextAlign.center),
                      ),
                      Spacer(flex: 3),
                    ],
                  );
                },
                itemCount: onboardingList.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: onboardingList.length,
                      effect: ExpandingDotsEffect(dotWidth: 11, dotHeight: 11, dotColor: AppColors.greyColor, activeDotColor: AppColors.primaryColor),
                    ),
                    if (currentIndex == onboardingList.length - 1)
                      MainButtonCustom(
                         width: 122,
                        title: "Let’s Go".tr(),
                        onPressed: () {
                          pushWithReplacement(context, Routes.welcome);
                        },
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.wightColor,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
