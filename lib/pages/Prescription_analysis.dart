import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/PA/PrescriptionAnalysis.dart';

class Prescription_Analysis extends StatefulWidget {
  final String responseData;

  Prescription_Analysis({required this.responseData}); // Constructor

  @override
  State<Prescription_Analysis> createState() => _Prescription_AnalysisState();
}

class _Prescription_AnalysisState extends State<Prescription_Analysis> {
  late Future<PrescriptionAnalysis> futurePrescriptionAnalysis;

  Future<PrescriptionAnalysis> fetchPrescriptionAnalysis() async {
    final dynamic jsonResponse = widget.responseData;

    if (jsonResponse is List && jsonResponse.isNotEmpty) {
      return PrescriptionAnalysis.fromJson(jsonResponse[0]);
    } else if (jsonResponse is Map<String, dynamic>) {
      return PrescriptionAnalysis.fromJson(jsonResponse);
    } else {
      throw Exception("Invalid JSON format. Expected a list or a map.");
    }
  }

  @override
  void initState() {
    super.initState();
    futurePrescriptionAnalysis = fetchPrescriptionAnalysis();

    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Do you want to set an alarm for all these medicines?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                child: Text("Yes", style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF03506F),
          title: Text("Prescription Analysis", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          bottom: TabBar(
            tabs: [
              Tab(text: "Medicine"),
              Tab(text: "Health Data"),
              Tab(text: "Tests"),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
                      Image.asset('lib/assets/man.png', height: 100),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : ${prescriptionData.patientName}"),
                            Text("Age : ${prescriptionData.age.toString()}"), // Ensure age is converted to string
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: prescriptionData.data.length,
                          itemBuilder: (context, index) {
                            final medicine = prescriptionData.data[index];
                            String isNeedEmptyStomach = convertExpression(medicine.takingTime);
                            return Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Medicine ${index + 1}: ${medicine.medicineName}"),
                                    Row(
                                      children: <Widget>[
                                        Text("Taking Time: "),
                                        ...List.generate(3, (i) {
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration: BoxDecoration(
                                                color: medicine.takingTime[i * 2] == '1'
                                                    ? Color(0xFF18C299)
                                                    : Color(0xFFCADADA),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    Text("Empty Stomach Required: $isNeedEmptyStomach"),
                                    Text("Usage: ${medicine.medicineUsage}"),
                                    Text("Side Effect: ${medicine.sideEffect}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
                        ListView.builder(
                          itemCount: prescriptionData.test.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text("Test: ${prescriptionData.test[index]}"),
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

  String convertExpression(String expression) {
    Map<String, String> map = {
      'no': '1',
      'yes': '2',
      'x': '0',
    };
    List<String> parts = expression.split('-');
    String result = parts.map((part) => map[part] ?? part).join('');
    return result;
  }
}
