import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screen/login_screen.dart';

import '../widgets/toast_message.dart';

class SignUPViewModel with ChangeNotifier {
  final email = TextEditingController();
  bool isObscure = true;
  final username = TextEditingController();

  final password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedRole;

  updateStates() {
    notifyListeners();
  }

  void registerMethod(BuildContext context) {
    _auth
        .createUserWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString())
        .then((value) {
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
        'username': username.text.toString(),
        'email': email.text.toString(),
        'role': selectedRole.toString(),
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen(role: selectedRole.toString())));
    }).onError((error, stackTrace) {
      flutterToastMessage(error.toString());
    });
    notifyListeners();
  }
}
