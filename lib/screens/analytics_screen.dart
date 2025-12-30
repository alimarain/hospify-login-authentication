// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';

// class AnalyticsScreen extends StatelessWidget {
//   const AnalyticsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Analytics',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: AppTheme.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Container(
//             padding: const EdgeInsets.all(48),
//             decoration: BoxDecoration(
//               color: AppTheme.surface,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: AppTheme.border),
//             ),
//             child: Center(
//               child: Column(
//                 children: [
//                   Icon(Icons.bar_chart, size: 64, color: AppTheme.textMuted),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Analytics module',
//                     style:
//                         TextStyle(fontSize: 18, color: AppTheme.textSecondary),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
