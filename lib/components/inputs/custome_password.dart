import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';

class CustomePassword extends StatefulWidget {
  const CustomePassword({super.key, this.validator, this.controller});

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<CustomePassword> createState() => _CustomePasswordState();
}

class _CustomePasswordState extends State<CustomePassword> {
  bool obscureText = true;
  String? errorMessage;

  String? validate(String? value) {
    String? result = widget.validator?.call(value);
    setState(() {
      errorMessage = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validate,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: '***********',
        fillColor: AppColors.inputColor,
        filled: true,
        prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: AppColors.primaryColor),
            ),
            if (errorMessage != null)
              Tooltip(
                message: "password_rules".tr(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(Icons.info_outline, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
