import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/widgets/toast_message.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();

  resetPassword(BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(
        email: emailController.text,
      );
      flutterToastMessage("Reset Password email sent to mention mail");
    } catch (e) {
      flutterToastMessage("Failed to sent email to email");
    }
    notifyListeners();
  }
}
