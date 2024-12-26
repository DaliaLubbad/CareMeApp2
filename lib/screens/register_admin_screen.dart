import 'package:flutter/material.dart';

import '../models/custom_text_field.dart';
import 'login_screen.dart';

class RegisterScreenAdmin extends StatelessWidget {
  const RegisterScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80.0),
              Center(
                child: Column(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70.0,
                      backgroundImage: AssetImage('assets/images/Logo.png'),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              const Text(
                'Hello',
                style: TextStyle(fontSize: 24),
              ),
              const Text(
                'Create a New account',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Please register your details to access your account and enjoy shopping.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 30.0),

              // Full Name Field
              const _FieldLabel(label: 'Full Name'),
              const CustomTextField(hintText: 'Enter your name', icon: Icons.person),

              const SizedBox(height: 20.0),

              // Phone Number Field
              const _FieldLabel(label: 'Phone Number'),
              const CustomTextField(hintText: 'Enter phone number', icon: Icons.phone),

              const SizedBox(height: 20.0),

              // Email Field
              const _FieldLabel(label: 'E-mail'),
              const CustomTextField(hintText: 'Enter your E-mail', icon: Icons.email),

              const SizedBox(height: 20.0),

              // Password Field
              const _FieldLabel(label: 'Password'),
              const CustomTextField(
                hintText: 'Enter password',
                icon: Icons.lock,
                isPassword: true,
              ),

              const SizedBox(height: 20.0),

              // Description Field
              const _FieldLabel(label: 'Description'),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF1F4FD),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),

              const SizedBox(height: 30.0),

              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  // handell a function that if registration done push to login screen
                onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff308A99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(width: 8.0),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}


