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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});

  final EnumUserType userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
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
          log('register success');
        } else if (state is ErrorAuthState) {
          pop(context);
          showErrorDialog(context, state.error ?? '');
          log('register failed');
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
                    Gap(20),
                    Text(
                      "${"signup_as".tr()} ${handleUserType()}",
                      style: TextStyles.semiBoldStyle.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    Gap(10),
                    CustomeTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter_name".tr();
                        } else if (!validationUserName(value)) {
                          return "enter_name2".tr();
                        }
                        return null;
                      },
                      color: AppColors.greyColor.withValues(alpha: 2.0),
                      hintText: "name".tr(),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                      controller: cubit.nameController,
                    ),
                    Gap(10),
                    CustomeTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email".tr();
                        } else if (!validationEmail(value)) {
                          return "enter_email".tr();
                        }
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
                    Gap(10),
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
                    Gap(35),

                    MainButtonCustom(
                      title: "signup".tr(),
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.regiset(type: widget.userType);
                        }
                      },
                      backgroundColor: AppColors.primaryColor,
                      textColor: AppColors.wightColor,
                      height: 55,
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "have_account".tr(),
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
                              Routes.login,
                              extra: widget.userType,
                            );
                          },
                          child: Text(
                            "login2".tr(),
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
