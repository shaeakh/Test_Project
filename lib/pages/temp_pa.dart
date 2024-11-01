//this is for stateless
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject/pages/Prescription_analysis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class Temp_Pa extends StatefulWidget {
  Temp_Pa({super.key});

  @override
  State<Temp_Pa> createState() => _Temp_PaState();
}

class _Temp_PaState extends State<Temp_Pa> {
  File ? selected_image ;
  String s="";

  Future _pickImg_Camera()async{

    final returned_image =  await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selected_image = File(returned_image!.path);
    });
  }
  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse("http://192.168.0.100:8000/upload?file");
    final mimeTypeData = lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'file', // এই key 'multer' এর সাথে match করতে হবে
      imageFile.path,
      contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
    );
    imageUploadRequest.files.add(file);
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
      print("Response body: ${response.body}");
      s = response.body;
    } else {
      print("Failed to upload image: ${response.reasonPhrase}");
    }
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
              onPressed: () async {
                await uploadImage(selected_image!); // এই ফাংশনটি await করুন
                MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
                  builder: (_) => Prescription_Analysis(responseData: s), // রেসপন্স পাঠানো
                ));
              },
              child: Text("Submit"),
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