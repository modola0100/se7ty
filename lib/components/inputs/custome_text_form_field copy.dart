import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';

class CustomeTextFormField extends StatefulWidget {
  const CustomeTextFormField({super.key, this.validator, this.controller, this.prefixIcon, this.hintText, this.suffixIcon, this.color, this.maxLines, this.fontSize, this.readOnly = false, this.keyboardType, this.textAlign = TextAlign.start});

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText;
  final Widget? suffixIcon;
  final Color? color;
  final int? maxLines;
  final double? fontSize;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  @override
  State<CustomeTextFormField> createState() => _CustomeTextFormFieldState();
}

class _CustomeTextFormFieldState extends State<CustomeTextFormField> {
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
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      validator: validate,
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.color, fontSize: widget.fontSize),
        fillColor: AppColors.inputColor,
        filled: true,
        prefixIcon: widget.prefixIcon,
        contentPadding: EdgeInsets.all(20),
        suffixIcon: (errorMessage != null && (widget.hintText == "name".tr() || widget.hintText == 'example.com@'))
            ? Tooltip(
                message: widget.hintText == "name".tr() ? "username_rules".tr() : "email_rules".tr(),
                child: Icon(Icons.info_outline, color: Colors.red),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
