import 'package:flutter/material.dart';
import 'package:myproject/screen/patient_alldoctor_screen.dart';
import 'package:myproject/screen/patient_referal_screen.dart';
import 'package:myproject/screen/personalblogsscreen.dart';

import 'appblogsscreen.dart';

class PatientTabBarScreen extends StatefulWidget {
  const PatientTabBarScreen({super.key});

  @override
  State<PatientTabBarScreen> createState() => _PatientTabBarScreenState();
}

class _PatientTabBarScreenState extends State<PatientTabBarScreen> {
  bool isAppBlogsSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isAppBlogsSelected ? const PatientAllDoctorScreen() :  PatientReferralScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ToggleButtons(
          isSelected: [isAppBlogsSelected, !isAppBlogsSelected],
          onPressed: (index) {
            setState(() {
              isAppBlogsSelected = index == 0;
            });
          },
          borderRadius: BorderRadius.circular(8.0),
          selectedBorderColor: Colors.blue,
          selectedColor: Colors.white,
          fillColor: Colors.blue,
          color: Colors.blue,
          constraints: BoxConstraints(
            minHeight: 50.0,
            minWidth: MediaQuery.of(context).size.width / 2 - 24,
          ),
          children: const <Widget>[
            Text('All Doctors', style: TextStyle(fontSize: 18)),
            Text('Recommended', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
