import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screen/forgot_password.dart';

import '../authservices/authservices.dart';
import '../screen/welcome_screen.dart';
import '../widgets/toast_message.dart';

class LoginViewModel with ChangeNotifier {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isPasswordCorrect = false;
  bool isObscure = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void initialize() {}

  updateStates() {
    notifyListeners();
  }

  void loginMethod(BuildContext context) {
    _auth
        .signInWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString())
        .then((value) async {
      isPasswordCorrect = false;
      email.text = "";
      password.text = "";

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .get();

      String role = userDoc.get('role');

      await AuthService().login();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WelcomeScreen(role: role)));
    }).onError((error, stackTrace) {
      isPasswordCorrect = true;
      flutterToastMessage(error.toString());
    });

    notifyListeners();
  }

  forgotPasswordNavigation(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
    notifyListeners();
  }
}
