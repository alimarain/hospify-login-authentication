import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/models/patient_model.dart';
import '../providers/patients_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_card.dart';
import '../widgets/ward_card.dart';
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
              Text(
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
                  decoration: InputDecoration(
                    hintText: 'Search patients...',
                    prefixIcon: Icon(Icons.search, color: AppTheme.textMuted),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                  StatsCard(
                    title: 'Mild',
                    value: '${stats.mild}',
                    icon: Icons.health_and_safety,
                    color: AppTheme.statusMild,
                  ),
                  StatsCard(
                    title: 'Stable',
                    value: '${stats.stable}',
                    icon: Icons.monitor_heart,
                    color: AppTheme.statusStable,
                  ),
                  StatsCard(
                    title: 'Critical',
                    value: '${stats.critical}',
                    icon: Icons.warning,
                    color: AppTheme.statusCritical,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Ward Filter
          Text(
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
                // All Wards
                GestureDetector(
                  onTap: () {
                    ref.read(selectedWardProvider.notifier).state = null;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: selectedWard == null
                          ? AppTheme.primary
                          : AppTheme.surface,
                      borderRadius: BorderRadius.circular(8),
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
                            : AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Ward Cards
                ...Ward.values.map((ward) {
                  final patients = patientsByWard[ward] ?? [];
                  final criticalCount = patients
                      .where((p) => p.status == PatientStatus.critical)
                      .length;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: WardCard(
                      ward: ward,
                      patientCount: patients.length,
                      criticalCount: criticalCount,
                      isSelected: selectedWard == ward,
                      onTap: () {
                        ref.read(selectedWardProvider.notifier).state = ward;
                      },
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
            style: TextStyle(
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
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: AppTheme.textMuted,
                    ),
                    const SizedBox(height: 16),
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
                    childAspectRatio: 1.8,
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
}
