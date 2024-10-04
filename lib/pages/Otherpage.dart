import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Otherpage extends StatefulWidget{
  const Otherpage({super.key});
  @override
  State<Otherpage> createState() => _Otherpage();
}

class _Otherpage extends State<Otherpage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("This is otherpage")
            ]
        ),
      ),
    );
  }
}