enum AdmissionStatus { pending, inProgress, completed, cancelled }

enum AdmissionType { emergency, scheduled, transfer, referral }

class Admission {
  final String id;
  final String patientId;
  final String patientName;
  final AdmissionType type;
  final AdmissionStatus status;
  final DateTime admissionDate;
  final String ward;
  final String room;
  final String bed;
  final String admittingDoctor;
  final String diagnosis;
  final String notes;
  final List<String> requiredTests;
  final bool insuranceVerified;
  final bool consentSigned;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Admission({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.type,
    required this.status,
    required this.admissionDate,
    required this.ward,
    required this.room,
    required this.bed,
    required this.admittingDoctor,
    required this.diagnosis,
    this.notes = '',
    this.requiredTests = const [],
    this.insuranceVerified = false,
    this.consentSigned = false,
    required this.createdAt,
    this.updatedAt,
  });

  Admission copyWith({
    String? id,
    String? patientId,
    String? patientName,
    AdmissionType? type,
    AdmissionStatus? status,
    DateTime? admissionDate,
    String? ward,
    String? room,
    String? bed,
    String? admittingDoctor,
    String? diagnosis,
    String? notes,
    List<String>? requiredTests,
    bool? insuranceVerified,
    bool? consentSigned,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Admission(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      type: type ?? this.type,
      status: status ?? this.status,
      admissionDate: admissionDate ?? this.admissionDate,
      ward: ward ?? this.ward,
      room: room ?? this.room,
      bed: bed ?? this.bed,
      admittingDoctor: admittingDoctor ?? this.admittingDoctor,
      diagnosis: diagnosis ?? this.diagnosis,
      notes: notes ?? this.notes,
      requiredTests: requiredTests ?? this.requiredTests,
      insuranceVerified: insuranceVerified ?? this.insuranceVerified,
      consentSigned: consentSigned ?? this.consentSigned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
