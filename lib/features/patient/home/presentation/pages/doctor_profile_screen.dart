import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../components/buttons/main_button_custom.dart';
import '../../../../../core/routes/navigator.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../auth/models/doctor_model.dart';
import '../widgets/phone.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/routes/routes.dart';
import 'package:go_router/go_router.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key, required this.doctorModel});

  final DoctorModel doctorModel;

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

String translatedSpecialization = '';
String translatedAddress = '';

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  void initState() {
    super.initState();
    translateSpecialization();
    translateAddress();
  }

  void translateSpecialization() async {
    final translation = await GoogleTranslator().translate(
      widget.doctorModel.specialization ?? '',
      to: 'en',
    );
    setState(() {
      translatedSpecialization = translation.text;
    });
  }

  void translateAddress() async {
    final translationAddress = await GoogleTranslator().translate(
      widget.doctorModel.address ?? '',
      to: 'en',
    );
    setState(() {
      translatedAddress = translationAddress.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.wightColor),
        ),
        title: Text(
          "profile_doctor".tr(),
          style: TextStyles.semiBoldStyle.copyWith(
            color: AppColors.wightColor,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.wightColor,
                    backgroundImage: NetworkImage(
                      widget.doctorModel.image ?? '',
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Dr.".tr(),
                                style: TextStyles.semiBoldStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 25,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  maxLines: 1,
                                  widget.doctorModel.name ?? '',
                                  style: TextStyles.semiBoldStyle.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(5),
                          Text(
                            context.locale.languageCode == "ar"
                                ? widget.doctorModel.specialization ?? ''
                                : translatedSpecialization,
                            style: TextStyles.semiBoldStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Gap(10),
                          Row(
                            children: [
                              Text(
                                widget.doctorModel.rating.toString(),
                                style: TextStyles.semiBoldStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              Gap(5),
                              Icon(Icons.star, color: Colors.amber),
                            ],
                          ),
                          Gap(30),
                          Row(
                            children: [
                              Phone(
                                title: '1',
                                onTap: () {
                                  var phone = Uri.parse(
                                    'tel:${widget.doctorModel.phone1}',
                                  );
                                  launchUrl(phone);
                                },
                              ),
                              Gap(20),
                              if (widget.doctorModel.phone2?.isNotEmpty == true)
                                Phone(
                                  title: '2',
                                  onTap: () {
                                    var phone = Uri.parse(
                                      'tel${widget.doctorModel.phone2}',
                                    );
                                    launchUrl(phone);
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(30),
              Text("bio".tr(), style: TextStyles.semiBoldStyle),
              Gap(20),
              Text(
                context.locale.languageCode == "ar"
                    ? widget.doctorModel.specialization ?? ''
                    : translatedSpecialization,
                style: TextStyles.regularStyle.copyWith(fontSize: 16),
              ),
              Gap(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.inputColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              border: Border.all(
                                width: 4,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.access_time,
                              color: AppColors.wightColor,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "${widget.doctorModel.openHour ?? ''} - ${widget.doctorModel.closeHour ?? ''} ",
                            style: TextStyles.regularStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Gap(30),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              border: Border.all(
                                width: 4,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: AppColors.wightColor,
                            ),
                          ),
                          Gap(10),
                          Text(
                            context.locale.languageCode == "ar"
                                ? widget.doctorModel.address ?? ''
                                : translatedAddress,
                            style: TextStyles.regularStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Gap(30),
              Text("contact".tr(), style: TextStyles.semiBoldStyle),
              Gap(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.inputColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              border: Border.all(
                                width: 4,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.mail,
                              color: AppColors.wightColor,
                            ),
                          ),
                          Gap(10),
                          Text(
                            widget.doctorModel.email ?? '',
                            style: TextStyles.regularStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Gap(30),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              border: Border.all(
                                width: 4,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.phone,
                              color: AppColors.wightColor,
                            ),
                          ),
                          Gap(10),
                          Text(
                            widget.doctorModel.phone1 ?? '',
                            style: TextStyles.regularStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(30),
              MainButtonCustom(
                backgroundColor: AppColors.primaryColor,
                width: double.infinity,
                title: "احجز موعد الان",
                onPressed: () {
                  context.push(Routes.booking, extra: widget.doctorModel.name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
