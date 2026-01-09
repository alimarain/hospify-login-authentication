// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import '../models/nurse_alert.dart';
// import '../providers/nurse_alerts_provider.dart';

// class NurseAlertsScreen extends ConsumerStatefulWidget {
//   const NurseAlertsScreen({super.key});

//   @override
//   ConsumerState<NurseAlertsScreen> createState() => _NurseAlertsScreenState();
// }

// class _NurseAlertsScreenState extends ConsumerState<NurseAlertsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   AlertType? _filterType;
//   AlertPriority? _filterPriority;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final alerts = ref.watch(nurseAlertsProvider);
//     final criticalCount = ref.watch(criticalAlertsCountProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: AppBar(
//         title:
//             const Text('Alerts', style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//         elevation: 0,
//         actions: [
//           if (criticalCount > 0)
//             Container(
//               margin: const EdgeInsets.only(right: 8),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade100,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.warning, size: 16, color: Colors.red.shade700),
//                   const SizedBox(width: 4),
//                   Text('$criticalCount Critical',
//                       style: TextStyle(
//                           color: Colors.red.shade700,
//                           fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () => _showFilterSheet(context),
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.teal,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.teal,
//           tabs: [
//             Tab(
//                 text:
//                     'Active (${alerts.where((a) => a.status == AlertStatus.active).length})'),
//             Tab(
//                 text:
//                     'Acknowledged (${alerts.where((a) => a.status == AlertStatus.acknowledged).length})'),
//             Tab(
//                 text:
//                     'Resolved (${alerts.where((a) => a.status == AlertStatus.resolved).length})'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildAlertsList(
//               alerts.where((a) => a.status == AlertStatus.active).toList()),
//           _buildAlertsList(alerts
//               .where((a) => a.status == AlertStatus.acknowledged)
//               .toList()),
//           _buildAlertsList(
//               alerts.where((a) => a.status == AlertStatus.resolved).toList()),
//         ],
//       ),
//     );
//   }

//   Widget _buildAlertsList(List<NurseAlert> alerts) {
//     var filtered = alerts;
//     if (_filterType != null) {
//       filtered = filtered.where((a) => a.type == _filterType).toList();
//     }
//     if (_filterPriority != null) {
//       filtered = filtered.where((a) => a.priority == _filterPriority).toList();
//     }
//     filtered.sort((a, b) {
//       final priorityOrder = {
//         AlertPriority.high: 0,
//         AlertPriority.medium: 1,
//         AlertPriority.low: 2
//       };
//       return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
//     });

//     if (filtered.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.notifications_off,
//                 size: 64, color: Colors.grey.shade300),
//             const SizedBox(height: 16),
//             Text('No alerts',
//                 style: TextStyle(fontSize: 18, color: Colors.grey.shade600)),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: filtered.length,
//       itemBuilder: (context, index) => _AlertCard(
//         alert: filtered[index],
//         onAcknowledge: () => ref
//             .read(nurseAlertsProvider.notifier)
//             .acknowledgeAlert(filtered[index].id),
//         onResolve: () => ref
//             .read(nurseAlertsProvider.notifier)
//             .resolveAlert(filtered[index].id),
//         onDismiss: () => ref
//             .read(nurseAlertsProvider.notifier)
//             .dismissAlert(filtered[index].id),
//       ),
//     );
//   }

//   void _showFilterSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       builder: (context) => StatefulBuilder(
//         builder: (context, setModalState) => Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text('Filter Alerts',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _filterType = null;
//                         _filterPriority = null;
//                       });
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Clear All'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               const Text('Type', style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 children: AlertType.values
//                     .map((type) => FilterChip(
//                           label: Text(type.name.toUpperCase()),
//                           selected: _filterType == type,
//                           onSelected: (selected) {
//                             setModalState(() {});
//                             setState(
//                                 () => _filterType = selected ? type : null);
//                           },
//                         ))
//                     .toList(),
//               ),
//               const SizedBox(height: 16),
//               const Text('Priority',
//                   style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 children: AlertPriority.values
//                     .map((priority) => FilterChip(
//                           label: Text(priority.name.toUpperCase()),
//                           selected: _filterPriority == priority,
//                           onSelected: (selected) {
//                             setModalState(() {});
//                             setState(() =>
//                                 _filterPriority = selected ? priority : null);
//                           },
//                         ))
//                     .toList(),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AlertCard extends StatelessWidget {
//   final NurseAlert alert;
//   final VoidCallback onAcknowledge;
//   final VoidCallback onResolve;
//   final VoidCallback onDismiss;

//   const _AlertCard({
//     required this.alert,
//     required this.onAcknowledge,
//     required this.onResolve,
//     required this.onDismiss,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final config = _getAlertConfig(alert.type);
//     final priorityColor = _getPriorityColor(alert.priority);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border(left: BorderSide(color: priorityColor, width: 4)),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                           color: config['color'].withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Icon(config['icon'],
//                           color: config['color'], size: 20),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(alert.title,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 16)),
//                           const SizedBox(height: 2),
//                           Text(
//                               DateFormat('MMM d, h:mm a')
//                                   .format(alert.createdAt),
//                               style: TextStyle(
//                                   color: Colors.grey.shade600, fontSize: 12)),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                           color: priorityColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Text(alert.priority.name.toUpperCase(),
//                           style: TextStyle(
//                               color: priorityColor,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Text(alert.message,
//                     style: TextStyle(color: Colors.grey.shade700)),
//                 if (alert.patientName != null) ...[
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.person, size: 16, color: Colors.grey.shade500),
//                       const SizedBox(width: 4),
//                       Text(alert.patientName!,
//                           style: TextStyle(
//                               color: Colors.grey.shade600, fontSize: 13)),
//                       if (alert.roomNumber != null) ...[
//                         const SizedBox(width: 12),
//                         Icon(Icons.bed, size: 16, color: Colors.grey.shade500),
//                         const SizedBox(width: 4),
//                         Text('Room ${alert.roomNumber}',
//                             style: TextStyle(
//                                 color: Colors.grey.shade600, fontSize: 13)),
//                       ],
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//           if (alert.status == AlertStatus.active)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius:
//                     const BorderRadius.vertical(bottom: Radius.circular(16)),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: onDismiss,
//                       style: OutlinedButton.styleFrom(
//                           foregroundColor: Colors.grey),
//                       child: const Text('Dismiss'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: onAcknowledge,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal),
//                       child: const Text('Acknowledge'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           if (alert.status == AlertStatus.acknowledged)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius:
//                     const BorderRadius.vertical(bottom: Radius.circular(16)),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: onResolve,
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   child: const Text('Mark as Resolved'),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Map<String, dynamic> _getAlertConfig(AlertType type) {
//     switch (type) {
//       case AlertType.critical:
//         return {'icon': Icons.warning_amber, 'color': Colors.red};
//       case AlertType.medication:
//         return {'icon': Icons.medication, 'color': Colors.purple};
//       case AlertType.vitals:
//         return {'icon': Icons.monitor_heart, 'color': Colors.blue};
//       case AlertType.task:
//         return {'icon': Icons.task_alt, 'color': Colors.orange};
//       case AlertType.system:
//         return {'icon': Icons.info, 'color': Colors.grey};
//     }
//   }

//   Color _getPriorityColor(AlertPriority priority) {
//     switch (priority) {
//       case AlertPriority.high:
//         return Colors.red;
//       case AlertPriority.medium:
//         return Colors.orange;
//       case AlertPriority.low:
//         return Colors.green;
//     }
//   }
// }
