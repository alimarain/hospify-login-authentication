import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/models/patient_model.dart';
import '../data/patients_data.dart';

// All patients provider
final patientsProvider = Provider<List<Patient>>((ref) {
  return patientsData;
});

// Patient stats provider
final patientStatsProvider = Provider<PatientStats>((ref) {
  final patients = ref.watch(patientsProvider);
  return PatientStats(
    total: patients.length,
    mild: patients.where((p) => p.status == PatientStatus.mild).length,
    stable: patients.where((p) => p.status == PatientStatus.stable).length,
    critical: patients.where((p) => p.status == PatientStatus.critical).length,
  );
});

// Selected ward filter
final selectedWardProvider = StateProvider<Ward?>((ref) => null);

// Search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered patients
final filteredPatientsProvider = Provider<List<Patient>>((ref) {
  final patients = ref.watch(patientsProvider);
  final selectedWard = ref.watch(selectedWardProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  var filtered = patients;

  if (selectedWard != null) {
    filtered = filtered.where((p) => p.ward == selectedWard).toList();
  }

  if (searchQuery.isNotEmpty) {
    filtered = filtered.where((p) {
      return p.name.toLowerCase().contains(searchQuery) ||
          p.diagnosis.toLowerCase().contains(searchQuery) ||
          p.bedNumber.toLowerCase().contains(searchQuery);
    }).toList();
  }

  // Sort: critical first
  filtered.sort((a, b) {
    if (a.status == PatientStatus.critical &&
        b.status != PatientStatus.critical) {
      return -1;
    }
    if (b.status == PatientStatus.critical &&
        a.status != PatientStatus.critical) {
      return 1;
    }
    return 0;
  });

  return filtered;
});

// Patients grouped by ward
final patientsByWardProvider = Provider<Map<Ward, List<Patient>>>((ref) {
  final patients = ref.watch(patientsProvider);
  final Map<Ward, List<Patient>> grouped = {};

  for (final ward in Ward.values) {
    grouped[ward] = patients.where((p) => p.ward == ward).toList();
  }

  return grouped;
});

// Single patient provider
final patientProvider = Provider.family<Patient?, String>((ref, id) {
  final patients = ref.watch(patientsProvider);
  try {
    return patients.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
});
