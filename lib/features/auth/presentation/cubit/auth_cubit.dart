import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  regiset({required EnumUserType type}) async {
    emit(LoadingAuthstate());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      User? user = credential.user;
      await user?.updateDisplayName(nameController.text);
      if (type == EnumUserType.doctor) {
        var doctor = DoctorModel(email: emailController.text, name: nameController.text, uid: user?.uid);
        FirebaseFirestore.instance.collection("doctor").doc(user?.uid).set(doctor.toJson());
      } else {
        var patient = PatientModel(email: emailController.text, uid: user?.uid, name: nameController.text);
        FirebaseFirestore.instance.collection("patient").doc(user?.uid).set(patient.toJson());
      }

      emit(SuccesAuthState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(ErrorAuthState('.كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(ErrorAuthState('.البريد الالكتروني مستخدم بالفعل'));
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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      User? user = credential.user;
      final uId = user?.uid;

      if (type == EnumUserType.doctor) {
        FirebaseFirestore.instance.collection("doctor").doc(uId).get();
      }

      if (type == EnumUserType.patient) {
        FirebaseFirestore.instance.collection("patient").doc(uId).get();
      }
      emit(SuccesAuthState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ErrorAuthState('لم يتم العثور على مستخدم بهذالبريد الالكتروني'));
      } else if (e.code == 'wrong-password') {
        emit(ErrorAuthState('.كلمه السر غير صحيحه'));
      } else {
        emit(ErrorAuthState('.حدث خطأما يرجى المحاوله لاحقا'));
      }
    }
  }
}
