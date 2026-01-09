// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';
// import '../models/dashboard_models.dart';

// class AdminTasksWidget extends ConsumerWidget {
//   const AdminTasksWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tasks = ref.watch(escalatedTasksProvider);
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//           color: AppColors.cardBackground,
//           borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             const Row(children: [
//               Icon(Icons.warning_amber_rounded, color: AppColors.redAccent),
//               SizedBox(width: 12),
//               Text("Escalated Tasks",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ]),
//             Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                     color: AppColors.redAccent,
//                     borderRadius: BorderRadius.circular(20)),
//                 child: const Text("Overdue",
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))
//           ]),
//           const SizedBox(height: 24),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: tasks.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final task = tasks[index];
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                     color: AppColors.background,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.white10)),
//                 child: Row(children: [
//                   const Icon(Icons.access_time_filled,
//                       color: AppColors.redAccent),
//                   const SizedBox(width: 16),
//                   Expanded(
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                         Text(task.title,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16)),
//                         Text("${task.patientName} • Room ${task.room}",
//                             style: const TextStyle(
//                                 color: AppColors.textSecondary)),
//                         Text("Overdue by ${task.overdueMinutes} mins",
//                             style: const TextStyle(
//                                 color: AppColors.redAccent,
//                                 fontWeight: FontWeight.bold)),
//                       ])),
//                 ]),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
