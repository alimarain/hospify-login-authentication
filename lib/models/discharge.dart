enum DischargeStatus {
  pending,
  medicalClearance,
  billingReview,
  pharmacyReview,
  readyForDischarge,
  completed,
  cancelled
}

enum DischargeType {
  normal,
  againstMedicalAdvice,
  transfer,
  deceased,
  absconded
}

class Discharge {
  final String id;
  final String patientId;
  final String patientName;
  final String admissionId;
  final DischargeType type;
  final DischargeStatus status;
  final DateTime plannedDischargeDate;
  final DateTime? actualDischargeDate;
  final String dischargingDoctor;
  final String dischargeSummary;
  final List<String> medications;
  final List<String> followUpInstructions;
  final String nextAppointmentDate;
  final bool billingCleared;
  final bool pharmacyCleared;
  final bool nursingCleared;
  final bool patientEducationCompleted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Discharge({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.admissionId,
    required this.type,
    required this.status,
    required this.plannedDischargeDate,
    this.actualDischargeDate,
    required this.dischargingDoctor,
    required this.dischargeSummary,
    this.medications = const [],
    this.followUpInstructions = const [],
    this.nextAppointmentDate = '',
    this.billingCleared = false,
    this.pharmacyCleared = false,
    this.nursingCleared = false,
    this.patientEducationCompleted = false,
    required this.createdAt,
    this.updatedAt,
  });

  Discharge copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? admissionId,
    DischargeType? type,
    DischargeStatus? status,
    DateTime? plannedDischargeDate,
    DateTime? actualDischargeDate,
    String? dischargingDoctor,
    String? dischargeSummary,
    List<String>? medications,
    List<String>? followUpInstructions,
    String? nextAppointmentDate,
    bool? billingCleared,
    bool? pharmacyCleared,
    bool? nursingCleared,
    bool? patientEducationCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Discharge(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      admissionId: admissionId ?? this.admissionId,
      type: type ?? this.type,
      status: status ?? this.status,
      plannedDischargeDate: plannedDischargeDate ?? this.plannedDischargeDate,
      actualDischargeDate: actualDischargeDate ?? this.actualDischargeDate,
      dischargingDoctor: dischargingDoctor ?? this.dischargingDoctor,
      dischargeSummary: dischargeSummary ?? this.dischargeSummary,
      medications: medications ?? this.medications,
      followUpInstructions: followUpInstructions ?? this.followUpInstructions,
      nextAppointmentDate: nextAppointmentDate ?? this.nextAppointmentDate,
      billingCleared: billingCleared ?? this.billingCleared,
      pharmacyCleared: pharmacyCleared ?? this.pharmacyCleared,
      nursingCleared: nursingCleared ?? this.nursingCleared,
      patientEducationCompleted:
          patientEducationCompleted ?? this.patientEducationCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get completionPercentage {
    int completed = 0;
    if (billingCleared) completed++;
    if (pharmacyCleared) completed++;
    if (nursingCleared) completed++;
    if (patientEducationCompleted) completed++;
    return (completed / 4) * 100;
  }
}
