import 'package:flutter/material.dart';
import 'package:myproject/constants/constatsvalue.dart';
import 'package:myproject/screen/tab_screen.dart';

import './doctor_profile_screen.dart';
import './patients_profile.dart';

class WelcomeScreen extends StatefulWidget {
  String role;
   WelcomeScreen({super.key,required this.role});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
 String profileName = " ";

  @override
  Widget build(BuildContext context) {
    debugPrint("-----------------${widget.role}");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: DynamicSize.width(1, context),
                height: DynamicSize.height(1, context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/welcome_background_pic.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: DynamicSize.height(0.55, context),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.blue,
                  ),
                  height: DynamicSize.height(0.4, context),
                  width: DynamicSize.width(0.97, context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 8),
                        child: Center(
                          child: Text(
                            "Welcome to App",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "please add your",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "personal Data",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.role == 'Doctor' ?GestureDetector(
                              onTap: () {
                                setState(() {
                                  profileName = "Doctor";
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorProfileScreen(profileName: profileName,)));
                              },
                              child: const Text(
                                "Doctor",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                            ):const SizedBox(),

                            widget.role == 'Patient' ?GestureDetector(
                              onTap: () {
                                setState(() {
                                  profileName = "Patient";
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PatientProfile(profileName: profileName)));
                              },
                              child: const Text(
                                "Patient",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                            ):const SizedBox(),
                          ],
                        ),
                      ),
                      // Center(
                      //   child: RichText(
                      //       text: TextSpan(children: [
                      //     TextSpan(
                      //       text: "Doctor",
                      //       style: TextStyle(
                      //         decoration: TextDecoration.underline,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w800,
                      //         fontSize: 15.0,
                      //       ),
                      //     ),
                      //     TextSpan(
                      //       text: " Or ",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w800,
                      //         fontSize: 15.0,
                      //       ),
                      //     ),
                      //     TextSpan(
                      //       text: "Patient ",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         decoration: TextDecoration.underline,
                      //         fontWeight: FontWeight.w800,
                      //         fontSize: 15.0,
                      //       ),
                      //     ),
                      //   ])),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  TabScreen(role: widget.role,)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Get Started",
                            style:
                                TextStyle(fontSize: 20, color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
