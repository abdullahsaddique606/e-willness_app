import 'package:flutter/material.dart';

import '../model/doctor_model.dart';
class SingleDoctorProfileScreen extends StatelessWidget {
  final Doctor doctor;

  SingleDoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.specialty),
      ),
      body: Center(
        child: Text('Specialty: ${doctor.years}'),
      ),
    );
  }
}
