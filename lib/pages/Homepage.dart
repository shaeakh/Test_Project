import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject/functionality/Notification_Service.dart';
import 'package:poject/pages/Prescription_analysis.dart';
import 'package:poject/pages/temp_pa.dart';

import '../main.dart';
import 'All_Meal_Times.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 60), () {
    //   showNotification(
    //     title: "Emergency Alert",
    //     body: "Your brother just fainted and fell to the floor.",
    //     payload: {
    //       "navigate": "true",
    //     },
    //     actionButtons: [
    //       NotificationActionButton(
    //         key: 'Otherpage',
    //         label: "See Details",
    //         actionType: ActionType.SilentAction,
    //         color: Colors.deepPurple,
    //       )
    //     ],
    //   );
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16), // Optional padding for better appearance
                decoration: BoxDecoration(
                  color: Colors.transparent, // Set the background color
                  borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Text(
                  "Status : Everything is stable till now",
                  style: TextStyle(
                    color: Colors.transparent,    // Set text color to white
                    fontWeight: FontWeight.bold, // Set font to bold
                    fontSize: 20,               // Set font size to 20
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16), // Optional padding for better appearance
                decoration: BoxDecoration(
                  color: Colors.transparent, // Set the background color
                  borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Text(
                  "Status : Everything is stable till now",
                  style: TextStyle(
                    color: Colors.transparent,    // Set text color to white
                    fontWeight: FontWeight.bold, // Set font to bold
                    fontSize: 20,               // Set font size to 20
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16), // Optional padding for better appearance
                decoration: BoxDecoration(
                  color: Color(0xFF18C299), // Set the background color
                  borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Text(
                  "Status : Everything is stable till now",
                  style: TextStyle(
                    color: Colors.white,        // Set text color to white
                    fontWeight: FontWeight.bold, // Set font to bold
                    fontSize: 20,               // Set font size to 20
                  ),
                ),
              ),


              ElevatedButton.icon(
                onPressed: () {
                  MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => All_Meal_Times(),
                  ));
                },
                icon: Icon(
                  Icons.alarm, // Alarm/watch icon
                  color: Colors.white, // Icon color set to white
                ),
                label: Stack(
                  children: [
                    // Black outlined text (bottom layer)
                    Text(
                      "Schedule All Meal Times",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = .5
                          ..color = Colors.black, // Outline color
                      ),
                    ),
                    // White text (top layer)
                    Text(
                      "Schedule All Meal Times",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Fill color
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD166), // Set background color to #FFD166
                ),
              )
              ,


              ElevatedButton.icon(
                onPressed: () {
                  // take a picture and navigate to another page
                  MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => Temp_Pa(),
                  ));
                },
                icon: Icon(
                  Icons.description, // Document icon
                  color: Colors.white, // Icon color set to white
                ),
                label: Stack(
                  children: [
                    // Black outlined text (bottom layer)
                    Text(
                      "Take a picture of Prescription",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.5
                          ..color = Colors.black, // Outline color
                      ),
                    ),
                    // White text (top layer)
                    Text(
                      "Take a picture of Prescription",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Fill color
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1982C4), // Set background color to #1982C4
                ),
              ),


              Container(
                padding: EdgeInsets.all(16), // Optional padding for better appearance
                decoration: BoxDecoration(
                  color: Colors.transparent, // Set the background color
                  borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Text(
                  "Status : Everything is stable till now",
                  style: TextStyle(
                    color: Colors.transparent,    // Set text color to white
                    fontWeight: FontWeight.bold, // Set font to bold
                    fontSize: 20,               // Set font size to 20
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16), // Optional padding for better appearance
                decoration: BoxDecoration(
                  color: Colors.transparent, // Set the background color
                  borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Text(
                  "Status : Everything is stable till now",
                  style: TextStyle(
                    color: Colors.transparent,    // Set text color to white
                    fontWeight: FontWeight.bold, // Set font to bold
                    fontSize: 20,               // Set font size to 20
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16), // Optional padding for better appearance
                decoration: BoxDecoration(
                  color: Colors.transparent, // Set the background color
                  borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Text(
                  "Status : Everything is stable till now",
                  style: TextStyle(
                    color: Colors.transparent,    // Set text color to white
                    fontWeight: FontWeight.bold, // Set font to bold
                    fontSize: 20,               // Set font size to 20
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
