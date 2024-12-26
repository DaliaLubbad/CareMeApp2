import 'package:flutter/material.dart';

import '../models/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                  'User Name',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const CustomTextField(
                hintText: 'User Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  'Password',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const CustomTextField(
                hintText: 'password',
                icon: Icons.lock,
                suffixIcon: Icons.visibility_off,
                isPassword: true,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff308A99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_forward_sharp, color: Colors.white,size: 17,),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
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
                  ElevatedButton(
                    onPressed: () {},
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
