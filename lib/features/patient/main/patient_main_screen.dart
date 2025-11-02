import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/features/patient/home/presentation/patient_home_screen.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  @override
  Widget build(BuildContext context) {
    int currentindex = 0;
    
    
    final List<Widget> screen = [
        
      const PatientHomeScreen(),
      //patientSearchScreen(),
      //patientAppointmentsScreen(),
      // patientProfileScreen(),
    ];

    return Scaffold(
      body: screen[currentindex],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: "home".tr()),
          TabItem(icon: Icons.search, title: "search".tr()),
          TabItem(icon: Icons.calendar_month, title: "appointments".tr()),
          TabItem(icon: Icons.person, title: "profile".tr()),
        ],
        initialActiveIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
      ),
    );
  }
}
