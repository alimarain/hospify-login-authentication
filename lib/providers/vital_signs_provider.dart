import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vital_signs.dart';

final vitalSignsProvider =
    StateProvider.family<VitalSigns, String>((ref, patientId) {
  return VitalSigns(
    bloodPressure: '120/80',
    heartRate: 72,
    temperature: 98.6,
    respiratoryRate: 16,
    oxygenSaturation: 98,
    weight: 70.5,
    lastUpdated: DateTime.now(),
  );
});
