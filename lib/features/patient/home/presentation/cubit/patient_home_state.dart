import 'package:se7ety/features/auth/models/doctor_model.dart';

class PatientHomeState {}

class PatientHomeIntialState extends PatientHomeState {}

class PatientHomeLoadingState extends PatientHomeState {}

class PatientHomeSuccesState extends PatientHomeState {
  final List<DoctorModel> doctors;
  PatientHomeSuccesState(this.doctors);
}

class PatientHomeErrorState extends PatientHomeState {
  final String error;
  PatientHomeErrorState(this.error);
}
