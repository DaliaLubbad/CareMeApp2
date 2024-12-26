import 'package:flutter/material.dart';
import 'package:test1/screens/OnboardingScreen.dart';
import 'package:test1/screens/account_type_screen.dart';
import 'package:test1/screens/add_activity_screen.dart';
import 'package:test1/screens/booking_screen.dart';
import 'package:test1/screens/document_management.dart';
import 'package:test1/screens/emergency_services.dart';
import 'package:test1/screens/login_screen.dart';
import 'package:test1/screens/medical_services_screen.dart';
import 'package:test1/screens/on_boarding_screen1.dart';
import 'package:test1/screens/register_admin_screen.dart';
import 'package:test1/screens/social_activities.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //home: RegisterScreenAdmin(),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/OnboardingPage': (context) => OnboardingPage(),
        '/AccountTypeScreen': (context) => AccountTypeScreen(),
        '/RegisterScreenAdmin': (context) => AccountTypeScreen(),
        '/RegisterScreenEldery': (context) => AccountTypeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
