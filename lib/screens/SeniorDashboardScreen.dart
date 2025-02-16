import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AddBankCardScreen.dart';
import 'AddElectronicWalletScreen.dart';
import 'AppointmentCalendarScreen.dart';
import 'ChangePasswordScreen.dart';
import 'MedicalInfoScreen.dart';
import 'login_screen.dart';

class SeniorDashboardScreen extends StatefulWidget {
  final String seniorId;

  const SeniorDashboardScreen({Key? key, required this.seniorId}) : super(key: key);

  @override
  State<SeniorDashboardScreen> createState() => _SeniorDashboardScreenState();
}

class _SeniorDashboardScreenState extends State<SeniorDashboardScreen> {
  String seniorName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSeniorName();
  }

  Future<void> _fetchSeniorName() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('seniors').doc(widget.seniorId).get();
      if (doc.exists) {
        setState(() {
          seniorName = doc['fullName'] ?? 'Unknown';
          isLoading = false;
        });
      } else {
        setState(() {
          seniorName = 'Unknown';
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching senior's name: $e");
      setState(() {
        seniorName = 'Unknown';
        isLoading = false;
      });
    }
  }

  Future<void> _authenticateUser() async {
    String password = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Enter Your Password",
            style: TextStyle(color: Color(0xFF308A99)), // Updated color
          ),
          content: TextField(
            obscureText: true,
            onChanged: (value) => password = value,
            decoration: const InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Color(0xFF308A99)), // Updated color
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF308A99)), // Updated color
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                User? user = FirebaseAuth.instance.currentUser;
                try {
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: user!.email!,
                    password: password,
                  );
                  await user.reauthenticateWithCredential(credential);
                  _showPaymentOptions();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Incorrect password. Try again!")),
                  );
                }
              },
              child: const Text(
                "Verify",
                style: TextStyle(color: Color(0xFF308A99)), // Updated color
              ),
            ),
          ],
        );
      },
    );
  }


  void _showPaymentOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Payment Method",
            style: TextStyle(color: Color(0xFF308A99)),
          ),
          content: const Text("How would you like to proceed?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBankCardScreen(seniorId: widget.seniorId)),
        ),
              child: const Text("Bank Card",
                style: TextStyle(color: Color(0xFF308A99)),
              ),
            ),
            TextButton(
              onPressed:  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddElectronicWalletScreen(seniorId: widget.seniorId)),
              ),
              child: const Text("Electronic Wallet",
                style: TextStyle(color: Color(0xFF308A99)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF308A99),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Text(
              seniorName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ProfileStat(label: "Heart rate", value: "60"),
                _ProfileStat(label: "Steps", value: "10000"),
                _ProfileStat(label: "Weight", value: "55"),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _ProfileOption(icon: Icons.favorite, label: "My Saved", onTap: () {}),
                    _ProfileOption(icon: Icons.calendar_today, label: "Appointment", onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentCalendarScreen(seniorId: widget.seniorId)),
                      );
                    }),
                    _ProfileOption(icon: Icons.payment, label: "Payment Method", onTap: _authenticateUser),
                    _ProfileOption(icon: Icons.password, label: "Change Password", onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                      );
                    }),
                    _ProfileOption(icon: Icons.medical_services, label: "Medical Information", onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MedicalInfoScreen(seniorId: widget.seniorId)),
                      );
                    }),
                    _ProfileOption(icon: Icons.logout, label: "Logout", onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content: const Text("Are you sure you want to log out?"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen(userType: 'elderly')),
                                  );
                                },
                                child: const Text("Log Out", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    }, isLogout: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isLogout;

  const _ProfileOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLogout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(
        label,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
