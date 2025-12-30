class Appointment {
  final String id;
  final String patientName;
  final String type; // Consultation, Surgery, Checkup
  final DateTime dateTime;
  final String status; // Pending, Completed, Cancelled

  Appointment({
    required this.id,
    required this.patientName,
    required this.type,
    required this.dateTime,
    required this.status,
  });

  DateTime get date => dateTime;
}
