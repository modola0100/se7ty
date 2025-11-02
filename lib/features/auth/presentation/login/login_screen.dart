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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});

  final EnumUserType userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    String handleUserType() {
      return widget.userType == EnumUserType.doctor
          ? "doctor".tr()
          : "patient".tr();
    }

    var cubit = context.read<AuthCubit>();
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
            child: Form(
              key: cubit.formKey,
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
                    CustomeTextFormField(
                      textAlign: context.locale.languageCode == 'ar'
                          ? TextAlign.end
                          : TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email".tr();
                        }
                        // Remove any whitespace and validate
                        String cleanEmail = value.trim();
                        if (!validationEmail(cleanEmail)) {
                          return "enter_email".tr();
                        }
                        // Update the controller with cleaned email
                        cubit.emailController.text = cleanEmail;
                        return null;
                      },
                      color: AppColors.greyColor.withValues(alpha: 2.0),
                      hintText: 'example.com@',
                      prefixIcon: Icon(
                        Icons.mail,
                        color: AppColors.primaryColor,
                      ),
                      controller: cubit.emailController,
                    ),
                    Gap(20),
                    CustomePassword(
                      controller: cubit.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "password".tr();
                        } else if (!validationPassword(value)) {
                          return "enter_password".tr();
                        }

                        return null;
                      },
                    ),
                    Gap(5),
                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () {},
                        child: Text(
                          "forget_password".tr(),
                          style: TextStyles.regularStyle.copyWith(
                            color: AppColors.darkColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    MainButtonCustom(
                      title: "login".tr(),
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.login(type: widget.userType);
                        }
                      },
                      backgroundColor: AppColors.primaryColor,
                      textColor: AppColors.wightColor,
                      height: 55,
                    ),
                    Gap(50),
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
                              extra: widget.userType,
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
            ),
          ),
        ),
      ),
    );
  }
}
