import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment_model.dart';

class FirebaseAppointmentService {
  final CollectionReference _appointmentsCollection = FirebaseFirestore.instance
      .collection('appointments');

  Future<void> addAppointment(Appointment appointment) async {
    await _appointmentsCollection.add(appointment.toFirestore());
  }

  Stream<List<Appointment>> getAppointments() {
    return _appointmentsCollection
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Appointment.fromFirestore(doc))
              .toList();
        });
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _appointmentsCollection.doc(appointmentId).delete();
  }
}
