import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myproject/screen/doctor_profilescreen.dart';
import '../model/doctor_model.dart';

class DoctorListScreen extends StatelessWidget {
  final String selectedDisease;

  DoctorListScreen({super.key, required this.selectedDisease});

  List<Doctor> doctors = [
    Doctor(
        name: 'Dr. Bilal Afzal',
        specialty: 'Child specialist',
        degree: 'MBBS',
        years: '8 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Wednesday'),
    Doctor(
        name: 'Dr. Ishfaq Bhatti',
        specialty: 'General physician',
        degree: 'MBBS',
        years: '5 years',
        officeTime: '11:00am to 4:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Muhammad Hussain',
        specialty: 'Eye specialist',
        degree: 'MBBS, FCPS',
        years: '6 years',
        officeTime: '12:00pm to 5:00pm',
        schedule: 'Monday to Friday'),
    Doctor(
        name: 'Dr. Waqas',
        specialty: 'Urologist',
        degree: 'MBBS',
        years: '7 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Saturday'),
    Doctor(
        name: 'Dr. Tariq Mehmood',
        specialty: 'Neuro surgeon, Neurologist',
        degree: 'MBBS, RMP, FCPS',
        years: '9 years',
        officeTime: '9:00am to 2:00pm',
        schedule: 'Monday to Wednesday'),
    Doctor(
        name: 'Dr. Haris',
        specialty: 'General physician',
        degree: 'MBBS, FCPS',
        years: '12 years',
        officeTime: '1:00pm to 6:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Roshan',
        specialty: 'Skin specialist, Asthetic physician',
        degree: 'MBBS',
        years: '3 years',
        officeTime: '9:00am to 3:00pm',
        schedule: 'Monday to Thursday'),
    Doctor(
        name: 'Dr. Ammara Afsheen Mehtab',
        specialty: 'General physician, Surgeon',
        degree: 'MBBS, RMP',
        years: '3 years',
        officeTime: '11:00am to 3:00pm',
        schedule: 'Monday to Friday'),
    Doctor(
        name: 'Dr. Shehroz',
        specialty: 'Dentist, Dental care',
        degree: 'MBBS',
        years: '5 years',
        officeTime: '8:00am to 3:00pm',
        schedule: 'Monday to Saturday'),
    Doctor(
        name: 'Dr. Rashmin',
        specialty: 'General physician',
        degree: 'MBBS, FCPS',
        years: '7 years',
        officeTime: '9:00am to 3:00pm',
        schedule: 'Monday to Thursday'),
    Doctor(
        name: 'Dr. Habib Ullah Khan',
        specialty: 'General physician',
        degree: 'MBBS, RMP',
        years: '8 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Wednesday'),
    Doctor(
        name: 'Dr. Muhammad Yousaf',
        specialty: 'General physician',
        degree: 'MBBS',
        years: '9 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Jibran Javed',
        specialty: 'Child specialist',
        degree: 'MBBS',
        years: '8 years',
        officeTime: '9:00am to 3:00pm',
        schedule: 'Monday to Saturday'),
    Doctor(
        name: 'Dr. Ammra Basheer',
        specialty: 'Skin specialist, Asthetic physician',
        degree: 'MBBS',
        years: '10 years',
        officeTime: '8:00am to 3:00pm',
        schedule: 'Monday to Friday'),
    Doctor(
        name: 'Dr. Azhar Mehboob',
        specialty: 'Physiotherapist',
        degree: 'MBBS',
        years: '5 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Sandleen Jawad Begum',
        specialty: 'Backpain problems, Stroke and post operative rehabilations, shoulder impingement',
        degree: 'MBBS',
        years: '4 years',
        officeTime: '10:00am to 2:00pm',
        schedule: 'Monday to Friday'),
    Doctor(
        name: 'Dr. Ishrat Noureen',
        specialty: 'General physician',
        degree: 'MBBS',
        years: '5 years',
        officeTime: '11:00am to 4:00pm',
        schedule: 'Monday to Saturday'),
    Doctor(
        name: 'Dr. Syeda Asma Sahar',
        specialty: 'Uncategorized',
        degree: 'MBBS',
        years: '7 years',
        officeTime: '11:00am to 4:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Mushtaq Ahmed Bhatti',
        specialty: 'Gynecologist',
        degree: 'MBBS',
        years: '9 years',
        officeTime: '12:00pm to 5:00pm',
        schedule: 'Monday to Saturday'),
    Doctor(
        name: 'Dr. Hafeez',
        specialty: 'General physician',
        degree: 'MBBS, FCPS',
        years: '7 years',
        officeTime: '11:00am to 3:00pm',
        schedule: 'Monday to Saturday'),
    Doctor(
        name: 'Dr. Mushtaq Awan',
        specialty: 'Urologist',
        degree: 'MBBS',
        years: '6 years',
        officeTime: '6:00pm to 10:00pm',
        schedule: 'Monday to Wednesday'),
    Doctor(
        name: 'Dr. Muhammad Taimoor',
        specialty: 'Ultrasound',
        degree: 'MBBS, FCPS',
        years: '12 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Wednesday'),
    Doctor(
        name: 'Dr. Nadia Wajid',
        specialty: 'Uncategorized',
        degree: 'MBBS',
        years: '6 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Friday'),
    Doctor(
        name: 'Dr. Hafiz Tayyab',
        specialty: 'Gynecologist, Lab Services',
        degree: 'MBBS',
        years: '7 years',
        officeTime: '9:00am to 2:00pm',
        schedule: 'Monday to Tuesday'),
    Doctor(
        name: 'Dr. Amjad Ali',
        specialty: 'Surgical Specialist',
        degree: 'MBBS, MPH, MS',
        years: '8 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Waheeda Hussain',
        specialty: 'General physician',
        degree: 'MBBS, RMP',
        years: '9 years',
        officeTime: '10:00am to 3:00pm',
        schedule: 'Monday to Wednesday'),
    Doctor(
        name: 'Dr. Armaghana Ahmed',
        specialty: 'Orthopedic Surgery',
        degree: 'MBBS, FCPS',
        years: '6 years',
        officeTime: '7:00am to 12:00pm',
        schedule: 'Monday to Sunday'),
    Doctor(
        name: 'Dr. Itrat Naseem',
        specialty: 'Gynecologit',
        degree: 'MBBS, FCPS',
        years: '6 years',
        officeTime: '7:00am to 12:00pm',
        schedule: 'Monday to Sunday'),
  ];

  // Function to get a random name from a list of names
  String getRandomName() {
    var names = [
      'Bilal Afzal',
      'Ishfaq Bhatti',
      'Muhammad Hussain',
      'Waqas',
      'Tariq Mehmood',
      'Haris',
      'Roshan',
      'Ammara Afsheen Mehtab',
      'Shehroz',
      'Rashmin',
      'Habib Ullah Khan',
      'Muhammad Yousaf',
      'Jibran Javed',
      'Ammra Basheer',
      'Azhar Mehboob',
      'Sandleen Jawad Begum',
      'Ishrat Noureen',
      'Syeda Asma Sahar',
      'Mushtaq Ahmed Bhatti',
      'Hafeez',
      'Mushtaq Awan',
      'Muhammad Taimoor',
      'Nadia Wajid',
      'Hafiz Tayyab',
      'Amjad Ali',
      'Waheeda Hussain',
      'Armaghana Ahmed',
      'Itrat Naseem',
      'Irfan Ahmed',
      'Muhammad Farooq',
      'Naveed Ahmed',
      'Sadaf Iqbal',
      'Zubair Javed',
      'Jawad',
      'Shaukat Nawaz'
    ];
    var random = Random();
    return names[random.nextInt(names.length)];
  }

  // Function to get a random specialty from a list of diseases
  String getRandomSpecialty() {
    var specialties = [
      'flu',
      'bronchitis',
      'pneumonia',
      'heart attack',
      'stroke',
      'cancer',
      'diabetes',
      'alzheimer',
      'arthritis',
      'adenovirus',
      'aflatoxicosis',
      'alcoholism',
      'allergic rhinitis',
      'alzheimers disease',
      'anemia',
      'anxiety disorder',
      'appendicitis',
      'asperger syndrome',
      'asthma',
      'bacterial meningitis',
      'bipolar disorder',
      'bladder cancer',
      'blood clot',
      'bursitis',
      'cervical cancer',
      'chickenpox',
      'chronic obstructive pulmonary disease (copd)',
      'cholesterol',
      'common cold',
      'conjunctivitis',
      'depression',
      'diarrhea',
      'eating disorder',
      'epilepsy',
      'fever',
      'food poisoning',
      'gallstones',
      'gonorrhea',
      'heart disease',
      'hepatitis',
      'herpes',
      'influenza',
      'irritable bowel syndrome (ibs)',
      'kidney stones',
      'lung cancer',
      'malaria',
      'measles',
      'meningitis',
      'mononucleosis',
      'rabies',
      'salmonella',
      'shingles',
      'tuberculosis (tb)',
      'urinary tract infection (uti)',
      'varicose veins',
      'warts',
      'yeast infection',
      'acanthamoebkeratitis',
      'acute appendicitis',
      'acute kidney injury (aki)',
      "alzheimer's disease",
      'aortic aneurysm',
      'colorectal cancer',
      'dementia',
      'erectile dysfunction',
      'fibromyalgia',
      'glaucoma',
      'heart failure',
      'kidney disease',
      'lung disease',
      "parkinson's disease",
      'peptic ulcer disease',
      'peripheral artery disease',
      'prostate cancer',
      'rheumatoid arthritis',
      'stomach cancer',
      'thyroid cancer',
      'ulcerative colitis',
      'atopic dermatitis',
      'celiac disease',
      'chronic kidney disease',
      "crohn's disease",
      "graves' disease",
      "hashimoto's thyroiditis",
      'lupus'
      // Add other specialties here...
    ];
    var random = Random();
    return specialties[random.nextInt(specialties.length)];
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();

    // Generate new doctors with random attributes
    List<Doctor> generatedDoctors = List.generate(20, (index) {
      return Doctor(
        name: 'Dr. ${getRandomName()}',
        specialty: getRandomSpecialty(),
        degree: 'MBBS, ${getRandomSpecialty()}',
        years: '${random.nextInt(15) + 1} years',
        officeTime: '${random.nextInt(12) + 7}:00am to ${random.nextInt(6) + 1}:00pm',
        schedule: 'Monday to ${['Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][random.nextInt(5)]}',
      );
    });

    // Filter doctors based on selected disease
    List<Doctor> filteredDoctors = generatedDoctors.where((doctor) =>
        doctor.specialty.toLowerCase().contains(selectedDisease.toLowerCase())).toList();

    // Ensure at least two doctors per disease
    while (filteredDoctors.length < 2) {
      var newDoctor = generatedDoctors[random.nextInt(generatedDoctors.length)];
      if (!filteredDoctors.contains(newDoctor)) {
        filteredDoctors.add(newDoctor);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors for $selectedDisease'),
      ),
      body: ListView.builder(
        itemCount: filteredDoctors.length,
        itemBuilder: (context, index) {
          final doctor = filteredDoctors[index];
          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.years),
            onTap: () {
              // Navigate to the doctor's profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SingleDoctorProfileScreen(doctor: doctor),
                ),
              );
            },
          );
        },
      ),
    );
  }
}