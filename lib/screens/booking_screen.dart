import 'package:flutter/material.dart';

class DoctorBookingScreen extends StatefulWidget {
  @override
  _DoctorBookingScreenState createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  String selectedMonthYear = '';
  String? selectedDay;
  String? selectedTime;

  List<String> days = ['12', '13', '14', '15', '16', '17'];
  List<String> times = ['1:30 pm', '2:00 pm', '2:30 pm', '3:00 pm'];

  @override
  void initState() {
    super.initState();
    selectedMonthYear = _generateMonthYearList().first;
  }

  List<String> _generateMonthYearList() {
    int currentYear = DateTime.now().year;
    List<String> monthYearList = [];
    for (int year = currentYear; year <= currentYear + 10; year++) {
      for (int month = 1; month <= 12; month++) {
        String monthName = _getMonthName(month);
        monthYearList.add('$monthName $year');
      }
    }
    return monthYearList;
  }

  // Function to get month name
  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(120),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/doctors.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dr. Muhammad Al-Ghazali',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '50 \$',
                      style: TextStyle(fontSize: 16, color: Colors.teal),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Schedule',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: selectedMonthYear,
                          items: _generateMonthYearList()
                              .map((value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedMonthYear = newValue!;
                            });
                          },
                          underline: Container(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: days
                          .map((day) => _buildSelectableBox(
                        day,
                        selected: selectedDay == day,
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                        },
                      ))
                          .toList()
                        ..add(
                          _buildAddButton(onAdd: () => _showAddDialog(context, true)),
                        ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Time',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6.0, // Horizontal spacing between items
                      runSpacing: 8.0, // Vertical spacing between lines
                      children: times
                          .map((time) => _buildSelectableBox(
                        time,
                        selected: selectedTime == time,
                        onTap: () {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                      ))
                          .toList()
                        ..add(
                          _buildAddButton(onAdd: () => _showAddDialog(context, false)),
                        ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedDay == null || selectedTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a day and time.'),
                              ),
                            );
                            return;
                          }
                          // Booking logic here
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 130.0),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Confirm Book',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableBox(String text,
      {bool selected = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton({required VoidCallback onAdd}) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }

  void _showAddDialog(BuildContext context, bool isDay) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isDay ? 'Add Day' : 'Add Time'),
          content: TextField(
            controller: controller,
            keyboardType: isDay ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: isDay ? 'Enter day (1-31)' : 'Enter time (e.g., 4:00 pm)',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String input = controller.text;
                if (input.isEmpty) {
                  return;
                }

                if (isDay) {
                  int? day = int.tryParse(input);
                  if (day == null || day < 1 || day > 31) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid day (1-31).')),
                    );
                    return;
                  }
                  setState(() {
                    days.add(input);
                  });
                } else {
                  setState(() {
                    times.add(input);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
