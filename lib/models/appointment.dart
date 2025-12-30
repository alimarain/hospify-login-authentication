class Appointment {
  String id;
  String patientName;
  String patientAvatar;
  String time;
  String duration;
  String type; // 'in-person' | 'video'
  String status; // 'upcoming' | 'completed' | 'cancelled'
  String reason;

  Appointment({
    required this.id,
    required this.patientName,
    required this.patientAvatar,
    required this.time,
    required this.duration,
    required this.type,
    required this.status,
    required this.reason,
  });
}
