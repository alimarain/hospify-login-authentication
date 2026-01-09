import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/nurse_alert.dart';
import '../../providers/nurse_alerts_provider.dart';

class TaskAlertsCard extends ConsumerWidget {
  final Function(NurseAlert) onAlertTap;

  const TaskAlertsCard({super.key, required this.onAlertTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(nurseAlertsProvider);
    final unreadCount = ref.watch(unreadAlertsCountProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_active, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text('Task Alerts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    if (unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text('$unreadCount pending',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ],
                  ],
                ),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const Divider(),
            alertsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (alerts) {
                if (alerts.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                        child: Text('No alerts',
                            style: TextStyle(color: Colors.grey))),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: alerts.take(5).length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    return _AlertListItem(
                        alert: alert, onTap: () => onAlertTap(alert));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertListItem extends StatelessWidget {
  final NurseAlert alert;
  final VoidCallback onTap;

  const _AlertListItem({required this.alert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: alert.type.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Icon(alert.type.icon, color: alert.type.color, size: 20),
      ),
      title: Text(alert.title,
          style: TextStyle(
              fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(alert.message, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${alert.patient} • Room ${alert.room}',
                  style: const TextStyle(fontSize: 12)),
              const Spacer(),
              Text(alert.time,
                  style: TextStyle(
                      fontSize: 12,
                      color: alert.type == AlertType.post ||
                              alert.type == AlertType.admin
                          ? Colors.red
                          : Colors.grey)),
            ],
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: alert.category.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(alert.category.icon, size: 14, color: alert.category.color),
            const SizedBox(width: 4),
            Text(alert.category.label,
                style: TextStyle(fontSize: 12, color: alert.category.color)),
          ],
        ),
      ),
    );
  }
}
