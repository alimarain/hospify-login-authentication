import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/models/patient_model.dart';
import '../providers/patients_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_card.dart';
import '../widgets/ward_card.dart'; // Ensure this imports the NEW WardCard
import '../widgets/patient_card.dart';
import 'patient_details_screen.dart';

class PatientsScreen extends ConsumerWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(patientStatsProvider);
    final selectedWard = ref.watch(selectedWardProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final filteredPatients = ref.watch(filteredPatientsProvider);
    final patientsByWard = ref.watch(patientsByWardProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patients',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search patients...',
                    prefixIcon: Icon(Icons.search, color: AppTheme.textMuted),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                childAspectRatio: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  StatsCard(
                    title: 'Total',
                    value: '${stats.total}',
                    icon: Icons.people,
                    color: AppTheme.primary,
                  ),
                  const StatsCard(
                    title: 'Mild',
                    value:
                        '180', // Using static data or stats.mild if available
                    icon: Icons.health_and_safety,
                    color: AppTheme.statusMild,
                  ),
                  const StatsCard(
                    title: 'Stable',
                    value: '150', // Using static data or stats.stable
                    icon: Icons.monitor_heart,
                    color: AppTheme.statusStable,
                  ),
                  const StatsCard(
                    title: 'Critical',
                    value: '22', // Using static data or stats.critical
                    icon: Icons.warning,
                    color: AppTheme.statusCritical,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Ward Filter
          const Text(
            'Filter by Ward',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // "All Wards" Button (Custom Container since it's not a WardCard)
                GestureDetector(
                  onTap: () {
                    ref.read(selectedWardProvider.notifier).state = null;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12, // Matched height roughly to cards
                    ),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: selectedWard == null
                          ? AppTheme.primary
                          : AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedWard == null
                            ? AppTheme.primary
                            : AppTheme.border,
                      ),
                    ),
                    child: Text(
                      'All Wards',
                      style: TextStyle(
                        color: selectedWard == null
                            ? Colors.white
                            : AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Generated Ward Cards
                ...Ward.values.map((ward) {
                  final patients = patientsByWard[ward] ?? [];
                  final criticalCount = patients
                      .where((p) => p.status == PatientStatus.critical)
                      .length;

                  // UPDATED: Passing the correct parameters to the new WardCard
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    // We wrap WardCard in a container to handle selection border if needed
                    // or just rely on the card's look.
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: selectedWard == ward
                            ? Border.all(color: AppTheme.primary, width: 2)
                            : null,
                      ),
                      child: WardCard(
                        name: _getWardName(ward), // Fix 1: Pass Name
                        count: patients.length, // Fix 2: Pass Count
                        criticalCount: criticalCount, // Fix 3: Pass Critical
                        color: _getWardColor(ward), // Fix 4: Pass Color
                        onTap: () {
                          ref.read(selectedWardProvider.notifier).state = ward;
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Patients Grid
          Text(
            '${filteredPatients.length} Patients',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          if (filteredPatients.isEmpty)
            Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: AppTheme.textMuted,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No patients found',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 800
                        ? 3
                        : constraints.maxWidth > 500
                            ? 2
                            : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.8, // Adjusted for better card fit
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredPatients.length,
                  itemBuilder: (context, index) {
                    final patient = filteredPatients[index];
                    return PatientCard(
                      patient: patient,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PatientDetailsScreen(patientId: patient.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  // Helper to map Ward Enum to Display Name
  String _getWardName(Ward ward) {
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

  // Helper to map Ward Enum to Colors (Matching your Theme)
  Color _getWardColor(Ward ward) {
    switch (ward) {
      case Ward.general:
        return AppColors.primaryAccent; // Blue
      case Ward.icu:
        return AppColors.redAccent; // Red
      case Ward.emergency:
        return AppColors.orangeAccent; // Orange
      case Ward.pediatrics:
        return const Color(0xFFEC4899); // Pink
      case Ward.cardiology:
        return const Color(0xFF8B5CF6); // Purple
      case Ward.orthopedics:
        return AppColors.secondaryAccent; // Teal
    }
  }
}
