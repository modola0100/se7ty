import 'package:easy_localization/easy_localization.dart';
import 'package:se7ety/core/constants/app_images.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({required this.image, required this.title, required this.description});
}

List<OnboardingModel> onboardingList = [OnboardingModel(image: AppImages.doctorsSvg, title: "onboardtitle1".tr(), description: "onboarddes1".tr()), OnboardingModel(image: AppImages.bookingSvg, title: "onboardtitle2".tr(), description: "onboarddes2".tr()), OnboardingModel(image: AppImages.checkSvg, title: "onboardtitle3".tr(), description: "onboarddes3".tr())];
