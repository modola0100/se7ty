import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/auth/models/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> createUserWithEmail(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> updateUserProfile(
    User user,
    String name,
    String photoUrl,
  ) async {
    await user.updateDisplayName(name);
    await user.updatePhotoURL(photoUrl);
  }

  Future<void> createDoctorProfile(DoctorModel doctor) async {
    await _firestore.collection("doctor").doc(doctor.uid).set(doctor.toJson());
  }

  Future<void> createPatientProfile(PatientModel patient) async {
    await _firestore
        .collection("patient")
        .doc(patient.uid)
        .set(patient.toJson());
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<void> updateDoctorProfile(DoctorModel doctor) async {
    await _firestore
        .collection("doctor")
        .doc(doctor.uid)
        .update(doctor.toJson());
  }
}
