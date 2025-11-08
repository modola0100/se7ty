import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/main_button_custom.dart';
import 'package:se7ety/components/inputs/custome_text_form_field%20copy.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/functions/dialog.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/auth/models/specialization.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7ety/features/auth/presentation/widgets/auth_form.dart';

class RegisterCompleteScreen extends StatefulWidget {
  const RegisterCompleteScreen({super.key});

  @override
  State<RegisterCompleteScreen> createState() => _RegisterCompleteScreenState();
}

class _RegisterCompleteScreenState extends State<RegisterCompleteScreen> {
  File? imagePath;
  String? selectedSpecialization;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is LoadingAuthstate) {
          showLoadingDialog(context);
        } else if (state is SuccesAuthState) {
          pop(context);
          // pushWithReplacement(context, Routes.doctorMain);
        } else if (state is ErrorAuthState) {
          pop(context);
          showErrorDialog(context, state.error ?? '');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "registeration_complete".tr(),
            style: TextStyles.boldStyle.copyWith(color: AppColors.wightColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Form(
              key: AuthForm.formKey,
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
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      MainButtonCustom(
                                        title: "camera".tr(),
                                        onPressed: () {
                                          uploadImages(isCamera: true);
                                        },
                                        textColor: AppColors.wightColor,
                                        backgroundColor: AppColors.primaryColor
                                            .withValues(alpha: 0.5),
                                      ),
                                      Gap(10),
                                      MainButtonCustom(
                                        title: "gallery".tr(),
                                        onPressed: () {
                                          uploadImages(isCamera: false);
                                        },
                                        textColor: AppColors.wightColor,
                                        backgroundColor: AppColors.primaryColor
                                            .withValues(alpha: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.wightColor,
                            backgroundImage: (imagePath != null)
                                ? FileImage(imagePath!)
                                : const AssetImage(AppImages.docPng),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.wightColor,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "specialization".tr(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.inputColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButton<String?>(
                      icon: Icon(
                        Icons.expand_circle_down_outlined,
                        color: AppColors.primaryColor,
                      ),
                      iconEnabledColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: Text("choose_specialty".tr()),
                      value: selectedSpecialization,
                      items: [
                        for (var specializat in specializations)
                          DropdownMenuItem(
                            value: specializat,
                            child: Text(specializat),
                          ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSpecialization = newValue;
                        });
                      },
                    ),
                  ),
                  Gap(10),
                  Text(
                    "bio".tr(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    hintText: "bio2".tr(),
                    maxLines: 7,
                    fontSize: 12,
                    color: AppColors.greyColor.withValues(alpha: 2.0),
                    controller: AuthForm.bioController,
                  ),
                  Gap(10),
                  Divider(),
                  Gap(10),
                  Text(
                    "address".tr(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.start,
                    hintText: "enter_address".tr(),
                    color: AppColors.greyColor.withValues(alpha: 2.0),
                    controller: AuthForm.addressController,
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
                            Text(
                              "work_hour".tr(),
                              style: TextStyles.semiBoldStyle.copyWith(
                                color: AppColors.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            Gap(10),
                            CustomeTextFormField(
                              keyboardType: TextInputType.datetime,
                              textAlign: TextAlign.start,
                              hintText: '10:00 AM',
                              readOnly: true,
                              color: AppColors.greyColor.withValues(alpha: 2.0),
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColors.primaryColor,
                              ),
                              onTap: () async {
                                var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  AuthForm.openHourController.text =
                                      selectedTime.format(context);
                                }
                              },
                              controller: AuthForm.openHourController,
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "to".tr(),
                              style: TextStyles.semiBoldStyle.copyWith(
                                color: AppColors.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            Gap(10),
                            CustomeTextFormField(
                              keyboardType: TextInputType.datetime,
                              textAlign: TextAlign.start,
                              hintText: '10:00 PM',
                              readOnly: true,
                              color: AppColors.greyColor.withValues(alpha: 2.0),
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColors.primaryColor,
                              ),
                              onTap: () async {
                                var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  AuthForm.closeHourController.text =
                                      selectedTime.format(context);
                                }
                              },
                              controller: AuthForm.closeHourController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Text(
                    "phone1".tr(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    hintText: '+20xxxxxxxxxxx',
                    color: AppColors.greyColor.withValues(alpha: 2.0),
                    controller: AuthForm.phone1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "enter_phone".tr();
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  Text(
                    "phone2".tr(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomeTextFormField(
                    controller: AuthForm.phone2Controller,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    hintText: '+20xxxxxxxxxxx',
                    color: AppColors.greyColor.withValues(alpha: 2.0),
                  ),
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
              if (AuthForm.formKey.currentState!.validate()) {
                if (selectedSpecialization == null) {
                  showErrorDialog(context, 'Please select a specialization');
                  return;
                }

                cubit.updateDoctorProfile(
                  uid: cubit.getCurrentUserId() ?? '',
                  specialization: selectedSpecialization!,
                  bio: AuthForm.bioController.text,
                  address: AuthForm.addressController.text,
                  phone1: AuthForm.phone1Controller.text,
                  phone2: AuthForm.phone2Controller.text,
                  openHour: AuthForm.openHourController.text,
                  closeHour: AuthForm.closeHourController.text,
                  imageFile: imagePath,
                );
              }
            },
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.wightColor,
          ),
        ),
      ),
    );
  }

  Future<void> uploadImages({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (file != null) {
      setState(() {
        imagePath = File(file.path);
      });
    }
  }
}
