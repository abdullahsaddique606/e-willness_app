

import 'package:flutter/cupertino.dart';

class CaloriesViewModel with ChangeNotifier{

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  bool isMale = true;
  double result = 0.0;


  updateStates(){
    notifyListeners();
  }
  void calculateCalories() {

      int age = int.parse(ageController.text);
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double calories = isMale
          ? 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age)
          : 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);

      result = calories;
      notifyListeners();
    }

}