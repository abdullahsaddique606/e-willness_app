
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screen/splash_screen.dart';
import 'package:myproject/viewmodel/appblogs_viewmmodel.dart';
import 'package:myproject/viewmodel/calories_viewmodel.dart';
import 'package:myproject/viewmodel/doctor_viewmodel.dart';
import 'package:myproject/viewmodel/forgot_viewModel.dart';
import 'package:myproject/viewmodel/homescreen_viewmodel.dart';
import 'package:myproject/viewmodel/login_model.dart';
import 'package:myproject/viewmodel/patient_viewmodel.dart';
import 'package:myproject/viewmodel/signup_viewmodel.dart';
import 'package:myproject/viewmodel/tab_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => SignUPViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => PatientViewModel()),
        ChangeNotifierProvider(create: (context) => DoctorProfileViewModel()),
        ChangeNotifierProvider(create: (context) => TabScreenViewModel()),
        ChangeNotifierProvider(create: (context) => CaloriesViewModel()),
        ChangeNotifierProvider(create: (context) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (context) => AppBlogsViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  SplashScreen(),
      ),
    );
  }
}
