import 'package:flutter/material.dart';

class SeniorDashboardScreen extends StatelessWidget {
  final String name;
  final String heartRate;
  final String calories;
  final String weight;

  const SeniorDashboardScreen({
    Key? key,
    required this.name,
    required this.heartRate,
    required this.calories,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.greenAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.person,
                        size: 50.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MetricCard(label: "Heart rate", value: heartRate),
                        _MetricCard(label: "Calories", value: calories),
                        _MetricCard(label: "Weight", value: weight),
                      ],
                    ),
                  ],
                ),
              ),
              // Options List
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Column(
                  children: [
                    _OptionTile(
                      icon: Icons.favorite,
                      label: "My Saved",
                      onTap: () {},
                    ),
                    _OptionTile(
                      icon: Icons.calendar_today,
                      label: "Appointment",
                      onTap: () {},
                    ),
                    _OptionTile(
                      icon: Icons.payment,
                      label: "Payment Method",
                      onTap: () {},
                    ),
                    _OptionTile(
                      icon: Icons.help_outline,
                      label: "FAQs",
                      onTap: () {},
                    ),
                    _OptionTile(
                      icon: Icons.medical_services,
                      label: "Medical Information",
                      onTap: () {},
                    ),
                    _OptionTile(
                      icon: Icons.logout,
                      label: "Logout",
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                      isLogout: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _MetricCard({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _OptionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.black,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          color: isLogout ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Perform logout action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
