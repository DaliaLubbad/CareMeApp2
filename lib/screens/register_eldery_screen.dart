import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/custom_text_field.dart';
import '../models/gender_selection_ui.dart';
import 'login_screen.dart';

class RegisterScreenEldery extends StatefulWidget {
  const RegisterScreenEldery({super.key});

  @override
  _RegisterScreenElderyState createState() => _RegisterScreenElderyState();
}

class _RegisterScreenElderyState extends State<RegisterScreenEldery> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers to capture input data
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _gender;

  // Method to handle user registration
  Future<void> _register() async {
    try {
      // 1. Create User with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 2. Save User Additional Data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': _fullNameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'dob': _dobController.text,
        'gender': _gender,
        'role': 'elderly', // Role for elderly users
        'createdAt': Timestamp.now(),
      });

      // 3. Show success dialog
      _showSuccessDialog();
    } catch (e) {
      // Handle any errors that occur during registration
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Custom success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80.0,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'You have successfully reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff308A99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
              CustomTextField(
                controller: _fullNameController,
                hintText: 'Enter your name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20.0),

              // Phone Number Field
              const _FieldLabel(label: 'Phone Number'),
              CustomTextField(
                controller: _phoneController,
                hintText: 'Enter phone number',
                icon: Icons.phone,
              ),
              const SizedBox(height: 20.0),

              // Email Field
              const _FieldLabel(label: 'E-mail'),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter your E-mail',
                icon: Icons.email,
              ),
              const SizedBox(height: 20.0),

              // Password Field
              const _FieldLabel(label: 'Password'),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Enter password',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20.0),

              // Date of Birth Field
              const _FieldLabel(label: 'Date of Birth'),
              CustomTextField(
                controller: _dobController,
                hintText: 'DD/MM/YYYY',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 20.0),

              // Gender Selection
              const GenderSelection(),
              const SizedBox(height: 30.0),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: _register, // Call the registration function
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
