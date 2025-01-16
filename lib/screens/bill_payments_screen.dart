import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddBankCardScreen.dart';
import 'AddElectronicWalletScreen.dart';
import 'MyBillsScreen.dart';
import 'add_bill_screen.dart';

class BillPaymentScreen extends StatefulWidget {
  final String seniorId;

  const BillPaymentScreen({Key? key, required this.seniorId}) : super(key: key);

  @override
  _BillPaymentScreenState createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  void _navigateToBankCardData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBankCardScreen(seniorId: widget.seniorId),
      ),
    );
  }

  void _navigateToElectronicWalletData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddElectronicWalletScreen(seniorId: widget.seniorId),
      ),
    );
  }

  void _navigateToMyBills() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyBillsScreen(seniorId: widget.seniorId),
      ),
    );
  }

  void _navigateToAddBill(String billType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBillScreen(
          seniorId: widget.seniorId,
          billType: billType,
        ),
      ),
    ).then((_) => setState(() {})); // Refresh the list after returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Payment'),
        backgroundColor: const Color(0xFF308A99),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Most Used Services Grid
            const Text(
              'Most used services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: [
                _buildServiceTile('Mobile bill', 'assets/images/mobile_bill.jpeg', 'mobile_bill'),
                _buildServiceTile('Internet bill', 'assets/images/internet.jpeg', 'internet_bill'),
                _buildServiceTile('Car', 'assets/images/car.png', 'car'),
                _buildServiceTile('Water bill', 'assets/images/water.jpeg', 'water_bill'),
                _buildServiceTile('Electricity', 'assets/images/electricity.jpeg', 'electricity'),
                _buildServiceTile('Landline', 'assets/images/telephone.jpeg', 'landline'),
                _buildServiceTile('Insurance', 'assets/images/social_insurance.jpeg', 'insurance'),
                _buildServiceTile('Tickets', 'assets/images/tickets.jpeg', 'tickets'),
                _buildServiceTile('Gas', 'assets/images/gas.png', 'gas'),
                _buildServiceTile('Landline', 'assets/images/telephone.jpeg', 'landline'),
                _buildServiceTile('Insurance', 'assets/images/social_insurance.jpeg', 'insurance'),
                _buildServiceTile('Tickets', 'assets/images/tickets.jpeg', 'tickets'),
              ],

            ),

            const SizedBox(height: 16),

            // Navigation Buttons Section
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: _navigateToMyBills,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF308A99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'My Bills',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: _navigateToBankCardData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF308A99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Bank Card Data',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: _navigateToElectronicWalletData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF308A99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Electronic Wallet Data',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildServiceTile(String label, String imagePath, String billType) {
    return GestureDetector(
      onTap: () => _navigateToAddBill(billType),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
