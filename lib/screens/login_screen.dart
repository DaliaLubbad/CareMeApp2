import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test1/screens/social_activities.dart';

import '../models/custom_text_field.dart';
import 'account_type_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {

      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password. Please try again.';
      } else {
        message = 'An error occurred. Please try again.';
        print(e.code);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                  'Yeay! Welcome Back',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Once again you login successfully into CareMee app',
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
                      backgroundColor: Color(0xff308A99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SocialActivitiesScreen()),
                      );
                    },
                    child: const Text(
                      'Go to home',
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/Logo.png'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              const Text(
                'Hello',
                style: TextStyle(fontSize: 24),
              ),
              const Text(
                'Welcome back!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please login to access your account and enjoy shopping',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  'E-mail',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              CustomTextField(
                hintText: 'Enter your email',
                icon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  'Password',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              CustomTextField(
                hintText: 'Enter your password',
                icon: Icons.lock,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff308A99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward_sharp, color: Colors.white, size: 17),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AccountTypeScreen()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Color(0xff308A99)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xFFD3D3D3),
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'Or login with',
                    style: TextStyle(
                      color: Color(0xFFB0B0B0),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xFFD3D3D3),
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Google Login Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Facebook Login Button
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/facebook.png',
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Facebook',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
