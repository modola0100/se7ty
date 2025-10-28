import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/main_button_custom.dart';
import 'package:se7ety/components/inputs/custome_text_form_field%20copy.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class RegisterCompleteScreen extends StatefulWidget {
  const RegisterCompleteScreen({super.key});

  @override
  State<RegisterCompleteScreen> createState() => _RegisterCompleteScreenState();
}

class _RegisterCompleteScreenState extends State<RegisterCompleteScreen> {
  String imagePath = '';
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("registeration_complete".tr(), style: TextStyles.boldStyle.copyWith(color: AppColors.wightColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              decoration: BoxDecoration(color: AppColors.primaryColor.withValues(alpha: 0.1)),
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    MainButtonCustom(
                                      title: "camera".tr(),
                                      onPressed: () {
                                        uploadImages(isCamera: true);
                                        if (imagePath.isNotEmpty) {}
                                      },
                                      textColor: AppColors.wightColor,
                                      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.5),
                                    ),
                                    Gap(10),
                                    MainButtonCustom(
                                      title: "gallery".tr(),
                                      onPressed: () {
                                        uploadImages(isCamera: false);
                                        if (imagePath.isNotEmpty) {}
                                      },
                                      textColor: AppColors.wightColor,
                                      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(radius: 50),
                      ),
                      Positioned(
                        top: 70,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.wightColor),
                          child: Icon(Icons.camera_alt, color: AppColors.primaryColor, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Text("specialization".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                Gap(10),
                CustomeTextFormField(keyboardType: TextInputType.text, textAlign: TextAlign.start, hintText: "orthopedic_doctor".tr(), color: AppColors.darkColor),
                Gap(10),
                Text("bio".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                Gap(10),
                CustomeTextFormField(keyboardType: TextInputType.text, textAlign: TextAlign.start, hintText: "bio2".tr(), maxLines: 7, fontSize: 12, color: AppColors.greyColor.withValues(alpha: 2.0)),
                Gap(10),
                Divider(),
                Gap(10),
                Text("address".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                Gap(10),
                CustomeTextFormField(
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.start,
                  hintText: "enter_address".tr(),
                  color: AppColors.greyColor.withValues(alpha: 2.0),
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "enter_address".tr();
                    }
                    return null;
                  },
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("work_hour".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                          Gap(10),
                          CustomeTextFormField(
                            keyboardType: TextInputType.datetime,
                            textAlign: TextAlign.start,
                            hintText: '10:00 AM',
                            readOnly: true,
                            color: AppColors.greyColor.withValues(alpha: 2.0),
                            suffixIcon: Icon(Icons.access_time, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("to".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                          Gap(10),
                          CustomeTextFormField(
                            keyboardType: TextInputType.datetime,
                            textAlign: TextAlign.start,
                            hintText: '10:00 PM',
                            readOnly: true,
                            color: AppColors.greyColor.withValues(alpha: 2.0),
                            suffixIcon: Icon(Icons.access_time, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Text("phone1".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                Gap(10),
                CustomeTextFormField(
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.start,
                  hintText: '+20xxxxxxxxxxx',
                  color: AppColors.greyColor.withValues(alpha: 2.0),
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "enter_phone".tr();
                    }
                    return null;
                  },
                ),
                Gap(10),
                Text("phone2".tr(), style: TextStyles.semiBoldStyle.copyWith(color: AppColors.darkColor, fontSize: 15)),
                Gap(10),
                CustomeTextFormField(keyboardType: TextInputType.phone, textAlign: TextAlign.start, hintText: '+20xxxxxxxxxxx', color: AppColors.greyColor.withValues(alpha: 2.0)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MainButtonCustom(
          title: "registeration".tr(),
          onPressed: () {
            if (formKey.currentState!.validate()) {}
          },
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.wightColor,
        ),
      ),
    );
  }

  Future<void> uploadImages({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }
}
