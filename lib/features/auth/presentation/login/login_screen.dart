import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button_custom.dart';
import 'package:se7ety/components/inputs/custome_password.dart';
import 'package:se7ety/components/inputs/custome_text_form_field%20copy.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/functions/dialog.dart';
import 'package:se7ety/core/functions/validation.dart';
import 'package:se7ety/core/routes/navigator.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/auth/models/enum_user_type.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7ety/features/auth/presentation/widgets/auth_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.userType});

  final EnumUserType userType;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    String handleUserType() {
      return userType == EnumUserType.doctor ? "doctor".tr() : "patient".tr();
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        if (state is LoadingAuthstate) {
          showLoadingDialog(context);
        } else if (state is SuccesAuthState) {
          pop(context);
          if (state.role == "doctor") {
            //pushWithReplacement(context, Routes.doctorMain);
          } else if (state.role == "patient") {
            pushWithReplacement(context, Routes.patientMain);
          }
          log('login success');
        } else if (state is ErrorAuthState) {
          pop(context);
          showErrorDialog(context, state.error ?? '');
          log('login failed');
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logoPng, height: 250, width: 250),
                  Text(
                    "splash".tr(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.greenColor,
                      fontSize: 20,
                    ),
                  ),
                  Gap(40),
                  Text(
                    "login_as".tr() + " " + handleUserType(),
                    style: TextStyles.semiBoldStyle.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: isArabic ? 20 : 16,
                    ),
                  ),
                  Gap(30),
                  Form(
                    key: AuthForm.formKey,
                    child: Column(
                      children: [
                        CustomeTextFormField(
                          textAlign: context.locale.languageCode == 'ar'
                              ? TextAlign.end
                              : TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "email".tr();
                            } else if (!validationEmail(value)) {
                              return "enter_email";
                            }
                            return null;
                          },
                          color: AppColors.greyColor.withValues(alpha: 2.0),
                          hintText: 'example.com@',
                          prefixIcon: Icon(
                            Icons.mail,
                            color: AppColors.primaryColor,
                          ),
                          controller: AuthForm.emailController,
                        ),
                        Gap(20),
                        CustomePassword(
                          controller: AuthForm.passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password".tr();
                            } else if (!validationPassword(value)) {
                              return "enter_password".tr();
                            }
                            return null;
                          },
                        ),
                        Gap(30),
                        MainButtonCustom(
                          title: "login".tr(),
                          onPressed: () {
                            if (AuthForm.formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                email: AuthForm.emailController.text,
                                password: AuthForm.passwordController.text,
                              );
                            }
                          },
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.wightColor,
                          height: 55,
                        ),
                        Gap(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "no_account".tr(),
                              style: TextStyles.semiBoldStyle.copyWith(
                                color: AppColors.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                              ),
                              onPressed: () {
                                pushWithReplacement(
                                  context,
                                  Routes.register,
                                  extra: userType,
                                );
                              },
                              child: Text(
                                "login_now".tr(),
                                style: TextStyles.semiBoldStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
