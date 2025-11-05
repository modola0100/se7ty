import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/doctorcard/doctorcard.dart';
import 'package:se7ety/components/inputs/custome_text_form_field%20copy.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/presentation/cubit/patient_home_cubit.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialities_card.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => PatientHomeCubit()..sortByRate(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.wightColor,
          title: Text("se7ety".tr(), style: TextStyles.boldStyle.copyWith(color: AppColors.darkColor, fontSize: 20)),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                        style: context.locale.languageCode == 'ar' ? TextStyles.semiBoldStyle.copyWith(fontSize: 20, color: AppColors.darkColor) : TextStyles.semiBoldStyle.copyWith(fontSize: 18, color: AppColors.darkColor),
                      ),
                      TextSpan(
                        text: FirebaseAuth.instance.currentUser?.displayName ?? "",
                        style: context.locale.languageCode == 'ar' ? TextStyles.semiBoldStyle.copyWith(fontSize: 20, color: AppColors.primaryColor) : TextStyles.semiBoldStyle.copyWith(fontSize: 18, color: AppColors.primaryColor),
                      ),
                      WidgetSpan(
                        child: IconButton(
                          onPressed: () {
                            bool isArabic = context.locale.languageCode == 'ar';
                            context.setLocale(Locale(isArabic ? 'en' : 'ar'));
                          },
                          icon: Icon(Icons.language),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10),
                Text(
                  "booking_now".tr(),
                  style: context.locale.languageCode == 'ar' ? TextStyles.semiBoldStyle.copyWith(fontSize: 30, color: AppColors.darkColor) : TextStyles.semiBoldStyle.copyWith(fontSize: 25, color: AppColors.darkColor),
                ),
                Gap(30),
                CustomeTextFormField(
                  onFieldSubmitted: (String value) {
                    if (searchController.text.isNotEmpty) {
                      pushTo(context, Routes.doctorSearch, extra: searchController.text);
                    }
                  },
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  hintText: "search_doctor".tr(),
                  maxLines: 1,
                  color: AppColors.darkColor,
                  fontSize: 18,
                  suffixIcon: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.only(left: 0),
                    child: IconButton(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          pushTo(context, Routes.doctorSearch, extra: searchController.text);
                        }
                      },
                      icon: Icon(Icons.search, color: AppColors.darkColor),
                    ),
                  ),
                ),
                Gap(30),
                Text("specialities".tr(), style: TextStyles.boldStyle.copyWith(color: AppColors.primaryColor)),
                SpecialitiesCard(),
                Gap(30),
                Text(
                  "top_rate".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyles.boldStyle.copyWith(fontSize: 20, color: AppColors.primaryColor),
                ),
                Gap(15),
                Doctorcard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
