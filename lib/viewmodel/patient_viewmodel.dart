import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/constatsvalue.dart';

class PatientViewModel with ChangeNotifier {
  final fullName = TextEditingController();
  final dob = TextEditingController();
  final age = TextEditingController();

  List<String> selectedDiseases = [];
  List<String> patientDisease = [
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
  ];
  File? selectedImage;

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      updateState();
    }
  }
  updateState() {
    notifyListeners();
  }

  savePatientData(String name) {
    FirebaseFirestore.instance
        .collection(name)
        .doc(DynamicSize().user?.uid) // Assuming each user can have a unique doctor profile
        .set({
      'fullName': fullName.text,
      'dob': dob.text,
      'age':age.text,
      'profile':name,
      'disease': selectedDiseases,
    }).then((value) {
      // Success, do something if needed
      Fluttertoast.showToast(msg: "Patient profile created successfully");
    }).catchError((error) {
      // Error handling
      Fluttertoast.showToast(msg: "Failed to create profile");
    });
  }
}
