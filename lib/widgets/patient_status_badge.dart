// import 'package:flutter/material.dart';
// import 'package:hospify/models/patient.dart';
// import '../theme/app_theme.dart';

// class PatientStatusBadge extends StatelessWidget {
//   final PatientStatus status;

//   const PatientStatusBadge({super.key, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     Color color;
//     String text;

//     switch (status) {
//       case PatientStatus.mild:
//         color = AppTheme.statusMild;
//         text = 'Mild';
//         break;
//       case PatientStatus.stable:
//         color = AppTheme.statusStable;
//         text = 'Stable';
//         break;
//       case PatientStatus.critical:
//         color = AppTheme.statusCritical;
//         text = 'Critical';
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../theme/app_theme.dart';

class PatientStatusBadge extends StatelessWidget {
  final PatientStatus status;

  const PatientStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case PatientStatus.stable:
        bgColor = AppTheme.statusStable.withOpacity(0.1);
        textColor = AppTheme.statusStable;
        label = 'Stable';
        break;
      case PatientStatus.critical:
        bgColor = AppTheme.statusCritical.withOpacity(0.1);
        textColor = AppTheme.statusCritical;
        label = 'Critical';
        break;
      case PatientStatus.mild:
        bgColor = AppTheme.statusMild.withOpacity(0.1);
        textColor = AppTheme.statusMild;
        label = 'Mild';
        break;
      case PatientStatus.serious:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PatientStatus.recovering:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PatientStatus.discharged:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
