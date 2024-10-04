//this is for stateless
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject/pages/Prescription_analysis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class Temp_Pa extends StatefulWidget {
  Temp_Pa({super.key});

  @override
  State<Temp_Pa> createState() => _Temp_PaState();
}

class _Temp_PaState extends State<Temp_Pa> {
  File ? selected_image ;

  Future _pickImg_Camera()async{

    final returned_image =  await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selected_image = File(returned_image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: selected_image!=null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(child: Image.file(selected_image!),padding: EdgeInsets.all(20)),
            ElevatedButton(
                onPressed: (){
                  MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => Prescription_Analysis(),
                  ));
                },
                child: Text("Submit")
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    selected_image = null;
                  });
                },
                child: Text("Retake")
            ),

          ],
        )
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Take a picture with camera"),
              onPressed: () {
                // take a picture
                _pickImg_Camera();

                // //naviagate to another page

              },
            ),
            ElevatedButton(
              child: Text("Choose a picture From Gallary"),
              onPressed: () {
                // take a picture
                // _pickImg();

                // //naviagate to another page
                // MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
                //   builder: (_) => Temp_Pa(),
                // ));
              },
            ),
            const Text("Please Insert an image"),
            // selected_image!=null ? Image.file(selected_image!): const Text("Please Insert an image"),
          ],
        ),
      ),
    );
  }
}