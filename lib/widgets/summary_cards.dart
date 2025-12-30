// import 'package:flutter/material.dart';
// import '../utils/responsive_utils.dart';

// class SummaryCards extends StatelessWidget {
//   const SummaryCards({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);

//     return GridView.count(
//       crossAxisCount: isMobile ? 1 : 4,
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: const [
//         _SummaryCard(title: 'Total Patients', value: '120'),
//         _SummaryCard(title: 'Appointments Today', value: '78'),
//         _SummaryCard(title: 'Available Beds', value: '42'),
//         _SummaryCard(title: 'Critical Patients', value: '12'),
//       ],
//     );
//   }
// }

// class _SummaryCard extends StatelessWidget {
//   final String title;
//   final String value;
//   const _SummaryCard({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Theme.of(context).cardColor,
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           const SizedBox(height: 8),
//           Text(value,
//               style:
//                   const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import '../providers/dashboard_providers.dart';
// import '../theme/app_theme.dart';
// import '../models/dashboard_models.dart';

// class SummaryCards extends ConsumerWidget {
//   const SummaryCards({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final data = ref.watch(summaryCardsProvider);

//     return Responsive(
//       mobile: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: data.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           childAspectRatio: 1.4,
//         ),
//         itemBuilder: (context, index) => _SummaryCard(data: data[index]),
//       ),
//       desktop: Row(
//         children: data
//             .map((e) => Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 16.0),
//                     child: _SummaryCard(data: e),
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }

// class _SummaryCard extends StatelessWidget {
//   final SummaryCardData data;
//   const _SummaryCard({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(data.title,
//                   style: const TextStyle(
//                       color: AppColors.textSecondary, fontSize: 13)),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     color: AppColors.primaryAccent.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8)),
//                 child:
//                     Icon(data.icon, color: AppColors.primaryAccent, size: 18),
//               ),
//             ],
//           ),
//           Text(data.value,
//               style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';

class SummaryCards extends StatelessWidget {
  final List<SummaryCardData> data;
  const SummaryCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveUtils.getCrossAxisCount(context, base: 4);
    // Adjusted aspect ratio to fit the taller content (Title + Value + Subtitle)
    double childAspectRatio = ResponsiveUtils.isMobile(context) ? 1.5 : 1.3;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => _SummaryCard(data: data[index]),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final SummaryCardData data;
  const _SummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    // ✅ FIX: Wrapped in Material to enable InkWell and prevent crashes
    return Material(
      color: AppColors.card, // Dark background matching UI
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- Top Row: Title + Icon ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      data.title, // "Total patients"
                      style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (data.iconColor ?? AppColors.primaryAccent)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(data.icon,
                        color: data.iconColor ?? AppColors.primaryAccent,
                        size: 18),
                  ),
                ],
              ),

              const Spacer(),

              // --- Bottom Row: Value + Subtitle ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.value, // "352"
                      style: const TextStyle(
                          fontSize: 32, // Large font matching screenshot
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(data.title, // Repeating title as subtitle per design
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
