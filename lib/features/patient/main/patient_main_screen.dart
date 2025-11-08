import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/features/patient/home/presentation/pages/patient_home_screen.dart';
import 'package:se7ety/features/patient/search/presentation/pages/search_screen.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      PatientHomeScreen(),
      SearchScreen(),
      const Center(child: Text('Appointments Screen Coming Soon')),
      const Center(child: Text('Profile Screen Coming Soon')),
    ];

    return Scaffold(
      body: IndexedStack(index: currentindex, children: screen),
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
