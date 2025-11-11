import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appointment_model.dart';
import '../services/firebase_appointment_service.dart';

class BookingScreen extends StatefulWidget {
  final String doctorName;

  const BookingScreen({Key? key, required this.doctorName}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _patientPhoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedTime;

  final List<String> _availableTimes = [
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _bookAppointment() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null) {
      final appointment = Appointment(
        doctorName: widget.doctorName,
        patientName: _patientNameController.text,
        patientPhone: _patientPhoneController.text,
        description: _descriptionController.text,
        date: _selectedDate!,
        time: _selectedTime!,
      );
      FirebaseAppointmentService()
          .addAppointment(appointment)
          .then((_) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment Booked Successfully!'),
                ),
              );
              Navigator.pop(context);
            }
          })
          .catchError((error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to book appointment: $error')),
              );
            }
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select date/time'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('احجز مع دكتورك'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'د. ${widget.doctorName}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'جراحة عامة', // This should ideally come from doctor data
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Text(
                                '3',
                              ), // This should ideally come from doctor data
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                '-- ادخل بيانات الحجز --',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text('اسم المريض'),
              TextFormField(
                controller: _patientNameController,
                decoration: const InputDecoration(
                  hintText: 'علي احمد',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال اسم المريض';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('رقم الهاتف'),
              TextFormField(
                controller: _patientPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '01023456235',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('وصف الحالة'),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'مفيش بس برد',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال وصف الحالة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('تاريخ الحجز'),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text(
                        _selectedDate == null
                            ? 'اختر التاريخ'
                            : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('وقت الحجز'),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _availableTimes.map((time) {
                  return ChoiceChip(
                    label: Text(time),
                    selected: _selectedTime == time,
                    onSelected: (selected) {
                      setState(() {
                        _selectedTime = selected ? time : null;
                      });
                    },
                    selectedColor: Colors.teal,
                    labelStyle: TextStyle(
                      color: _selectedTime == time
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'تأكيد الحجز',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
