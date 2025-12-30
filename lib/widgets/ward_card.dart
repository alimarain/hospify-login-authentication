import 'package:flutter/material.dart';
import 'package:hospify/models/patient_model.dart';
import '../theme/app_theme.dart';

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

  String get wardName {
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

  IconData get wardIcon {
    switch (ward) {
      case Ward.general:
        return Icons.local_hospital;
      case Ward.icu:
        return Icons.monitor_heart;
      case Ward.emergency:
        return Icons.emergency;
      case Ward.pediatrics:
        return Icons.child_care;
      case Ward.cardiology:
        return Icons.favorite;
      case Ward.orthopedics:
        return Icons.accessibility_new;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              wardIcon,
              color: isSelected ? Colors.white : AppTheme.primary,
              size: 24,
            ),
            const SizedBox(height: 12),
            Text(
              wardName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$patientCount patients',
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white70 : AppTheme.textMuted,
              ),
            ),
            if (criticalCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : AppTheme.statusCritical.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$criticalCount critical',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppTheme.statusCritical,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
