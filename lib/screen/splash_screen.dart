import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:myproject/screen/signup_screen.dart';
import 'package:myproject/screen/welcome_screen.dart';

import '../authservices/authservices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = "";
  @override
  void initState() {
    super.initState();
   _loadScreen();
  }
  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          role = userDoc['role'];
          return userDoc.data() as Map<String, dynamic>?;
        } else {
          debugPrint('User document does not exist');
        }
      } else {
        debugPrint('No user is signed in');
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }

    return null;
  }
  Future<void> _loadScreen() async {
    fetchUserData();

    final isLoggedIn = await AuthService().isLoggedIn();
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? WelcomeScreen(role: role,) : SignUpScreen(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash_newlogo.jpeg"),
      ),
    );
  }
}
