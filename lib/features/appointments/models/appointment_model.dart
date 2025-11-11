import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? id;
  final String doctorName;
  final String patientName;
  final String patientPhone;
  final String description;
  final DateTime date;
  final String time;

  Appointment({
    this.id,
    required this.doctorName,
    required this.patientName,
    required this.patientPhone,
    required this.description,
    required this.date,
    required this.time,
  });

  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Appointment(
      id: doc.id,
      doctorName: data['doctorName'] ?? '',
      patientName: data['patientName'] ?? '',
      patientPhone: data['patientPhone'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'doctorName': doctorName,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'description': description,
      'date': Timestamp.fromDate(date),
      'time': time,
    };
  }
}
