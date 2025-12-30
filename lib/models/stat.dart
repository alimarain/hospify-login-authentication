class HospitalStat {
  final String title;
  final int value;
  final String icon; // later use IconData
  final String color;
  final String bgColor;

  HospitalStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

class DepartmentStat {
  final String name;
  final int patients;
  final int staff;
  final int occupancy;

  DepartmentStat({
    required this.name,
    required this.patients,
    required this.staff,
    required this.occupancy,
  });
}

class StaffData {
  final String id;
  final String name;
  final String role;
  final String department;
  final String status;
  final String avatar;

  StaffData({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.status,
    required this.avatar,
  });
}
