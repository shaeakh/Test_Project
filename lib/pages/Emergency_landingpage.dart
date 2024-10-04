//this is for stateless

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poject/pages/Homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Emergency_landingpage extends StatefulWidget {
  Emergency_landingpage({super.key});

  @override
  State<Emergency_landingpage> createState() => _Emergency_landingpageState();
}

class _Emergency_landingpageState extends State<Emergency_landingpage> {
  String Img_Link =
      'https://raw.githubusercontent.com/shaeakh/code-share/refs/heads/main/WhatsApp%20Image%202024-10-04%20at%206.53.13%20PM.jpeg';

  Uri Dial_number = Uri(scheme: 'tel', path: '321');

  callNumber() async {
    await launchUrl(Dial_number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Color(0xFFF44336),
                padding: const EdgeInsets.all(10),
                child: Row(
                  //main axis
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          MyApp.navigatorKey.currentState
                              ?.push(MaterialPageRoute(
                            builder: (_) => Homepage(),
                          ));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 30,
                        )),
                    Padding(
                        child: Icon(Icons.error_outline,
                            color: Colors.white, size: 50),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                    Padding(
                        child: Text(
                          "Emergency Alert",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                  ],
                )),
            Padding(
                child: Image.network(
                  Img_Link,
                  height: 300,
                ),
                padding: EdgeInsets.all(16)),
            Padding(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/ambulance logo.png',
                        height: 50,
                      ),
                      Text(
                        "Ambulance",
                        style: TextStyle(fontSize: 25),
                      ),
                      GestureDetector(
                        child: Image.asset(
                          'lib/assets/call logo.png',
                          height: 50,
                        ),
                        onTap: () {
                          callNumber();
                        },
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(16)),
            Padding(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/doctor logo.png',
                        height: 50,
                      ),
                      Text(
                        "  Doctor        ",
                        style: TextStyle(fontSize: 25),
                      ),
                      GestureDetector(
                        child: Image.asset(
                          'lib/assets/call logo.png',
                          height: 50,
                        ),
                        onTap: () {
                          Dial_number = Uri(scheme: 'tel', path: '123');
                          callNumber();
                        },
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(16))
          ],
        ),
      ),
    );
  }
}
