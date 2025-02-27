import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/constants/constatsvalue.dart';

class AppointmentScreen extends StatelessWidget {


  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("------------appointment-${    FirebaseAuth.instance.currentUser?.displayName}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('doctorId', isEqualTo: DynamicSize().user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return  Center(child: Image.asset("assets/images/appointmentpicture.png"));
          }

          final appointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final appointmentDate = (appointment['appointmentDate'] as Timestamp).toDate();

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.green),
                  title: Text(
                    'Patient Name: ${appointment['name']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Appointment Date: ${appointmentDate.toLocal().toString().split(' ')[0]}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
