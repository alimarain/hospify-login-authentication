// lib/widgets/nurse_dashboard/critical_alerts_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Alert priority enum
enum AlertPriority { critical, high, medium, low }

// Alert model for dashboard
class DashboardAlert {
  final String id;
  final String title;
  final String patient;
  final String room;
  final AlertPriority priority;
  final DateTime time;
  final bool isAcknowledged;

  DashboardAlert({
    required this.id,
    required this.title,
    required this.patient,
    required this.room,
    required this.priority,
    required this.time,
    this.isAcknowledged = false,
  });
}

// Provider for dashboard alerts
final dashboardAlertsProvider =
    StateNotifierProvider<DashboardAlertsNotifier, List<DashboardAlert>>((ref) {
  return DashboardAlertsNotifier();
});

class DashboardAlertsNotifier extends StateNotifier<List<DashboardAlert>> {
  DashboardAlertsNotifier() : super(_initialAlerts);

  static final List<DashboardAlert> _initialAlerts = [
    DashboardAlert(
      id: '1',
      title: 'Critical Vital Signs',
      patient: 'John Smith',
      room: '101A',
      priority: AlertPriority.critical,
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    DashboardAlert(
      id: '2',
      title: 'Medication Overdue',
      patient: 'Mary Johnson',
      room: '102B',
      priority: AlertPriority.high,
      time: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    DashboardAlert(
      id: '3',
      title: 'Fall Risk Alert',
      patient: 'Robert Brown',
      room: '105A',
      priority: AlertPriority.critical,
      time: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    DashboardAlert(
      id: '4',
      title: 'IV Fluid Low',
      patient: 'Emily Davis',
      room: '103C',
      priority: AlertPriority.medium,
      time: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];

  void acknowledgeAlert(String id) {
    state = state.map((alert) {
      if (alert.id == id) {
        return DashboardAlert(
          id: alert.id,
          title: alert.title,
          patient: alert.patient,
          room: alert.room,
          priority: alert.priority,
          time: alert.time,
          isAcknowledged: true,
        );
      }
      return alert;
    }).toList();
  }

  void dismissAlert(String id) {
    state = state.where((alert) => alert.id != id).toList();
  }
}

class CriticalAlertsCard extends ConsumerWidget {
  final VoidCallback? onViewAll;

  const CriticalAlertsCard({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(dashboardAlertsProvider);
    final criticalCount = alerts
        .where((a) => a.priority == AlertPriority.critical && !a.isAcknowledged)
        .length;
    final highCount = alerts
        .where((a) => a.priority == AlertPriority.high && !a.isAcknowledged)
        .length;
    final totalActive = alerts.where((a) => !a.isAcknowledged).length;

    return Card(
      elevation: 4,
      shadowColor: criticalCount > 0
          ? Colors.red.withOpacity(0.3)
          : Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: criticalCount > 0
            ? const BorderSide(color: Colors.red, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onViewAll,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: criticalCount > 0
                          ? Colors.red.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.warning_rounded,
                      color: criticalCount > 0 ? Colors.red : Colors.orange,
                      size: 24,
                    ),
                  ),
                  if (criticalCount > 0) _buildPulsingIndicator(),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '$totalActive',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          criticalCount > 0 ? Colors.red : Colors.orange[700],
                    ),
              ),
              Text(
                'Active Alerts',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 12),
              _buildAlertBreakdown(context, criticalCount, highCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulsingIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.withOpacity(value),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.4 * value),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
      onEnd: () {},
    );
  }

  Widget _buildAlertBreakdown(BuildContext context, int critical, int high) {
    return Row(
      children: [
        _buildBadge(context, '$critical Critical', Colors.red),
        const SizedBox(width: 6),
        _buildBadge(context, '$high High', Colors.orange),
      ],
    );
  }

  Widget _buildBadge(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
