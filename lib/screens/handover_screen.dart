// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import '../models/handover.dart';
// import '../providers/handovers_provider.dart';
// import '../widgets/handover_card.dart';
// import '../widgets/add_handover_note_dialog.dart';

// class HandoverScreen extends ConsumerStatefulWidget {
//   const HandoverScreen({super.key});

//   @override
//   ConsumerState<HandoverScreen> createState() => _HandoverScreenState();
// }

// class _HandoverScreenState extends ConsumerState<HandoverScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pendingHandovers = ref.watch(pendingHandoversProvider);
//     final completedHandovers = ref.watch(completedHandoversProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: Column(
//         children: [
//           _buildHeader(pendingHandovers.length),
//           _buildCurrentShiftInfo(),
//           _buildTabBar(),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildHandoversList(pendingHandovers, isPending: true),
//                 _buildHandoversList(completedHandovers, isPending: false),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showCreateHandoverDialog(context),
//         backgroundColor: const Color(0xFF0EA5E9),
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text('New Handover', style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }

//   Widget _buildHeader(int pendingCount) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Shift Handover',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1E293B),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFF64748B),
//                 ),
//               ),
//             ],
//           ),
//           if (pendingCount > 0)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFEF3C7),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: const Color(0xFFF59E0B)),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.warning_amber_rounded,
//                     color: Color(0xFFF59E0B),
//                     size: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     '$pendingCount Pending Review',
//                     style: const TextStyle(
//                       color: Color(0xFFF59E0B),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCurrentShiftInfo() {
//     return Container(
//       margin: const EdgeInsets.all(24),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF0EA5E9).withOpacity(0.3),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.access_time,
//               color: Colors.white,
//               size: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Current Shift',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   'Morning Shift (6:00 AM - 2:00 PM)',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     _buildShiftInfoChip(Icons.person_outline, 'Sarah Johnson'),
//                     const SizedBox(width: 12),
//                     _buildShiftInfoChip(Icons.arrow_forward, 'Emily Davis'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShiftInfoChip(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 16),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 24),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F5F9),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TabBar(
//         controller: _tabController,
//         indicator: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         indicatorPadding: const EdgeInsets.all(4),
//         labelColor: const Color(0xFF1E293B),
//         unselectedLabelColor: const Color(0xFF64748B),
//         labelStyle: const TextStyle(fontWeight: FontWeight.w600),
//         tabs: const [
//           Tab(text: 'Pending'),
//           Tab(text: 'Completed'),
//         ],
//       ),
//     );
//   }

//   Widget _buildHandoversList(List<ShiftHandover> handovers, {required bool isPending}) {
//     if (handovers.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               isPending ? Icons.pending_actions : Icons.check_circle_outline,
//               size: 64,
//               color: Colors.grey[300],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               isPending ? 'No pending handovers' : 'No completed handovers',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF64748B),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(24),
//       itemCount: handovers.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: HandoverCard(
//             handover: handovers[index],
//             onAcknowledge: () {
//               ref.read(handoversProvider.notifier).acknowledgeHandover(handovers[index].id);
//             },
//             onComplete: () {
//               ref.read(handoversProvider.notifier).completeHandover(handovers[index].id);
//             },
//             onAddNote: () => _showAddNoteDialog(context, handovers[index].id),
//           ),
//         );
//       },
//     );
//   }

//   void _showCreateHandoverDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Create New Handover'),
//         content: const Text('This will create a new shift handover for the current shift.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final newHandover = ShiftHandover(
//                 id: DateTime.now().millisecondsSinceEpoch.toString(),
//                 outgoingStaffId: 'current_user',
//                 outgoingStaffName: 'Sarah Johnson',
//                 shiftDate: DateTime.now(),
//                 shiftType: 'Morning → Afternoon',
//                 notes: [],
//                 createdAt: DateTime.now(),
//               );
//               ref.read(handoversProvider.notifier).addHandover(newHandover);
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Handover created successfully'),
//                   backgroundColor: Color(0xFF10B981),
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF0EA5E9),
//             ),
//             child: const Text('Create', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddNoteDialog(BuildContext context, String handoverId) {
//     showDialog(
//       context: context,
//       builder: (context) => AddHandoverNoteDialog(
//         onAdd: (note) {
//           ref.read(handoversProvider.notifier).addNoteToHandover(handoverId, note);
//         },
//       ),
//     );
//   }
// }
