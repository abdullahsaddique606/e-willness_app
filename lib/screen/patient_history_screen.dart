import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants/constatsvalue.dart';

class PatientHistory extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add back button functionality here
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Patient')
            .doc(DynamicSize().user?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(
              child: Text('Patient Data not found'),
            );
          }

          final patientData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/avatar1.jpeg")),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patientData['fullName'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'The patient profile',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Add edit button functionality here
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ProfileInfoRow(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: user?.email as String,
                  ),
                  ProfileInfoRow(
                    icon: Icons.calendar_today,
                    title: 'Date Of Birth',
                    subtitle: patientData['dob'],
                  ),
                  ProfileInfoRow(
                    icon: Icons.person,
                    title: 'Age',
                    subtitle: patientData['age'],
                  ),
                  ProfileInfoRow(
                    icon: Icons.category ,
                    title: 'Category',
                    subtitle: patientData['profile'],
                  ),
                  SizedBox(height: 20),
                  // Section(
                  //   title: 'Symptoms',
                  //   onTap: () {
                  //     // Add functionality to add symptoms
                  //   },
                  // ),
                  Section(
                    title: 'Diseases',
                    onTap: () {
                      // Add functionality to add diseases
                    },
                  ),
                  Text(
                    patientData['disease'].toString(),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                  // ListTile(
                  //   title: Icon(Icons.local_hospital_rounded),
                  //   subtitle: patientData['disease'] ,
                  // ),
                  Section(
                    title: 'Wellness Goals',
                    onTap: () {
                      // Add functionality to add wellness goals
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  ProfileInfoRow(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  Section({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: TextStyle(fontSize: 18)),
          trailing: Icon(Icons.add),
          onTap: onTap,
        ),
      ],
    );
  }
}
