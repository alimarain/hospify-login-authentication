import 'package:flutter/material.dart';

enum PatientStatus {
  mild,
  stable,
  serious,
  critical,
  recovering,
  discharged,
}

enum Ward {
  general,
  icu,
  emergency,
  pediatrics,
  cardiology,
  orthopedics,
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String timing;
  final bool isActive;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.timing,
    required this.isActive,
  });
}

class Note {
  final String type; // e.g., Clinical, Nursing, Progress
  final String content;
  final String author;
  final DateTime time;

  Note({
    required this.type,
    required this.content,
    required this.author,
    required this.time,
  });
}

class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String bloodType;
  final PatientStatus status;
  final Ward ward;
  final String wardLabel; // for display
  final int? bedNumber;
  final DateTime admissionDate;
  final DateTime? lastAppointment; // NEW FIELD
  final String attendingDoctor;
  final List<String> allergies;
  final String diagnosis;
  final int heartRate;
  final String bloodPressure;
  final String temperature;
  final String oxygenLevel;
  final List<Medication> medications;
  final List<Note> notes;
  final String emergencyContact;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodType,
    required this.status,
    required this.ward,
    required this.wardLabel,
    this.bedNumber,
    required this.admissionDate,
    this.lastAppointment, // optional
    required this.attendingDoctor,
    required this.allergies,
    required this.diagnosis,
    required this.heartRate,
    required this.bloodPressure,
    required this.temperature,
    required this.oxygenLevel,
    this.medications = const [],
    this.notes = const [],
    required this.emergencyContact,
  });
}
