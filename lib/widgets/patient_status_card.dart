// lib/widgets/nurse_dashboard/patient_status_card.dart
import 'package:flutter/material.dart';

class PatientStatusCard extends StatelessWidget {
  final VoidCallback? onViewAll;

  const PatientStatusCard({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Patients',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: onViewAll,
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatusItem(context, '8', 'Assigned', Colors.blue),
                _buildStatusItem(context, '2', 'Critical', Colors.red),
                _buildStatusItem(context, '1', 'Discharge', Colors.green),
                _buildStatusItem(context, '3', 'New Admit', Colors.purple),
              ],
            ),
            const SizedBox(height: 16),
            _buildPatientList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(
      BuildContext context, String count, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color.withOpacity(0.8),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientList(BuildContext context) {
    final patients = [
      {
        'name': 'John Smith',
        'room': '101A',
        'status': 'critical',
        'task': 'Vitals due'
      },
      {
        'name': 'Mary Johnson',
        'room': '102B',
        'status': 'stable',
        'task': 'Medication'
      },
      {
        'name': 'Robert Brown',
        'room': '105A',
        'status': 'critical',
        'task': 'Assessment'
      },
    ];

    return Column(
      children: patients
          .map((patient) => _buildPatientItem(context, patient))
          .toList(),
    );
  }

  Widget _buildPatientItem(BuildContext context, Map<String, String> patient) {
    final isCritical = patient['status'] == 'critical';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCritical
            ? Colors.red.withOpacity(0.05)
            : Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border:
            isCritical ? Border.all(color: Colors.red.withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: isCritical
                ? Colors.red.withOpacity(0.1)
                : Colors.blue.withOpacity(0.1),
            child: Text(
              patient['name']![0],
              style: TextStyle(
                color: isCritical ? Colors.red : Colors.blue,
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
                  patient['name']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'Room ${patient['room']}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              patient['task']!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.amber[800],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
