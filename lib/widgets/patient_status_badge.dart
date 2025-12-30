import 'package:flutter/material.dart';
import 'package:hospify/models/patient_model.dart';
import '../theme/app_theme.dart';

class PatientStatusBadge extends StatelessWidget {
  final PatientStatus status;

  const PatientStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case PatientStatus.mild:
        color = AppTheme.statusMild;
        text = 'Mild';
        break;
      case PatientStatus.stable:
        color = AppTheme.statusStable;
        text = 'Stable';
        break;
      case PatientStatus.critical:
        color = AppTheme.statusCritical;
        text = 'Critical';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
