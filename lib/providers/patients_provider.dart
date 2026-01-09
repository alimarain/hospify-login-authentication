// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/models/patient.dart';
// import '../data/patients_data.dart';

// // All patients provider
// final patientsProvider = Provider<List<Patient>>((ref) {
//   return patientsData;
// });

// // Patient stats provider
// final patientStatsProvider = Provider<PatientStats>((ref) {
//   final patients = ref.watch(patientsProvider);
//   return PatientStats(
//     total: patients.length,
//     mild: patients.where((p) => p.status == PatientStatus.mild).length,
//     stable: patients.where((p) => p.status == PatientStatus.stable).length,
//     critical: patients.where((p) => p.status == PatientStatus.critical).length,
//   );
// });

// // Selected ward filter
// final selectedWardProvider = StateProvider<Ward?>((ref) => null);

// // Search query
// final searchQueryProvider = StateProvider<String>((ref) => '');

// // Filtered patients
// final filteredPatientsProvider = Provider<List<Patient>>((ref) {
//   final patients = ref.watch(patientsProvider);
//   final selectedWard = ref.watch(selectedWardProvider);
//   final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

//   var filtered = patients;

//   if (selectedWard != null) {
//     filtered = filtered.where((p) => p.ward == selectedWard).toList();
//   }

//   if (searchQuery.isNotEmpty) {
//     filtered = filtered.where((p) {
//       return p.name.toLowerCase().contains(searchQuery) ||
//           p.diagnosis.toLowerCase().contains(searchQuery) ||
//           p.bedNumber.toLowerCase().contains(searchQuery);
//     }).toList();
//   }

//   // Sort: critical first
//   filtered.sort((a, b) {
//     if (a.status == PatientStatus.critical &&
//         b.status != PatientStatus.critical) {
//       return -1;
//     }
//     if (b.status == PatientStatus.critical &&
//         a.status != PatientStatus.critical) {
//       return 1;
//     }
//     return 0;
//   });

//   return filtered;
// });

// // Patients grouped by ward
// final patientsByWardProvider = Provider<Map<Ward, List<Patient>>>((ref) {
//   final patients = ref.watch(patientsProvider);
//   final Map<Ward, List<Patient>> grouped = {};

//   for (final ward in Ward.values) {
//     grouped[ward] = patients.where((p) => p.ward == ward).toList();
//   }

//   return grouped;
// });

// // Single patient provider
// final patientProvider = Provider.family<Patient?, String>((ref, id) {
//   final patients = ref.watch(patientsProvider);
//   try {
//     return patients.firstWhere((p) => p.id == id);
//   } catch (_) {
//     return null;
//   }
// });
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient.dart';
import '../data/patients_data.dart';

// ---------------- Providers ----------------
final patientsProvider = Provider<List<Patient>>((ref) => patientsData);

final selectedWardProvider = StateProvider<Ward?>((ref) => null);

final searchQueryProvider = StateProvider<String>((ref) => '');

// ---------------- Filtered Patients ----------------
final filteredPatientsProvider = Provider<List<Patient>>((ref) {
  final patients = ref.watch(patientsProvider);
  final selectedWard = ref.watch(selectedWardProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  var filtered = patients;

  // Filter by ward
  if (selectedWard != null) {
    filtered = filtered.where((p) => p.ward == selectedWard).toList();
  }

  // Filter by search query
  if (searchQuery.isNotEmpty) {
    filtered = filtered.where((p) {
      final bedStr = p.bedNumber?.toString() ?? '';
      return p.name.toLowerCase().contains(searchQuery) ||
          p.diagnosis.toLowerCase().contains(searchQuery) ||
          bedStr.contains(searchQuery);
    }).toList();
  }

  // Sort by priority: Critical > Serious > Recovering > Stable > Mild > Discharged
  filtered.sort((a, b) {
    const priority = {
      PatientStatus.critical: 0,
      PatientStatus.serious: 1,
      PatientStatus.recovering: 2,
      PatientStatus.stable: 3,
      PatientStatus.mild: 4,
      PatientStatus.discharged: 5,
    };
    return priority[a.status]!.compareTo(priority[b.status]!);
  });

  return filtered;
});

// ---------------- Ward Stats ----------------
final wardStatsProvider = Provider<Map<Ward, WardStats>>((ref) {
  final patients = ref.watch(patientsProvider);
  final Map<Ward, WardStats> stats = {};

  for (var ward in Ward.values) {
    final wardPatients = patients.where((p) => p.ward == ward).toList();
    stats[ward] = WardStats(
      patientCount: wardPatients.length,
      criticalCount:
          wardPatients.where((p) => p.status == PatientStatus.critical).length,
    );
  }

  return stats;
});

// ---------------- Patient Stats (overall) ----------------
final patientStatsProvider = Provider<PatientStats>((ref) {
  final patients = ref.watch(patientsProvider);

  int total = patients.length;
  int mild = patients.where((p) => p.status == PatientStatus.mild).length;
  int stable = patients.where((p) => p.status == PatientStatus.stable).length;
  int serious = patients.where((p) => p.status == PatientStatus.serious).length;
  int critical =
      patients.where((p) => p.status == PatientStatus.critical).length;
  int recovering =
      patients.where((p) => p.status == PatientStatus.recovering).length;
  int discharged =
      patients.where((p) => p.status == PatientStatus.discharged).length;

  return PatientStats(
    total: total,
    mild: mild,
    stable: stable,
    serious: serious,
    critical: critical,
    recovering: recovering,
    discharged: discharged,
  );
});

// ---------------- Helper Classes ----------------
class WardStats {
  final int patientCount;
  final int criticalCount;
  WardStats({required this.patientCount, required this.criticalCount});
}

class PatientStats {
  final int total;
  final int mild;
  final int stable;
  final int serious;
  final int critical;
  final int recovering;
  final int discharged;

  PatientStats({
    required this.total,
    required this.mild,
    required this.stable,
    required this.serious,
    required this.critical,
    required this.recovering,
    required this.discharged,
  });
}
