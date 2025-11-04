import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shered_prefrences.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isonBoardigSeen = SharedPref.getisBoardingSeen();
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 3), () {
      if (user != null) {
        if (user.photoURL == "doctor") {
          //goToBase(context, Routes.doctorMain);
        } else if (user.photoURL == "patient") {
          goToBase(context, Routes.patientMain);
        }
      } else {
        if (isonBoardigSeen) {
          pushWithReplacement(context, Routes.welcome);
        } else {
          pushWithReplacement(context, Routes.onboarding);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.logoPng),
            Gap(10),
            Text("splash".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.greenColor, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
