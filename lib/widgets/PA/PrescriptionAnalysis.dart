class PrescriptionAnalysis {
  String patientName;
  String age;
  List<Medicine> data;
  List<HealthData> healthData;
  List<String> test;

  PrescriptionAnalysis({
    required this.patientName,
    required this.age,
    required this.data,
    required this.healthData,
    required this.test,
  });

  // Factory method to create an instance from JSON
  factory PrescriptionAnalysis.fromJson(Map<String, dynamic> json) {
    return PrescriptionAnalysis(
      patientName: json['patientName'],
      age: json['age'],
      data: List<Medicine>.from(json['data'].map((x) => Medicine.fromJson(x))),
      healthData: List<HealthData>.from(json['healhData'].map((x) => HealthData.fromJson(x))),
      test: List<String>.from(json['test']),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'age': age,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'healhData': List<dynamic>.from(healthData.map((x) => x.toJson())),
      'test': List<dynamic>.from(test),
    };
  }
}

class Medicine {
  String medicineName;
  String takingTime;
  String isNeedEmptyStomach;
  String medicineUsage;
  String sideEffect;

  Medicine({
    required this.medicineName,
    required this.takingTime,
    required this.isNeedEmptyStomach,
    required this.medicineUsage,
    required this.sideEffect,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicineName'],
      takingTime: json['takingTime'],
      isNeedEmptyStomach: json['isNeedEmptyStomach'],
      medicineUsage: json['medicineUsage'],
      sideEffect: json['sideEffect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineName': medicineName,
      'takingTime': takingTime,
      'isNeedEmptyStomach': isNeedEmptyStomach,
      'medicineUsage': medicineUsage,
      'sideEffect': sideEffect,
    };
  }
}

class HealthData {
  String type;
  String value;

  HealthData({
    required this.type,
    required this.value,
  });

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
