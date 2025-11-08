import 'package:flutter/material.dart';

class AuthForm {
  static final formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final nameController = TextEditingController();
  static final bioController = TextEditingController();
  static final addressController = TextEditingController();
  static final phone1Controller = TextEditingController();
  static final phone2Controller = TextEditingController();
  static final openHourController = TextEditingController();
  static final closeHourController = TextEditingController();

  static void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    bioController.dispose();
    addressController.dispose();
    phone1Controller.dispose();
    phone2Controller.dispose();
    openHourController.dispose();
    closeHourController.dispose();
  }
}
