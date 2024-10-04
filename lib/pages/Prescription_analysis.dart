import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/PA/PrescriptionAnalysis.dart';

class Prescription_Analysis extends StatefulWidget {
  Prescription_Analysis({super.key});

  @override
  State<Prescription_Analysis> createState() => _Prescription_AnalysisState();
}

class _Prescription_AnalysisState extends State<Prescription_Analysis> {
  String isNeedEmptyStomach = '';
  int age = 23;

  late Future<PrescriptionAnalysis> futurePrescriptionAnalysis;

  // Fetching data from the JSON file
  Future<PrescriptionAnalysis> fetchPrescriptionAnalysis() async {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/shaeakh/code-share/main/data.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return PrescriptionAnalysis.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load prescription analysis');
    }
  }

  String convertExpression(String expression) {
    // Create a mapping for the values
    Map<String, String> map = {
      'no': '1',
      'yes': '2',
      'x': '0',
    };

    // Split the input expression by '-'
    List<String> parts = expression.split('-');

    // Map each part to its corresponding value and join them
    String result = parts.map((part) => map[part] ?? part).join('');

    return result;
  }

  @override
  void initState() {
    super.initState();

    // Initialize the future data
    futurePrescriptionAnalysis = fetchPrescriptionAnalysis();

    // Show the AlertDialog 2 seconds after the page loads
    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Do you want to set alarm for all these medicines?"),
            actions: [

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Handle 'Yes' action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Set the background color
                ),
                child: Text("Yes",style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Set the background color
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Handle 'No' action
                },
                child: Text("No",style: TextStyle(color: Colors.white),),
              ),
            ],
          );
        },
      );
    });
  }



  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF03506F),
          title: Text(
            "Prescription Analysis",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Sets the icon color to white
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "Medicine"),
              Tab(text: "Health Data"),
              Tab(text: "Tests"),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white, // Tab indicator color
          ),
        ),
        body: FutureBuilder<PrescriptionAnalysis>(
          future: futurePrescriptionAnalysis,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final prescriptionData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'lib/assets/man.png',
                        height: 100,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name : ${prescriptionData.patientName}"),
                              Text("Age : ${prescriptionData.age}")
                            ],
                          )),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // First tab: Medicine List
                        ListView.builder(
                          itemCount: prescriptionData.data.length,
                          itemBuilder: (context, index) {
                            final medicine = prescriptionData.data[index];
                            isNeedEmptyStomach = convertExpression(medicine.takingTime);
                            return Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                        "Medicine ${index < 9 ? '0${index + 1}' : '${index + 1}'}: ${medicine.medicineName}"),
                                    Row(
                                      children: <Widget>[
                                        Text("Taking Time: "),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              color: prescriptionData.data[index].takingTime[0] =='1' ? Color(0xFF18C299) : Color(0xFFCADADA),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              color: prescriptionData.data[index].takingTime[2] =='1' ? Color(0xFF18C299) : Color(0xFFCADADA),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              color: prescriptionData.data[index].takingTime[4] =='1' ? Color(0xFF18C299) : Color(0xFFCADADA),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                        "Empty Stomach Required: ${medicine.isNeedEmptyStomach}"),
                                    Text("Usage: ${medicine.medicineUsage}"),
                                    Text("Side Effect: ${medicine.sideEffect}"),


                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Second tab: Health Data
                        ListView.builder(
                          itemCount: prescriptionData.healthData.length,
                          itemBuilder: (context, index) {
                            final health = prescriptionData.healthData[index];
                            return Card(
                              child: ListTile(
                                title: Text("Health Type: ${health.type}"),
                                subtitle: Text("Value: ${health.value}"),
                              ),
                            );
                          },
                        ),
                        // Third tab: Tests
                        ListView.builder(
                          itemCount: prescriptionData.test.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    "Test: ${prescriptionData.test[index]}"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}