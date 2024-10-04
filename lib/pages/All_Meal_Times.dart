import 'package:flutter/material.dart';

class All_Meal_Times extends StatefulWidget {
  const All_Meal_Times({super.key});

  @override
  State<All_Meal_Times> createState() => _All_Meal_Times();
}

class _All_Meal_Times extends State<All_Meal_Times> {
  // Variables to store the selected times
  TimeOfDay? breakfastTime;
  TimeOfDay? lunchTime;
  TimeOfDay? dinnerTime;

  // Function to pick time
  Future<void> _selectTime(BuildContext context, TimeOfDay? initialTime,
      Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != initialTime) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Meal Times"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Breakfast Time Picker
            ListTile(
              title: Text(
                  'Breakfast Time: ${breakfastTime?.format(context) ?? "Not Set"}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, breakfastTime, (pickedTime) {
                setState(() {
                  breakfastTime = pickedTime;
                });
              }),
            ),
            SizedBox(height: 20),

            // Lunch Time Picker
            ListTile(
              title: Text(
                  'Lunch Time: ${lunchTime?.format(context) ?? "Not Set"}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, lunchTime, (pickedTime) {
                setState(() {
                  lunchTime = pickedTime;
                });
              }),
            ),
            SizedBox(height: 20),

            // Dinner Time Picker
            ListTile(
              title: Text(
                  'Dinner Time: ${dinnerTime?.format(context) ?? "Not Set"}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, dinnerTime, (pickedTime) {
                setState(() {
                  dinnerTime = pickedTime;
                });
              }),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF18C299), // Set the background color
              ),
              onPressed: () {
                // Handle save or set alarm logic
              },
              child: Text(
                "Set Alarms for All Meals",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
