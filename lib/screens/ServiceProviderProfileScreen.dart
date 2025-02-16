import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderProfileScreen extends StatefulWidget {
  final String userId;
  final bool isReadOnly;

  const ServiceProviderProfileScreen({Key? key, required this.userId, this.isReadOnly = false}) : super(key: key);

  @override
  _ServiceProviderProfileScreenState createState() => _ServiceProviderProfileScreenState();
}

class _ServiceProviderProfileScreenState extends State<ServiceProviderProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController studyFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('other_users').doc(widget.userId).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          nameController.text = userData!["fullName"] ?? "";
          phoneController.text = userData!["phone"] ?? "";
          descriptionController.text = userData!["description"] ?? "";
          studyFieldController.text = userData!["study_field"] ?? "";
          isLoading = false;

          if (!widget.isReadOnly && (studyFieldController.text.isEmpty || descriptionController.text.isEmpty)) {
            isEditing = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Filling out your Study Field and Description helps seniors choose you!"),
                  backgroundColor: Colors.orange,
                ),
              );
            });
          }
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading profile: $e")),
      );
    }
  }

  Future<void> _updateProfile() async {
    try {
      await FirebaseFirestore.instance.collection('other_users').doc(widget.userId).update({
        "fullName": nameController.text,
        "phone": phoneController.text,
        "description": descriptionController.text,
        "study_field": studyFieldController.text,
      });
      setState(() {
        isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xff308A99),
        foregroundColor: Colors.white,
        actions: widget.isReadOnly
            ? []
            : [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _updateProfile();
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
          ? const Center(child: Text("User not found"))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              _buildEditableField("Full Name", nameController, isEditable: !widget.isReadOnly),
              Text(
                "Role: ${userData!["role"]}",
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              _buildEditableField("Phone", phoneController, icon: Icons.phone, isEditable: !widget.isReadOnly),
              _buildEditableField("Email", TextEditingController(text: userData!["email"]), isEditable: false, icon: Icons.email),
              _buildEditableField("Study Field", studyFieldController, icon: Icons.school, color: Color(0xff308A99), isEditable: !widget.isReadOnly),
              _buildEditableField("Description", descriptionController, icon: Icons.info, color: Color(0xff308A99), isEditable: !widget.isReadOnly),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller, {bool isEditable = true, IconData? icon, Color color = const Color(0xff308A99)}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: icon != null ? Icon(icon, color: Colors.teal) : null,
        title: isEditable
            ? TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: color),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color),
            ),
          ),
        )
            : Text(controller.text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
