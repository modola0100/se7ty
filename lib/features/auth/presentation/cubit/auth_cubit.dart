import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/auth/domain/repositories/auth_repository.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/auth/models/enum_user_type.dart';
import 'package:se7ety/features/auth/models/patient_model.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7ety/core/functions/update_image.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(InitialAuthState());

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required EnumUserType type,
  }) async {
    emit(LoadingAuthstate());
    try {
      // Step 1: Create authentication account
      final credential = await _authRepository.createUserWithEmail(
        email,
        password,
      );
      final user = credential.user;

      if (user == null) {
        emit(ErrorAuthState('Failed to create user'));
        return;
      }

      // Step 2: Update user profile
      await _authRepository.updateUserProfile(
        user,
        name,
        type == EnumUserType.doctor ? "doctor" : "patient",
      );

      // Step 3: Create user profile in Firestore
      if (type == EnumUserType.doctor) {
        await _authRepository.createDoctorProfile(
          DoctorModel(email: email, name: name, uid: user.uid),
        );
      } else {
        await _authRepository.createPatientProfile(
          PatientModel(email: email, name: name, uid: user.uid),
        );
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

  Future<void> login({required String email, required String password}) async {
    emit(LoadingAuthstate());
    try {
      final credential = await _authRepository.signInWithEmail(email, password);
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

  String? getCurrentUserId() {
    return _authRepository.getCurrentUserId();
  }

  Future<void> updateDoctorProfile({
    required String uid,
    required String specialization,
    required String bio,
    required String address,
    required String phone1,
    required String phone2,
    required String openHour,
    required String closeHour,
    required File? imageFile,
  }) async {
    try {
      emit(LoadingAuthstate());

      if (imageFile == null) {
        emit(ErrorAuthState('.يرجى اختيار صوره'));
        return;
      }

      final imageUrl = await updateImageToCloudinary(imageFile);

      final doctor = DoctorModel(
        uid: uid,
        specialization: specialization,
        bio: bio,
        address: address,
        phone1: phone1,
        phone2: phone2,
        openHour: openHour,
        closeHour: closeHour,
        image: imageUrl,
      );

      await _authRepository.updateDoctorProfile(doctor);
      emit(SuccesAuthState());
    } catch (e) {
      emit(ErrorAuthState('.حدث خطأ ما يرجى المحاوله لاحقا'));
    }
  }
}
