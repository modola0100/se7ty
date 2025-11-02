import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/functions/update_image.dart';
import 'package:se7ety/core/functions/validation.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/auth/models/enum_user_type.dart';
import 'package:se7ety/features/auth/models/patient_model.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? specialization;

  final addressController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final openHourController = TextEditingController();
  final closeHourController = TextEditingController();
  final bioController = TextEditingController();

  regiset({required EnumUserType type}) async {
    emit(LoadingAuthstate());
    try {
      // Clean email before sending to Firebase (trim, remove invisible chars, normalize digits)
      final String email = cleanEmail(emailController.text);
      emailController.text = email;

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: passwordController.text,
          );

      User? user = credential.user;
      await user?.updateDisplayName(nameController.text);

      user?.updatePhotoURL(type == EnumUserType.doctor ? "doctro" : "patient");

      if (type == EnumUserType.doctor) {
        var doctor = DoctorModel(
          email: email,
          name: nameController.text,
          uid: user?.uid,
        );
        FirebaseFirestore.instance
            .collection("doctor")
            .doc(user?.uid)
            .set(doctor.toJson());
      } else {
        var patient = PatientModel(
          email: email,
          uid: user?.uid,
          name: nameController.text,
        );
        FirebaseFirestore.instance
            .collection("patient")
            .doc(user?.uid)
            .set(patient.toJson());
      }

      emit(SuccesAuthState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(ErrorAuthState('.كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(ErrorAuthState('.البريد الالكتروني مستخدم بالفعل'));
      } else if (e.code == 'invalid-email') {
        emit(ErrorAuthState('.البريد الالكتروني غير صالح'));
      } else {
        emit(ErrorAuthState('.حدث خطأ ما يرجى المحاوله لاحقا'));
      }
    } catch (e) {
      emit(ErrorAuthState('.حدث خطأ ما يرجى المحاوله لاحقا'));
    }
  }

  login({required EnumUserType type}) async {
    emit(LoadingAuthstate());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      emit(SuccesAuthState(role: credential.user?.photoURL));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ErrorAuthState('.لا يوجد مستخدم بهذا البريد الالكتروني'));
      } else if (e.code == 'wrong-password') {
        emit(ErrorAuthState('.كلمة السر غير صحيحه'));
      } else {
        emit(ErrorAuthState('.حدث خطأ ما يرجى المحاوله لاحقا'));
      }
    } catch (e) {
      emit(ErrorAuthState('.حدث خطأ ما يرجى المحاوله لاحقا'));
    }
  }

  updatedata(File? imagefile) async {
    try {
      emit(LoadingAuthstate());
      if (imagefile == null) {
        emit(ErrorAuthState('.يرجى اختيار صوره'));
        return;
      }
      String? imageUrl = await updateImageToCloudinary(imagefile);
      if (imageUrl == null) {
        emit(ErrorAuthState('فشل رفع الصوره'));
        return;
      }

      var doctor = DoctorModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        specialization: specialization,
        bio: bioController.text,
        address: addressController.text,
        phone1: phone1Controller.text,
        phone2: phone2Controller.text,
        openHour: openHourController.text,
        closeHour: closeHourController.text,
        image: imageUrl,
      );
      FirebaseFirestore.instance
          .collection("doctor")
          .doc(doctor.uid)
          .update(doctor.updateData());
      emit(SuccesAuthState());
    } on Exception catch (_) {
      emit(ErrorAuthState('.حدث خطأ ما يرجى المحاوله لاحقا'));
    }
  }
}
