import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddElectronicWalletScreen extends StatefulWidget {
  final String seniorId;

  const AddElectronicWalletScreen({Key? key, required this.seniorId})
      : super(key: key);

  @override
  _AddElectronicWalletScreenState createState() =>
      _AddElectronicWalletScreenState();
}

class _AddElectronicWalletScreenState extends State<AddElectronicWalletScreen> {
  final TextEditingController _walletProviderController =
  TextEditingController();
  final TextEditingController _walletNumberController = TextEditingController();

  Future<void> _saveElectronicWallet() async {
    if (_walletProviderController.text.isEmpty ||
        _walletNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final walletData = {
      'senior_id': widget.seniorId,
      'wallet_provider': _walletProviderController.text,
      'wallet_number': _walletNumberController.text,
      'type': 'electronic_wallet',
    };

    await FirebaseFirestore.instance.collection('PaymentMethods').add(walletData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Electronic Wallet Saved Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Electronic Wallet"),
        backgroundColor: const Color(0xFF308A99),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _walletProviderController,
              decoration: InputDecoration(
                labelText: "Wallet Provider",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _walletNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Wallet Number",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveElectronicWallet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF308A99),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Save Wallet",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
