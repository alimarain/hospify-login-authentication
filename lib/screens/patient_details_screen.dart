// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../providers/patients_provider.dart';
// import '../providers/vital_signs_provider.dart';
// import '../theme/app_theme.dart';
// import '../widgets/patient_status_badge.dart';
// import '../widgets/vital_signs_card.dart';

// class PatientDetailsScreen extends ConsumerWidget {
//   final String patientId;

//   const PatientDetailsScreen({super.key, required this.patientId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final patient = ref.watch(patientProvider(patientId));
//     final vitals = ref.watch(vitalSignsProvider(patientId));

//     if (patient == null) {
//       return Scaffold(
//         appBar: AppBar(),
//         body: const Center(child: Text('Patient not found')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(patient.name),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.edit),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.more_vert),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Patient Header Card
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: AppTheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppTheme.border),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 48,
//                     backgroundColor: AppTheme.primary.withOpacity(0.1),
//                     child: CachedNetworkImage(
//                       imageUrl: patient.avatar,
//                       placeholder: (context, url) => Icon(
//                         Icons.person,
//                         size: 48,
//                         color: AppTheme.primary,
//                       ),
//                       errorWidget: (context, url, error) => Icon(
//                         Icons.person,
//                         size: 48,
//                         color: AppTheme.primary,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 24),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               patient.name,
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppTheme.textPrimary,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             PatientStatusBadge(status: patient.status),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           patient.diagnosis,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: AppTheme.textSecondary,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Wrap(
//                           spacing: 24,
//                           runSpacing: 8,
//                           children: [
//                             _buildInfoChip(Icons.bed, patient.bedNumber),
//                             _buildInfoChip(Icons.cake, '${patient.age} years'),
//                             _buildInfoChip(
//                               patient.gender == 'Male'
//                                   ? Icons.male
//                                   : Icons.female,
//                               patient.gender,
//                             ),
//                             _buildInfoChip(
//                                 Icons.calendar_today, patient.dateOfBirth),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Vital Signs
//             VitalSignsCard(
//               vitals: vitals,
//               onEdit: () {
//                 // Show edit dialog
//               },
//             ),
//             const SizedBox(height: 24),

//             // Medications Section
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: AppTheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppTheme.border),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Current Medications',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppTheme.textPrimary,
//                         ),
//                       ),
//                       TextButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(Icons.add),
//                         label: const Text('Add'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildMedicationItem(
//                     'Metformin',
//                     '500mg',
//                     'Twice daily',
//                     'Active',
//                   ),
//                   _buildMedicationItem(
//                     'Lisinopril',
//                     '10mg',
//                     'Once daily',
//                     'Active',
//                   ),
//                   _buildMedicationItem(
//                     'Aspirin',
//                     '81mg',
//                     'Once daily',
//                     'Active',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 16, color: AppTheme.textMuted),
//         const SizedBox(width: 4),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 14,
//             color: AppTheme.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMedicationItem(
//     String name,
//     String dosage,
//     String frequency,
//     String status,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: AppTheme.background,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppTheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(Icons.medication, color: AppTheme.primary, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: AppTheme.textPrimary,
//                   ),
//                 ),
//                 Text(
//                   '$dosage • $frequency',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: AppTheme.textSecondary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: AppTheme.statusMild.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               status,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: AppTheme.statusMild,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //-------------------06-01-2026--------------------
// import 'package:flutter/material.dart';
// import '../models/patient.dart';
// import '../models/vital_signs.dart';
// import '../widgets/patient_status_badge.dart';
// import '../theme/app_theme.dart';

// class PatientDetailsScreen extends StatefulWidget {
//   final Patient patient;

//   const PatientDetailsScreen({super.key, required this.patient});

//   @override
//   State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
// }

// class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
//   late VitalSigns vitals;
//   String notes = '';

//   @override
//   void initState() {
//     super.initState();
//     vitals = VitalSigns();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F9F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFD4EDDA),
//         foregroundColor: const Color(0xFF2D5A3D),
//         title: const Text('Patient Details'),
//         actions: [
//           IconButton(icon: const Icon(Icons.print), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.share), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Patient Header
//             Container(
//               color: const Color(0xFFD4EDDA),
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundColor: Colors.white,
//                         child: Text(
//                           widget.patient.name
//                               .split(' ')
//                               .map((n) => n[0])
//                               .take(2)
//                               .join(),
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.patient.name,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF2D5A3D),
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             PatientStatusBadge(status: widget.patient.status),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Info Row
//                   Wrap(
//                     spacing: 24,
//                     runSpacing: 8,
//                     children: [
//                       _buildInfoItem(
//                           'MR NO', '#${widget.patient.id.padLeft(4, '0')}'),
//                       _buildInfoItem('Age', '${widget.patient.age}'),
//                       _buildInfoItem('Sex', widget.patient.gender),
//                       _buildInfoItem('Blood', 'O+',
//                           icon: Icons.water_drop, iconColor: Colors.red),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             // Content
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // Vital Signs Card
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.monitor_heart,
//                                   color: Color(0xFF2D5A3D)),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 'Vital Signs',
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                               const Spacer(),
//                               TextButton.icon(
//                                 icon: const Icon(Icons.edit, size: 16),
//                                 label: const Text('Edit'),
//                                 onPressed: () {},
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           GridView.count(
//                             crossAxisCount: 2,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             childAspectRatio: 3,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                             children: [
//                               _buildVitalItem('Blood Pressure',
//                                   vitals.bloodPressure, 'mmHg', Icons.favorite),
//                               _buildVitalItem('Heart Rate', vitals.heartRate,
//                                   'bpm', Icons.timeline),
//                               _buildVitalItem('Temperature', vitals.temperature,
//                                   '°F', Icons.thermostat),
//                               _buildVitalItem('Respiratory Rate',
//                                   vitals.respiratoryRate, '/min', Icons.air),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Diagnosis Card
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.medical_information,
//                                   color: Color(0xFF2D5A3D)),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 "Today's Diagnosis",
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                               const Spacer(),
//                               TextButton.icon(
//                                 icon: const Icon(Icons.add, size: 16),
//                                 label: const Text('Add'),
//                                 onPressed: () {},
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.blue.shade200),
//                             ),
//                             child: Text(
//                               widget.patient.diagnosis,
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Notes Card
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.notes, color: Color(0xFF2D5A3D)),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 'Clinical Notes',
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           TextField(
//                             maxLines: 4,
//                             decoration: InputDecoration(
//                               hintText: 'Add clinical notes...',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onChanged: (value) => notes = value,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Saved successfully')),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           ),
//           child: const Text('Save Changes'),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoItem(String label, String value,
//       {IconData? icon, Color? iconColor}) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (icon != null) ...[
//           Icon(icon, size: 14, color: iconColor ?? const Color(0xFF2D5A3D)),
//           const SizedBox(width: 4),
//         ],
//         Text(
//           '$label: ',
//           style: TextStyle(color: const Color(0xFF2D5A3D).withOpacity(0.7)),
//         ),
//         Text(
//           value,
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }

//   Widget _buildVitalItem(
//       String label, String value, String unit, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: AppTheme.statusStable),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(label,
//                     style:
//                         TextStyle(fontSize: 11, color: Colors.grey.shade600)),
//                 Text(
//                   '$value $unit',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//----------------------06-01-2026------------------------6:50-----//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/data/patients_data.dart';
import 'package:intl/intl.dart';
import '../models/patient.dart';
import '../providers/patients_provider.dart';

class PatientDetailsScreen extends ConsumerStatefulWidget {
  final String patientId;

  const PatientDetailsScreen({super.key, required this.patientId});

  @override
  ConsumerState<PatientDetailsScreen> createState() =>
      _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends ConsumerState<PatientDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patients = ref.watch(patientsProvider);
    final patient = patients.firstWhere(
      (p) => p.id == widget.patientId,
      orElse: () => patients.first,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          patient.name,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined, color: Color(0xFF64748B)),
            onPressed: () => _showPrintDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF64748B)),
            onPressed: () => _showShareDialog(context),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF64748B)),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showEditDialog(context, patient);
                  break;
                case 'export':
                  _showExportDialog(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit Patient')),
              const PopupMenuItem(
                  value: 'export', child: Text('Export to PDF')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPatientHeader(patient),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(patient),
                _buildVitalsTab(patient),
                _buildMedicationsTab(patient),
                _buildNotesTab(patient),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientHeader(Patient patient) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getStatusColor(patient.status),
                  _getStatusColor(patient.status).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                patient.name.split(' ').map((n) => n[0]).take(2).join(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      patient.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildStatusBadge(patient.status),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(Icons.cake_outlined, '${patient.age} years'),
                    const SizedBox(width: 16),
                    _buildInfoChip(Icons.person_outline, patient.gender),
                    const SizedBox(width: 16),
                    _buildInfoChip(Icons.bloodtype_outlined, patient.bloodType),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.bed_outlined,
                      'Bed ${patient.bedNumber ?? 'N/A'}', // Use bedNumber from Patient
                    ),
                    const SizedBox(width: 16),
                    _buildInfoChip(
                      Icons.local_hospital_outlined,
                      patient.wardLabel, // Use wardLabel from Patient
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Admitted',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                DateFormat('MMM d, yyyy').format(patient.admissionDate),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.medical_services_outlined,
                        size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 8),
                    Text(
                      patient.attendingDoctor,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(PatientStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getStatusColor(status).withOpacity(0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _getStatusColor(status),
        ),
      ),
    );
  }

  Color _getStatusColor(PatientStatus status) {
    switch (status) {
      case PatientStatus.critical:
        return const Color(0xFFEF4444);
      case PatientStatus.serious:
        return const Color(0xFFF59E0B);
      case PatientStatus.stable:
        return const Color(0xFF10B981);
      case PatientStatus.recovering:
        return const Color(0xFF0EA5E9);
      case PatientStatus.discharged:
        return const Color(0xFF6B7280);
      case PatientStatus.mild: // <-- added this
        return const Color(0xFF3B82F6); // You can pick any color you want
    }
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF0EA5E9),
        unselectedLabelColor: const Color(0xFF64748B),
        indicatorColor: const Color(0xFF0EA5E9),
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Vitals'),
          Tab(text: 'Medications'),
          Tab(text: 'Notes'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Patient patient) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionCard(
            'Diagnosis',
            Icons.medical_information_outlined,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDiagnosisItem('Primary', patient.diagnosis, true),
                const SizedBox(height: 12),
                _buildDiagnosisItem('Secondary', 'Hypertension', false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            'Allergies',
            Icons.warning_amber_outlined,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: patient.allergies
                  .map((allergy) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFCA5A5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning,
                                size: 14, color: Color(0xFFEF4444)),
                            const SizedBox(width: 6),
                            Text(
                              allergy,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFFEF4444),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            'Emergency Contact',
            Icons.phone_outlined,
            Column(
              children: [
                _buildContactRow('Name', patient.emergencyContact),
                _buildContactRow('Relationship', 'Spouse'),
                _buildContactRow('Phone', '+1 (555) 123-4567'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            'Insurance',
            Icons.health_and_safety_outlined,
            Column(
              children: [
                _buildContactRow('Provider', 'Blue Cross Blue Shield'),
                _buildContactRow('Policy No.', 'BCB-2024-123456'),
                _buildContactRow('Group No.', 'GRP-7890'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF0EA5E9), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildDiagnosisItem(String type, String diagnosis, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPrimary ? const Color(0xFF93C5FD) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:
                  isPrimary ? const Color(0xFF0EA5E9) : const Color(0xFF64748B),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              diagnosis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsTab(Patient patient) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _buildVitalCard('Heart Rate', '${patient.heartRate}',
                      'bpm', Icons.favorite, const Color(0xFFEF4444))),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildVitalCard(
                      'Blood Pressure',
                      patient.bloodPressure,
                      'mmHg',
                      Icons.speed,
                      const Color(0xFF0EA5E9))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _buildVitalCard('Temperature', patient.temperature,
                      '°F', Icons.thermostat, const Color(0xFFF59E0B))),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildVitalCard('Oxygen Level', patient.oxygenLevel,
                      '%', Icons.air, const Color(0xFF10B981))),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionCard(
            'Vital Signs History',
            Icons.show_chart,
            SizedBox(
              height: 200,
              child: CustomPaint(
                size: const Size(double.infinity, 200),
                painter: VitalsChartPainter(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            'Recent Readings',
            Icons.history,
            Column(
              children: [
                _buildReadingRow(
                    'Today 8:00 AM', '72 bpm', '120/80', '98.6°F', '98%'),
                _buildReadingRow(
                    'Today 6:00 AM', '75 bpm', '118/78', '98.4°F', '97%'),
                _buildReadingRow(
                    'Yesterday 10:00 PM', '70 bpm', '122/82', '98.8°F', '98%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(
      String title, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              const Icon(Icons.trending_up, color: Color(0xFF10B981), size: 16),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReadingRow(
      String time, String hr, String bp, String temp, String o2) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(time,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF64748B)))),
          Expanded(
              child: Text(hr,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(
              child: Text(bp,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(
              child: Text(temp,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(
              child: Text(o2,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildMedicationsTab(Patient patient) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildMedicationCard(
              'Lisinopril', '10mg', 'Once daily', 'Morning', true),
          const SizedBox(height: 12),
          _buildMedicationCard(
              'Metformin', '500mg', 'Twice daily', 'Morning & Evening', true),
          const SizedBox(height: 12),
          _buildMedicationCard(
              'Aspirin', '81mg', 'Once daily', 'Evening', false),
          const SizedBox(height: 12),
          _buildMedicationCard(
              'Atorvastatin', '20mg', 'Once daily', 'Bedtime', true),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddMedicationDialog(context),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Add Medication',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5E9),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(String name, String dosage, String frequency,
      String timing, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                isActive ? const Color(0xFF10B981) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFFD1FAE5) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.medication,
              color:
                  isActive ? const Color(0xFF10B981) : const Color(0xFF64748B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        dosage,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF0EA5E9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$frequency • $timing',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isActive ? 'Active' : 'Paused',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesTab(Patient patient) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Note',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter clinical notes...',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF0EA5E9)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_notesController.text.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Note saved successfully'),
                              backgroundColor: Color(0xFF10B981),
                            ),
                          );
                          _notesController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5E9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Save Note',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildNoteCard(
                    'Clinical Note',
                    'Patient responding well to treatment. Vitals stable. Continue current medication regimen.',
                    'Dr. Sarah Johnson',
                    'Today 10:30 AM'),
                const SizedBox(height: 12),
                _buildNoteCard(
                    'Nursing Note',
                    'Administered morning medications. Patient reports no pain or discomfort.',
                    'Nurse Emily Davis',
                    'Today 8:00 AM'),
                const SizedBox(height: 12),
                _buildNoteCard(
                    'Progress Note',
                    'Patient showed significant improvement overnight. Recommend continuing observation for 24 hours.',
                    'Dr. Michael Chen',
                    'Yesterday 6:00 PM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(
      String type, String content, String author, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0EA5E9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1E293B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.person_outline,
                  size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                author,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPrintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Print Patient Record'),
        content: const Text('Send patient record to printer?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sending to printer...')),
              );
            },
            child: const Text('Print'),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Patient Record'),
        content: const Text('Choose how to share this record'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Share')),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Patient'),
        content: const Text('Edit patient information'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Save')),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export to PDF'),
        content: const Text('Export patient record as PDF?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting PDF...')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showAddMedicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Medication'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Add new medication form here')],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Add')),
        ],
      ),
    );
  }
}

class VitalsChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0EA5E9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFF0EA5E9).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final points = [
      Offset(0, size.height * 0.6),
      Offset(size.width * 0.15, size.height * 0.4),
      Offset(size.width * 0.3, size.height * 0.5),
      Offset(size.width * 0.45, size.height * 0.3),
      Offset(size.width * 0.6, size.height * 0.45),
      Offset(size.width * 0.75, size.height * 0.35),
      Offset(size.width * 0.9, size.height * 0.4),
      Offset(size.width, size.height * 0.3),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, size.height);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
      fillPath.lineTo(points[i].dx, points[i].dy);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = const Color(0xFF0EA5E9)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
