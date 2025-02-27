import 'package:flutter/material.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/viewmodel/signup_viewmodel.dart';
import 'package:provider/provider.dart';

import './login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final _formField = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUPViewModel>(builder: (context, viewModel, _) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: DynamicSize.width(1, context),
                  height: DynamicSize.height(1, context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_image.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: DynamicSize.height(0.3, context),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: Colors.blue,
                        ),
                        height: DynamicSize.height(0.6, context),
                        width: DynamicSize.width(0.99, context),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 8),
                                child: Center(
                                  child: Text(
                                    "Create New",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen(
                                                  role: viewModel.selectedRole
                                                      .toString(),
                                                )));
                                  },
                                  child: RichText(
                                      text: const TextSpan(children: [
                                    TextSpan(
                                      text: "Already Registered? ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Login Here ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ])),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Form(
                                  key: _formField,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: TextFormField(
                                          controller: viewModel.username,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: "User name",
                                            hintStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return "Enter user name";
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: TextFormField(
                                          controller: viewModel.email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "yourgmail@gamil.com",
                                            hintStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return "Enter email";
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: TextFormField(
                                          obscureText: viewModel.isObscure,
                                          controller: viewModel.password,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: "Enter password",
                                            hintStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                viewModel.isObscure =
                                                    !viewModel.isObscure;
                                                viewModel.updateStates();
                                              },
                                              child: Icon(viewModel.isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return "Enter Password";
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButtonFormField<String>(
                                          value: viewModel.selectedRole,
                                          items: const [
                                            DropdownMenuItem(
                                              value: "Doctor",
                                              child: Text("Doctor"),
                                            ),
                                            DropdownMenuItem(
                                              value: "Patient",
                                              child: Text("Patient"),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            viewModel.selectedRole = value!;
                                            viewModel.updateStates();
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Select role",
                                            hintStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            }
                                            return "Select a role";
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30.0),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formField.currentState !=
                                                    null &&
                                                _formField.currentState!
                                                    .validate()) {
                                              viewModel.registerMethod(context);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "Sign up",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
