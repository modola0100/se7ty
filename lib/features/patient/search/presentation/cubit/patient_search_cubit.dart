import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/patient/search/presentation/cubit/patient_search_state.dart';

class PatientSearchCubit extends Cubit<PatientSearchState> {
  PatientSearchCubit() : super(PatientSearchIntialState());

  sortByRate() async {
    emit(PatientSearchLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection("doctor").orderBy("rating", descending: true).get();

      final doctor = snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).where((e) => e.image != null && e.image!.isNotEmpty && e.specialization != null && e.specialization!.isNotEmpty).toList();

      emit(PatientSearchSuccesState(doctor));
    } on Exception catch (_) {
      emit(PatientSearchErrorState('حدث خطأ ما'));
    }
  }

  filterBySpecialization(String specialization) async {
    try {
      emit(PatientSearchLoadingState());

      final snapshot = await FirebaseFirestore.instance.collection("doctor").where("specialization", isEqualTo: specialization).get();

      final doctor = snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).where((e) => e.image != null && e.image!.isNotEmpty && e.rating != null).toList();

      emit(PatientSearchSuccesState(doctor));
    } on Exception catch (_) {
      emit(PatientSearchErrorState('حدث خطأ ما'));
    }
  }

  searchDoctor(String searchKey) async {
    emit(PatientSearchLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance.collection("doctor").orderBy('name').orderBy("rating", descending: true).startAt([searchKey]).endAt(['$searchKey\uf8ff']).get();

      final doctor = snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).where((e) => e.image != null && e.image!.isNotEmpty && e.specialization != null && e.specialization!.isNotEmpty && e.rating != null).toList();

      emit(PatientSearchSuccesState(doctor));
    } on Exception catch (_) {
      emit(PatientSearchErrorState('حدث خطأ ما'));
    }
  }
}
