class PatientModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String ward;
  final String status;
  final String diagnosis;
  final String assignedDoctor;
  final DateTime admissionDate;

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.ward,
    required this.status,
    required this.diagnosis,
    required this.assignedDoctor,
    required this.admissionDate,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      ward: json['ward'] ?? '',
      status: json['status'] ?? 'stable',
      diagnosis: json['diagnosis'] ?? '',
      assignedDoctor: json['assigned_doctor'] ?? '',
      admissionDate: DateTime.parse(
          json['admission_date'] ?? DateTime.now().toIso8601String()),
    );
  }
}
