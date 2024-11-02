import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poject/pages/Prescription_analysis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class Temp_Pa extends StatefulWidget {
  Temp_Pa({super.key});

  @override
  State<Temp_Pa> createState() => _Temp_Pa();
}

class _Temp_Pa extends State<Temp_Pa> {
  File? selected_image;
  String s = "";

  Future _pickImg_Camera() async {
    final returned_image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selected_image = File(returned_image!.path);
    });
  }

  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse("http://54.85.132.230:5000/analysis-prescription");

    final mimeTypeData = lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
    );
    imageUploadRequest.files.add(file);
    final streamedResponse = await imageUploadRequest.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
      print("Response body: ${response.body}");
      s = response.body; // Store response for navigation

      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (_) => Prescription_Analysis(responseData: s),
      ));
    } else {
      print("Failed to upload image: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: selected_image != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.file(selected_image!),
            ),
            ElevatedButton(
              onPressed: () async {
                await uploadImage(selected_image!);
              },
              child: Text("Submit"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selected_image = null;
                });
              },
              child: Text("Retake"),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Take a picture with camera"),
              onPressed: _pickImg_Camera,
            ),
            ElevatedButton(
              child: Text("Choose a picture From Gallery"),
              onPressed: () {},
            ),
            const Text("Please Insert an image"),
          ],
        ),
      ),
    );
  }
}
