// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/vital_signs.dart';
// import '../theme/app_theme.dart';

// class VitalSignsCard extends StatelessWidget {
//   final VitalSigns vitals;
//   final VoidCallback onEdit;

//   const VitalSignsCard({
//     super.key,
//     required this.vitals,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppTheme.surface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppTheme.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Vital Signs',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppTheme.textPrimary,
//                 ),
//               ),
//               IconButton(
//                 onPressed: onEdit,
//                 icon: Icon(Icons.edit, color: AppTheme.primary),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           GridView.count(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisCount: 2,
//             childAspectRatio: 2.5,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             children: [
//               _buildVitalItem(
//                 icon: Icons.favorite,
//                 label: 'Blood Pressure',
//                 value: vitals.bloodPressure,
//                 unit: 'mmHg',
//                 color: AppTheme.statusCritical,
//               ),
//               _buildVitalItem(
//                 icon: Icons.monitor_heart,
//                 label: 'Heart Rate',
//                 value: '${vitals.heartRate}',
//                 unit: 'bpm',
//                 color: AppTheme.primary,
//               ),
//               _buildVitalItem(
//                 icon: Icons.thermostat,
//                 label: 'Temperature',
//                 value: '${vitals.temperature}',
//                 unit: '°F',
//                 color: Colors.orange,
//               ),
//               _buildVitalItem(
//                 icon: Icons.air,
//                 label: 'Respiratory Rate',
//                 value: '${vitals.respiratoryRate}',
//                 unit: '/min',
//                 color: AppTheme.statusMild,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'Last updated: ${DateFormat('MMM dd, yyyy HH:mm').format(vitals.lastUpdated)}',
//             style: TextStyle(
//               fontSize: 12,
//               color: AppTheme.textMuted,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVitalItem({
//     required IconData icon,
//     required String label,
//     required String value,
//     required String unit,
//     required Color color,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: color, size: 18),
//         ),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: AppTheme.textMuted,
//               ),
//             ),
//             Text(
//               '$value $unit',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: AppTheme.textPrimary,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
