import 'package:flutter/material.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/viewmodel/calories_viewmodel.dart';
import 'package:provider/provider.dart';

import 'bmi_calculator.dart';

class CaloriesCalculator extends StatelessWidget {
  CaloriesCalculator({super.key});

  final _caloriesFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Consumer<CaloriesViewModel>(builder: (context, viewmodel, _) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Calories and BMI Calculator'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _caloriesFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: viewmodel.ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Age'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your age';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: viewmodel.weightController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Weight (kg)'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your weight';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: viewmodel.heightController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Height (cm)'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your height';
                          }
                          return null;
                        },
                      ),
                      ListTile(
                        title: const Text('Male'),
                        leading: Radio(
                          value: true,
                          groupValue: viewmodel.isMale,
                          onChanged: (value) {
                            viewmodel.isMale = value as bool;
                            viewmodel.updateStates();
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Female'),
                        leading: Radio(
                          value: false,
                          groupValue: viewmodel.isMale,
                          onChanged: (value) {
                            viewmodel.isMale = value as bool;
                            viewmodel.updateStates();
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_caloriesFormKey.currentState!.validate()) {
                            viewmodel.calculateCalories();
                          }
                        },
                        child: const Text('Calculate Calories'),
                      ),
                      if (viewmodel.result > 0)
                        Text(
                          'Your daily calorie intake is ${viewmodel.result} ',
                          style: const TextStyle(fontSize: 18),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BmiCalculator()));
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: DynamicSize.width(0.2, context)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    height: DynamicSize.height(0.07, context),
                    width: DynamicSize.width(0.5, context),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text(
                      "Calculate BMI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
