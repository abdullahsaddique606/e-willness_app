import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class DoctorProfileViewModel with ChangeNotifier {
  List<String> availableDays = [];
  final fullName = TextEditingController();
  final dob = TextEditingController();
  final specialist = TextEditingController();
  final address = TextEditingController();
  final number = TextEditingController();
  final qualification = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  List<String> selectedDiseases = [];

  List<String> doctorSpecialist = [
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
      profileImageUrl = null; // Set to null to trigger UI update with selected image
      notifyListeners();
    }
  }


  updateState() {
    notifyListeners();
  }
  Future<String> uploadImage(File imageFile, User? user) async {
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${user!.uid}.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {});

      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Error uploading profile image: $e');
    }
  }



  String? profileImageUrl;

  Future<void> loadProfileData(String profileName) async {
    Map<String, dynamic>? profileData = await fetchDoctorProfile(profileName);
    if (profileData != null) {
      profileImageUrl = profileData['profileImage'] as String?;


      notifyListeners();
    }
  }

  Future<Map<String, dynamic>?> fetchDoctorProfile(String doctor) async {
    if (user == null) {
      return null;
    }

    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection(doctor)
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      debugPrint("data is  available");
      debugPrint("-----------------${docSnapshot['fullName']}");
      notifyListeners();
      return docSnapshot.data() as Map<String, dynamic>?;


    } else {
      debugPrint("data is not available");
      notifyListeners();
      return null;
    }

  }
  String? imageURL;
  saveDoctorProfile(String doctor, File? selectedImage) async {

    if (user == null) {
      Fluttertoast.showToast(msg: "User not logged in");
      return;
    }


    if (selectedImage != null) {
      try {
        imageURL = await uploadImage(selectedImage, user);
      } catch (e) {
        Fluttertoast.showToast(msg: "Failed to upload image: $e");
        return;
      }
    }
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(FirebaseAuth.instance.currentUser?.uid) // Assuming each user can have a unique doctor profile
        .set({
      'fullName': fullName.text,
      'dob': dob.text,
      'disease': selectedDiseases,
      'address': address.text,
      'number' :number.text,
      'Qualification': qualification.text,
      'profileImage': imageURL ?? '',
      'Available' : availableDays.toString(),
      'startTime'  :startTime.toString(),
      'endTime' : endTime.toString()
    }).then((value) {
      // Success, do something if needed
      Fluttertoast.showToast(msg: "profile created Successfully");
    }).catchError((error) {
      // Error handling
      Fluttertoast.showToast(msg: 'Failed to create profile: $error');
    });
  }
}
