// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/models/patient.dart';
// import '../providers/patients_provider.dart';
// import '../theme/app_theme.dart';
// import '../widgets/stats_card.dart';
// import '../widgets/ward_card.dart'; // Ensure this imports the NEW WardCard
// import '../widgets/patient_card.dart';
// import 'patient_details_screen.dart';

// class PatientsScreen extends ConsumerWidget {
//   const PatientsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final stats = ref.watch(patientStatsProvider);
//     final selectedWard = ref.watch(selectedWardProvider);
//     final searchQuery = ref.watch(searchQueryProvider);
//     final filteredPatients = ref.watch(filteredPatientsProvider);
//     final patientsByWard = ref.watch(patientsByWardProvider);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Patients',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: AppTheme.textPrimary,
//                 ),
//               ),
//               SizedBox(
//                 width: 300,
//                 child: TextField(
//                   onChanged: (value) {
//                     ref.read(searchQueryProvider.notifier).state = value;
//                   },
//                   decoration: const InputDecoration(
//                     hintText: 'Search patients...',
//                     prefixIcon: Icon(Icons.search, color: AppTheme.textMuted),
//                     contentPadding: EdgeInsets.symmetric(vertical: 12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Stats Cards
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
//               return GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: crossAxisCount,
//                 childAspectRatio: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   StatsCard(
//                     title: 'Total',
//                     value: '${stats.total}',
//                     icon: Icons.people,
//                     color: AppTheme.primary,
//                   ),
//                   const StatsCard(
//                     title: 'Mild',
//                     value:
//                         '180', // Using static data or stats.mild if available
//                     icon: Icons.health_and_safety,
//                     color: AppTheme.statusMild,
//                   ),
//                   const StatsCard(
//                     title: 'Stable',
//                     value: '150', // Using static data or stats.stable
//                     icon: Icons.monitor_heart,
//                     color: AppTheme.statusStable,
//                   ),
//                   const StatsCard(
//                     title: 'Critical',
//                     value: '22', // Using static data or stats.critical
//                     icon: Icons.warning,
//                     color: AppTheme.statusCritical,
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 24),

//           // Ward Filter
//           const Text(
//             'Filter by Ward',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: AppTheme.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 12),

//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 // "All Wards" Button (Custom Container since it's not a WardCard)
//                 GestureDetector(
//                   onTap: () {
//                     ref.read(selectedWardProvider.notifier).state = null;
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12, // Matched height roughly to cards
//                     ),
//                     margin: const EdgeInsets.only(right: 12),
//                     decoration: BoxDecoration(
//                       color: selectedWard == null
//                           ? AppTheme.primary
//                           : AppTheme.cardColor,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: selectedWard == null
//                             ? AppTheme.primary
//                             : AppTheme.border,
//                       ),
//                     ),
//                     child: Text(
//                       'All Wards',
//                       style: TextStyle(
//                         color: selectedWard == null
//                             ? Colors.white
//                             : AppTheme.textSecondary,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Generated Ward Cards
//                 ...Ward.values.map((ward) {
//                   final patients = patientsByWard[ward] ?? [];
//                   final criticalCount = patients
//                       .where((p) => p.status == PatientStatus.critical)
//                       .length;

//                   // UPDATED: Passing the correct parameters to the new WardCard
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 12),
//                     // We wrap WardCard in a container to handle selection border if needed
//                     // or just rely on the card's look.
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: selectedWard == ward
//                             ? Border.all(color: AppTheme.primary, width: 2)
//                             : null,
//                       ),
//                       child: WardCard(
//                         name: _getWardName(ward), // Fix 1: Pass Name
//                         count: patients.length, // Fix 2: Pass Count
//                         criticalCount: criticalCount, // Fix 3: Pass Critical
//                         color: _getWardColor(ward), // Fix 4: Pass Color
//                         onTap: () {
//                           ref.read(selectedWardProvider.notifier).state = ward;
//                         },
//                       ),
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),

//           // Patients Grid
//           Text(
//             '${filteredPatients.length} Patients',
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: AppTheme.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 12),

//           if (filteredPatients.isEmpty)
//             Container(
//               padding: const EdgeInsets.all(48),
//               decoration: BoxDecoration(
//                 color: AppTheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppTheme.border),
//               ),
//               child: const Center(
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.search_off,
//                       size: 48,
//                       color: AppTheme.textMuted,
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'No patients found',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppTheme.textMuted,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           else
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final crossAxisCount = constraints.maxWidth > 1200
//                     ? 4
//                     : constraints.maxWidth > 800
//                         ? 3
//                         : constraints.maxWidth > 500
//                             ? 2
//                             : 1;
//                 return GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     childAspectRatio: 1.8, // Adjusted for better card fit
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   itemCount: filteredPatients.length,
//                   itemBuilder: (context, index) {
//                     final patient = filteredPatients[index];
//                     return PatientCard(
//                       patient: patient,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) =>
//                                 PatientDetailsScreen(patientId: patient.id),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }

//   // Helper to map Ward Enum to Display Name
//   String _getWardName(Ward ward) {
//     switch (ward) {
//       case Ward.general:
//         return 'General';
//       case Ward.icu:
//         return 'ICU';
//       case Ward.emergency:
//         return 'Emergency';
//       case Ward.pediatrics:
//         return 'Pediatrics';
//       case Ward.cardiology:
//         return 'Cardiology';
//       case Ward.orthopedics:
//         return 'Orthopedics';
//     }
//   }

//   // Helper to map Ward Enum to Colors (Matching your Theme)
//   Color _getWardColor(Ward ward) {
//     switch (ward) {
//       case Ward.general:
//         return AppColors.primaryAccent; // Blue
//       case Ward.icu:
//         return AppColors.redAccent; // Red
//       case Ward.emergency:
//         return AppColors.orangeAccent; // Orange
//       case Ward.pediatrics:
//         return const Color(0xFFEC4899); // Pink
//       case Ward.cardiology:
//         return const Color(0xFF8B5CF6); // Purple
//       case Ward.orthopedics:
//         return AppColors.secondaryAccent; // Teal
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient.dart';
import '../providers/patients_provider.dart';
import '../widgets/stats_card.dart';
import '../widgets/ward_card.dart';
import '../widgets/patient_card.dart';
import 'patient_details_screen.dart';

class PatientsScreen extends ConsumerWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patients = ref.watch(filteredPatientsProvider);
    final selectedWard = ref.watch(selectedWardProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final wardStats = ref.watch(wardStatsProvider);
    final stats = ref.watch(patientStatsProvider);

    // Calculate current stats based on filter
    int currentTotal = patients.length;
    int currentMild =
        patients.where((p) => p.status == PatientStatus.mild).length;
    int currentStable =
        patients.where((p) => p.status == PatientStatus.stable).length;
    int currentCritical =
        patients.where((p) => p.status == PatientStatus.critical).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Patient Management',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Monitor and manage patients across all wards',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 280,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name, diagnosis, or bed...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () => ref
                                .read(searchQueryProvider.notifier)
                                .state = '',
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  onChanged: (value) =>
                      ref.read(searchQueryProvider.notifier).state = value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  StatsCard(
                      title: 'Total Patients',
                      value: currentTotal,
                      icon: Icons.people),
                  StatsCard(
                      title: 'Mild', value: currentMild, icon: Icons.favorite),
                  StatsCard(
                      title: 'Stable',
                      value: currentStable,
                      icon: Icons.show_chart,
                      outlined: true),
                  StatsCard(
                      title: 'Critical',
                      value: currentCritical,
                      icon: Icons.warning),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          // Ward Selection
          Row(
            children: [
              Icon(Icons.apartment,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              const Text(
                'Select Ward',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              if (selectedWard != null)
                TextButton(
                  onPressed: () =>
                      ref.read(selectedWardProvider.notifier).state = null,
                  child: const Text('View All Wards'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // All Wards Card
                GestureDetector(
                  onTap: () =>
                      ref.read(selectedWardProvider.notifier).state = null,
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selectedWard == null
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                        width: selectedWard == null ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.people,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'All Wards',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(
                          '${ref.read(patientsProvider).length} patients',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                // Ward Cards
                ...Ward.values.map((ward) {
                  final ws = wardStats[ward]!;
                  return Container(
                    width: 170,
                    margin: const EdgeInsets.only(right: 12),
                    child: WardCard(
                      ward: ward,
                      patientCount: ws.patientCount,
                      criticalCount: ws.criticalCount,
                      isSelected: selectedWard == ward,
                      onTap: () =>
                          ref.read(selectedWardProvider.notifier).state = ward,
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Patients Grid
          Text(
            selectedWard == null
                ? 'All Patients'
                : '${_getWardLabel(selectedWard)} Patients',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          patients.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        Icon(Icons.people_outline,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        const Text(
                          'No patients found',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          searchQuery.isNotEmpty
                              ? 'Try adjusting your search'
                              : 'No patients in this ward',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 1100
                        ? 3
                        : constraints.maxWidth > 700
                            ? 2
                            : 1;
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.8,
                        ),
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          final patient = patients[index];
                          return PatientCard(
                            patient: patient,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PatientDetailsScreen(patientId: patient.id),
                              ),
                            ),
                          );
                        });
                  },
                ),
        ],
      ),
    );
  }

  String _getWardLabel(Ward ward) {
    switch (ward) {
      case Ward.general:
        return 'General';
      case Ward.icu:
        return 'ICU';
      case Ward.emergency:
        return 'Emergency';
      case Ward.pediatrics:
        return 'Pediatrics';
      case Ward.cardiology:
        return 'Cardiology';
      case Ward.orthopedics:
        return 'Orthopedics';
    }
  }
}
