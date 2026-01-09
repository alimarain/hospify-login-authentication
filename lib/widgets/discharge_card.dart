import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/discharge.dart';

class DischargeCard extends StatelessWidget {
  final Discharge discharge;
  final VoidCallback onTap;

  const DischargeCard({
    super.key,
    required this.discharge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor),
      ),
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
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Text(
                      discharge.patientName.substring(0, 1),
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          discharge.patientName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Planned: ${DateFormat('MMM dd, HH:mm').format(discharge.plannedDischargeDate)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(theme),
                ],
              ),
              const SizedBox(height: 16),
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Checklist Progress',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        '${discharge.completionPercentage.toInt()}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: discharge.completionPercentage / 100,
                      minHeight: 6,
                      backgroundColor:
                          theme.colorScheme.primary.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Checklist Icons
              Row(
                children: [
                  _buildChecklistIcon(
                    Icons.receipt_long,
                    'Billing',
                    discharge.billingCleared,
                    theme,
                  ),
                  const SizedBox(width: 16),
                  _buildChecklistIcon(
                    Icons.medication,
                    'Pharmacy',
                    discharge.pharmacyCleared,
                    theme,
                  ),
                  const SizedBox(width: 16),
                  _buildChecklistIcon(
                    Icons.medical_services,
                    'Nursing',
                    discharge.nursingCleared,
                    theme,
                  ),
                  const SizedBox(width: 16),
                  _buildChecklistIcon(
                    Icons.school,
                    'Education',
                    discharge.patientEducationCompleted,
                    theme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ThemeData theme) {
    final colors = {
      DischargeStatus.pending: Colors.grey,
      DischargeStatus.medicalClearance: Colors.amber,
      DischargeStatus.billingReview: Colors.orange,
      DischargeStatus.pharmacyReview: Colors.purple,
      DischargeStatus.readyForDischarge: Colors.blue,
      DischargeStatus.completed: Colors.green,
      DischargeStatus.cancelled: Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors[discharge.status]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getStatusLabel(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: colors[discharge.status],
        ),
      ),
    );
  }

  String _getStatusLabel() {
    switch (discharge.status) {
      case DischargeStatus.pending:
        return 'PENDING';
      case DischargeStatus.medicalClearance:
        return 'MED CLEAR';
      case DischargeStatus.billingReview:
        return 'BILLING';
      case DischargeStatus.pharmacyReview:
        return 'PHARMACY';
      case DischargeStatus.readyForDischarge:
        return 'READY';
      case DischargeStatus.completed:
        return 'COMPLETED';
      case DischargeStatus.cancelled:
        return 'CANCELLED';
    }
  }

  Widget _buildChecklistIcon(
      IconData icon, String label, bool completed, ThemeData theme) {
    return Tooltip(
      message: '$label: ${completed ? "Completed" : "Pending"}',
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: completed
              ? Colors.green.withOpacity(0.1)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: completed
              ? Colors.green
              : theme.colorScheme.onSurface.withOpacity(0.4),
        ),
      ),
    );
  }
}
