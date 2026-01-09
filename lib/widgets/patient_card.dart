// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:hospify/models/patient.dart';
// import '../theme/app_theme.dart';
// import 'patient_status_badge.dart';

// class PatientCard extends StatelessWidget {
//   final Patient patient;
//   final VoidCallback onTap;

//   const PatientCard({
//     super.key,
//     required this.patient,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppTheme.surface,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppTheme.border),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundColor: AppTheme.primary.withOpacity(0.1),
//                   child: CachedNetworkImage(
//                     imageUrl: patient.avatar,
//                     placeholder: (context, url) => Icon(
//                       Icons.person,
//                       color: AppTheme.primary,
//                     ),
//                     errorWidget: (context, url, error) => Icon(
//                       Icons.person,
//                       color: AppTheme.primary,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         patient.name,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppTheme.textPrimary,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         patient.diagnosis,
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: AppTheme.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 PatientStatusBadge(status: patient.status),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 _buildInfoItem(Icons.bed, patient.bedNumber),
//                 const SizedBox(width: 16),
//                 _buildInfoItem(Icons.cake, '${patient.age} yrs'),
//                 const SizedBox(width: 16),
//                 _buildInfoItem(
//                   patient.gender == 'Male' ? Icons.male : Icons.female,
//                   patient.gender,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoItem(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: AppTheme.textMuted),
//         const SizedBox(width: 4),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 12,
//             color: AppTheme.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/patient.dart';
import 'patient_status_badge.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;

  const PatientCard({super.key, required this.patient, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      patient.name.split(' ').map((n) => n[0]).take(2).join(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          patient.diagnosis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PatientStatusBadge(status: patient.status),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(
                      Icons.bed, patient.bedNumber?.toString() ?? 'N/A'),
                  const SizedBox(width: 12),
                  _buildInfoChip(
                    Icons.calendar_today,
                    patient.lastAppointment != null
                        ? "${patient.lastAppointment!.day.toString().padLeft(2, '0')}/"
                            "${patient.lastAppointment!.month.toString().padLeft(2, '0')}/"
                            "${patient.lastAppointment!.year}"
                        : 'N/A',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('View'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}
