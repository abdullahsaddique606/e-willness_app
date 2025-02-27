

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DynamicSize{

  User? user = FirebaseAuth.instance.currentUser;
  static double height(double percentage, BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height * percentage;
  }
  static   String username = "";
  static double width(double percentage, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width * percentage;
  }

}