import 'package:flutter/material.dart';
import 'Count_down.dart';

class All_Meal_Times extends StatefulWidget {
  const All_Meal_Times({Key? key}) : super(key: key);

  @override
  State<All_Meal_Times> createState() => _All_Meal_TimesState();
}

class _All_Meal_TimesState extends State<All_Meal_Times> {
  TimeOfDay? breakfastTime;
  TimeOfDay? lunchTime;
  TimeOfDay? dinnerTime;

  Future<void> _selectTime(
      BuildContext context, TimeOfDay? initialTime, Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Meal Times")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Breakfast Time: ${breakfastTime?.format(context) ?? "Not Set"}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, breakfastTime, (pickedTime) {
                setState(() {
                  breakfastTime = pickedTime;
                });
              }),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Lunch Time: ${lunchTime?.format(context) ?? "Not Set"}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, lunchTime, (pickedTime) {
                setState(() {
                  lunchTime = pickedTime;
                });
              }),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Dinner Time: ${dinnerTime?.format(context) ?? "Not Set"}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, dinnerTime, (pickedTime) {
                setState(() {
                  dinnerTime = pickedTime;
                });
              }),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF18C299)),
              onPressed: lunchTime != null
                  ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CountDown(lunchTime: lunchTime!),
                  ),
                );
              }
                  : null,
              child: Text("Start Lunch Countdown", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
