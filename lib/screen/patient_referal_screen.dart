import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'doctor_profile.dart';

class PatientReferralScreen extends StatelessWidget {
  const PatientReferralScreen({Key? key}) : super(key: key);

  Future<List<String>> _getPatientDiseases() async {
    try {
      DocumentSnapshot patientDoc = await FirebaseFirestore.instance
          .collection("Patient")
          .doc(DynamicSize().user!.uid)

          .get();

      if (patientDoc.exists) {
        List<String> diseases = List<String>.from(patientDoc.get('disease'));
        print("Patient diseases: $diseases");
        return diseases;
      } else {
        print("Patient document does not exist.");
        return [];
      }
    } catch (e) {
      print("Error fetching patient diseases: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _getPatientDiseases(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<String> patientDiseases = snapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Doctor').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final doctors = snapshot.data!.docs.where((doc) {
                final doctor = doc.data() as Map<String, dynamic>;
                final doctorDiseases = List<String>.from(doctor['disease']);
                bool matches = doctorDiseases
                    .any((disease) => patientDiseases.contains(disease));
                print(
                    "Doctor ${doctor['fullName']} matches: $matches with diseases: ${doctor['disease']}");
                return matches;
              }).toList();

              if (doctors.isEmpty) {
                return const Center(child: Text("No matching doctors found."));
              }

              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorProfile(doctorId: doctors[index].id),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    doctor['profileImage'] as String),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor['fullName'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      doctor['disease'].join(', '),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
