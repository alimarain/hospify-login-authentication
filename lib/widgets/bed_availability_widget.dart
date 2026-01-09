// import 'package:flutter/material.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import '../theme/app_theme.dart';

// class BedAvailabilityWidget extends StatelessWidget {
//   const BedAvailabilityWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Bed Availability",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text("Real-time bed tracking",
//                       style: TextStyle(
//                           color: AppColors.textSecondary, fontSize: 12)),
//                 ],
//               ),
//               Chip(label: Text("Total: 195"), backgroundColor: Colors.white10),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Responsive(
//             mobile: const Column(
//               children: [
//                 _BedRow(
//                     title: "ICU",
//                     used: 18,
//                     free: 2,
//                     total: 20,
//                     color: AppColors.redAccent),
//                 SizedBox(height: 16),
//                 _BedRow(
//                     title: "Emergency",
//                     used: 25,
//                     free: 5,
//                     total: 30,
//                     color: AppColors.orangeAccent),
//               ],
//             ),
//             desktop: const Row(
//               children: [
//                 Expanded(
//                     child: _BedRow(
//                         title: "ICU",
//                         used: 18,
//                         free: 2,
//                         total: 20,
//                         color: AppColors.redAccent)),
//                 SizedBox(width: 24),
//                 Expanded(
//                     child: _BedRow(
//                         title: "Emergency",
//                         used: 25,
//                         free: 5,
//                         total: 30,
//                         color: AppColors.orangeAccent)),
//                 SizedBox(width: 24),
//                 Expanded(
//                     child: _BedRow(
//                         title: "General Ward",
//                         used: 38,
//                         free: 12,
//                         total: 50,
//                         color: AppColors.orangeAccent)),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class _BedRow extends StatelessWidget {
//   final String title;
//   final int used;
//   final int free;
//   final int total;
//   final Color color;

//   const _BedRow(
//       {required this.title,
//       required this.used,
//       required this.free,
//       required this.total,
//       required this.color});

//   @override
//   Widget build(BuildContext context) {
//     double percentage = used / total;
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           color: AppColors.background, borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//               Text("${(percentage * 100).toInt()}%",
//                   style: TextStyle(color: color, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Text("$free free",
//                   style: const TextStyle(
//                       color: AppColors.secondaryAccent, fontSize: 12)),
//               const SizedBox(width: 8),
//               Text("$used used",
//                   style: const TextStyle(
//                       color: AppColors.textSecondary, fontSize: 12)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           LinearProgressIndicator(
//               value: percentage, color: color, backgroundColor: Colors.white10),
//         ],
//       ),
//     );
//   }
// }
