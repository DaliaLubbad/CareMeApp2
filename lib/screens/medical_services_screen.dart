import 'package:flutter/material.dart';



class MedicalServicesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'icon': 'assets/eye.png', 'label': 'Eyes'},
    {'icon': 'assets/pharmacy.png', 'label': 'Pharmacy'},
    {'icon': 'assets/nose.png', 'label': 'Nose and Ear'},
    {'icon': 'assets/bones.png', 'label': 'Bones'},
    {'icon': 'assets/more.png', 'label': 'More'},
  ];

  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Muhammad Al-Ghazali',
      'price': '50 \$',
      'image': 'assets/doctor.png'
    },
    {
      'name': 'Dr. Muhammad Al-Ghazali',
      'price': '50 \$',
      'image': 'assets/doctor.png'
    },
    {
      'name': 'Dr. Muhammad Al-Ghazali',
      'price': '50 \$',
      'image': 'assets/doctor.png'
    },
    {
      'name': 'Dr. Muhammad Al-Ghazali',
      'price': '50 \$',
      'image': 'assets/doctor.png'
    },
    {
      'name': 'Dr. Muhammad Al-Ghazali',
      'price': '50 \$',
      'image': 'assets/doctor.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Medical Services'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xff308A99), width: 1),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(category['icon']!),
                          radius: 30,
                          backgroundColor: Colors.grey[200],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['label']!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'The best doctors',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(doctor['image']!),
                        radius: 30,
                      ),
                      title: Text(
                        doctor['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        doctor['price']!,
                        style: TextStyle(color: Colors.green),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          // Booking functionality
                        },
                        child: const Text('Book now'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
