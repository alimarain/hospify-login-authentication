enum PatientStatus { mild, stable, critical }

enum Ward { general, icu, emergency, pediatrics, cardiology, orthopedics }

class Patient {
  final String id;
  final String name;
  final String avatar;
  final String lastAppointment;
  final int age;
  final String dateOfBirth;
  final String gender;
  final String diagnosis;
  final PatientStatus status;
  final Ward ward;
  final String bedNumber;

  Patient({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastAppointment,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.diagnosis,
    required this.status,
    required this.ward,
    required this.bedNumber,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      lastAppointment: json['lastAppointment'],
      age: json['age'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      diagnosis: json['diagnosis'],
      status: PatientStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == json['status'].toString().toLowerCase(),
      ),
      ward: Ward.values.firstWhere(
        (e) => e.name.toLowerCase() == json['ward'].toString().toLowerCase(),
      ),
      bedNumber: json['bedNumber'],
    );
  }
}

class PatientStats {
  final int total;
  final int mild;
  final int stable;
  final int critical;

  PatientStats({
    required this.total,
    required this.mild,
    required this.stable,
    required this.critical,
  });
}
