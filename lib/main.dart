import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:poject/pages/Emergency_landingpage.dart';
import 'package:poject/pages/Homepage.dart';
import 'package:poject/pages/Otherpage.dart';

import 'functionality/Notification_Service.dart';
import 'pages/Prescription_analysis.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotification();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homepage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/homepage': (context) => Homepage(),
        '/otherpage': (context) => Otherpage(),
      },
    );
  }
}
