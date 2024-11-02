import 'package:flutter/material.dart';

class Prescription_Analysis extends StatefulWidget {
  final String age;
  final String patientName;
  final List<dynamic> patientData;
  final List<dynamic> healthData;
  final List<dynamic> test;

  Prescription_Analysis({
    required this.age,
    required this.patientName,
    required this.patientData,
    required this.healthData,
    required this.test,
  });

  @override
  State<Prescription_Analysis> createState() => _Prescription_AnalysisState();
}


class _Prescription_AnalysisState extends State<Prescription_Analysis>{
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
        body: Column(
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
                      Text("Name : ${widget.patientName}"),
                      Text("Age : ${widget.age.toString()}"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: widget.patientData.length,
                    itemBuilder: (context, index) {
                      final medicine = widget.patientData[index];
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Medicine ${index + 1}: ${medicine['medicineName']}"),
                              Text("Taking Time: ${medicine['takingTime']}"),
                              Text("Empty Stomach Required: ${medicine['isNeedEmptyStomach']}"),
                              Text("Usage: ${medicine['medicineUsage']}"),
                              Text("Side Effect: ${medicine['sideEffect']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: widget.healthData.length,
                    itemBuilder: (context, index) {
                      final health = widget.healthData[index];
                      return Card(
                        child: ListTile(
                          title: Text("Health Type: ${health['type']}"),
                          subtitle: Text("Value: ${health['value']}"),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: widget.test.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("Test: ${widget.test[index]}"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}