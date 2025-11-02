import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/inputs/custome_text_form_field%20copy.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/data/specialization.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.wightColor,
        title: Text(
          "se7ety".tr(),
          style: TextStyles.boldStyle.copyWith(
            color: AppColors.darkColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello".tr(),
                      style: context.locale.languageCode == 'ar'
                          ? TextStyles.semiBoldStyle.copyWith(
                              fontSize: 20,
                              color: AppColors.darkColor,
                            )
                          : TextStyles.semiBoldStyle.copyWith(
                              fontSize: 18,
                              color: AppColors.darkColor,
                            ),
                    ),
                    TextSpan(
                      text:
                          FirebaseAuth.instance.currentUser?.displayName ?? "",
                      style: context.locale.languageCode == 'ar'
                          ? TextStyles.semiBoldStyle.copyWith(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                            )
                          : TextStyles.semiBoldStyle.copyWith(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                    ),
                    WidgetSpan(
                      child: Padding(
                        // add a bit of horizontal spacing so the icon isn't glued to the text
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            bool isArabic = context.locale.languageCode == 'ar';
                            context.setLocale(Locale(isArabic ? 'en' : 'ar'));
                          },
                          icon: Icon(Icons.language),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Text(
                "booking_now".tr(),
                style: context.locale.languageCode == 'ar'
                    ? TextStyles.semiBoldStyle.copyWith(
                        fontSize: 30,
                        color: AppColors.darkColor,
                      )
                    : TextStyles.semiBoldStyle.copyWith(
                        fontSize: 25,
                        color: AppColors.darkColor,
                      ),
              ),
              Gap(30),
              CustomeTextFormField(
                hintText: "search_doctor".tr(),
                maxLines: 1,
                color: AppColors.darkColor,
                fontSize: 18,
                suffixIcon: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(left: 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: AppColors.darkColor),
                  ),
                ),
              ),
              Gap(30),
              Text(
                "specialities".tr(),
                style: TextStyles.boldStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SpecialitiesCard(),
              Gap(30),
              Text(
                "top_rate".tr(),
                textAlign: TextAlign.center,
                style: TextStyles.boldStyle.copyWith(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialitiesCard extends StatelessWidget {
  const SpecialitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final model = cards[index];
          return Container(
            margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
            width: 200,
            decoration: BoxDecoration(
              color: model.cardBackground,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                  color: model.cardLightColor.withValues(alpha: .8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -20,
                    right: -20,
                    child: CircleAvatar(
                      backgroundColor: AppColors.wightColor.withValues(
                        alpha: 0.3,
                      ),
                      radius: 60,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/doctor-card.svg',
                        width: 140,
                      ),
                      const Gap(10),
                      Text(
                        model.name,
                        textAlign: TextAlign.center,
                        style: TextStyles.semiBoldStyle.copyWith(
                          color: AppColors.wightColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: cards.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
