// import 'package:flutter/material.dart';
// import 'package:hospify/models/patient_model.dart';
// import '../theme/app_theme.dart';

// class WardCard extends StatelessWidget {
//   final Ward ward;
//   final int patientCount;
//   final int criticalCount;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const WardCard({
//     super.key,
//     required this.ward,
//     required this.patientCount,
//     required this.criticalCount,
//     required this.isSelected,
//     required this.onTap,
//   });

//   String get wardName {
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

//   IconData get wardIcon {
//     switch (ward) {
//       case Ward.general:
//         return Icons.local_hospital;
//       case Ward.icu:
//         return Icons.monitor_heart;
//       case Ward.emergency:
//         return Icons.emergency;
//       case Ward.pediatrics:
//         return Icons.child_care;
//       case Ward.cardiology:
//         return Icons.favorite;
//       case Ward.orthopedics:
//         return Icons.accessibility_new;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 140,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isSelected ? AppTheme.primary : AppTheme.surface,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? AppTheme.primary : AppTheme.border,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(
//               wardIcon,
//               color: isSelected ? Colors.white : AppTheme.primary,
//               size: 24,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               wardName,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.white : AppTheme.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '$patientCount patients',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isSelected ? Colors.white70 : AppTheme.textMuted,
//               ),
//             ),
//             if (criticalCount > 0) ...[
//               const SizedBox(height: 4),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Colors.white.withOpacity(0.2)
//                       : AppTheme.statusCritical.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   '$criticalCount critical',
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     color: isSelected ? Colors.white : AppTheme.statusCritical,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';

// class WardCard extends StatelessWidget {
//   final String name;
//   final int count;
//   final int criticalCount;
//   final Color color;
//   final VoidCallback onTap;

//   const WardCard({
//     super.key,
//     required this.name,
//     required this.count,
//     required this.criticalCount,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // The Container itself doesn't need a fixed width
//     // because the parent GridView controls the width.
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.card, // Dark Grey (Zinc-900)
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // --- Header Row: Dot + Name (Left) & Badge (Right) ---
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Left: Color Dot + Ward Name
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 6,
//                         height: 6,
//                         decoration: BoxDecoration(
//                           color: color,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Flexible(
//                         child: Text(
//                           name,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             color: AppColors.textSecondary,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Right: Critical Badge (Only if critical > 0)
//                 if (criticalCount > 0)
//                   Container(
//                     padding: const EdgeInsets.all(5),
//                     decoration: const BoxDecoration(
//                       color: AppColors.statusCritical, // Red Badge
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       criticalCount.toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//               ],
//             ),

//             // --- Bottom: Big Count Number ---
//             Text(
//               count.toString(),
//               style: const TextStyle(
//                 color: AppColors.textPrimary,
//                 fontSize: 28, // Matches the bold big number design
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/patient.dart';

class WardCard extends StatelessWidget {
  final Ward ward;
  final int patientCount;
  final int criticalCount;
  final bool isSelected;
  final VoidCallback onTap;

  const WardCard({
    super.key,
    required this.ward,
    required this.patientCount,
    required this.criticalCount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getWardConfig(ward);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: config.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : config.color.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: config.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(config.icon, color: config.color, size: 20),
                ),
                if (criticalCount > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$criticalCount Critical',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _getWardLabel(ward),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.people_outline, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '$patientCount patients',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
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

  _WardConfig _getWardConfig(Ward ward) {
    switch (ward) {
      case Ward.general:
        return _WardConfig(Icons.apartment, Colors.blue);
      case Ward.icu:
        return _WardConfig(Icons.monitor_heart, Colors.red);
      case Ward.emergency:
        return _WardConfig(Icons.emergency, Colors.orange);
      case Ward.pediatrics:
        return _WardConfig(Icons.child_care, Colors.pink);
      case Ward.cardiology:
        return _WardConfig(Icons.favorite, Colors.purple);
      case Ward.orthopedics:
        return _WardConfig(Icons.accessibility_new, Colors.teal);
    }
  }
}

class _WardConfig {
  final IconData icon;
  final Color color;
  _WardConfig(this.icon, this.color);
}
