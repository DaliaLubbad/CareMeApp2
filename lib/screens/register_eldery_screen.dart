import 'package:flutter/material.dart';
import '../views/custom_text_field.dart';
import '../views/gender_selection_ui.dart';
import 'login_screen.dart';

class RegisterScreenEldery extends StatelessWidget {
  const RegisterScreenEldery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60.0),
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              const Text(
                'Create a New account',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Please register your details to access your account and enjoy shopping.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 30.0),

              // Full Name Field
              const _FieldLabel(label: 'Full Name'),
              const CustomTextField(
                hintText: 'Enter your name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20.0),

              // Phone Number Field
              const _FieldLabel(label: 'Phone Number'),
              const CustomTextField(
                hintText: 'Enter phone number',
                icon: Icons.phone,
              ),
              const SizedBox(height: 20.0),

              // Email Field
              const _FieldLabel(label: 'E-mail'),
              const CustomTextField(
                hintText: 'Enter your E-mail',
                icon: Icons.email,
              ),
              const SizedBox(height: 20.0),

              // Password Field
              const _FieldLabel(label: 'Password'),
              const CustomTextField(
                hintText: 'Enter password',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20.0),

              // Date of Birth Field
              const _FieldLabel(label: 'date of birth'),
              const CustomTextField(
                hintText: 'DD/MM/YYYY',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 20.0),

              // Gender Selection
              // const Text(
              //   "Gender",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              // ),
              const SizedBox(height: 10.0),
              GenderSelection(),
              const SizedBox(height: 30.0),

              // Register Button
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
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
