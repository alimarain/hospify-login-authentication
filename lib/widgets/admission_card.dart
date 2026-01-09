import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/admission.dart';

class AdmissionCard extends StatelessWidget {
  final Admission admission;
  final Function(AdmissionStatus) onStatusChange;
  final VoidCallback onTap;

  const AdmissionCard({
    super.key,
    required this.admission,
    required this.onStatusChange,
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
                    backgroundColor: _getTypeColor().withOpacity(0.1),
                    child: Icon(
                      _getTypeIcon(),
                      color: _getTypeColor(),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          admission.patientName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ID: ${admission.patientId}',
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
              Row(
                children: [
                  _buildInfoChip(Icons.local_hospital, admission.ward, theme),
                  const SizedBox(width: 12),
                  _buildInfoChip(Icons.room, 'Room ${admission.room}', theme),
                  const SizedBox(width: 12),
                  _buildInfoChip(
                    Icons.access_time,
                    DateFormat('HH:mm').format(admission.admissionDate),
                    theme,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    admission.admittingDoctor,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    admission.diagnosis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
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
      AdmissionStatus.pending: Colors.amber,
      AdmissionStatus.inProgress: Colors.blue,
      AdmissionStatus.completed: Colors.green,
      AdmissionStatus.cancelled: Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors[admission.status]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        admission.status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: colors[admission.status],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 14, color: theme.colorScheme.onSurface.withOpacity(0.6)),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Color _getTypeColor() {
    switch (admission.type) {
      case AdmissionType.emergency:
        return Colors.red;
      case AdmissionType.scheduled:
        return Colors.blue;
      case AdmissionType.transfer:
        return Colors.orange;
      case AdmissionType.referral:
        return Colors.purple;
    }
  }

  IconData _getTypeIcon() {
    switch (admission.type) {
      case AdmissionType.emergency:
        return Icons.emergency;
      case AdmissionType.scheduled:
        return Icons.schedule;
      case AdmissionType.transfer:
        return Icons.sync_alt;
      case AdmissionType.referral:
        return Icons.assignment_ind;
    }
  }
}
