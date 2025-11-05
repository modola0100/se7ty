import 'package:se7ety/features/auth/models/doctor_model.dart';

class PatientSearchState {}

class PatientSearchIntialState extends PatientSearchState {}

class PatientSearchLoadingState extends PatientSearchState {}

class PatientSearchSuccesState extends PatientSearchState {
  final List<DoctorModel> doctors;
  PatientSearchSuccesState(this.doctors);
}

class PatientSearchErrorState extends PatientSearchState {
  final String error;
  PatientSearchErrorState(this.error);
}
