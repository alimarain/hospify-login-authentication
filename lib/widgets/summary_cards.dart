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
    // Responsive grid counts
    final crossAxisCount = ResponsiveUtils.isMobile(context)
        ? 1
        : ResponsiveUtils.isTablet(context)
            ? 2
            : 4;

    // Cards are wide and short in this design (Icon Left + Text Right)
    double childAspectRatio = ResponsiveUtils.isMobile(context) ? 2.3 : 2.6;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
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
    // Use the color from data, or fallback to primary accent
    final accentColor = data.iconColor ?? AppColors.primaryAccent;

    return Material(
      color: AppColors.card, // Dark card background
      borderRadius: BorderRadius.circular(16), // Rounded corners
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- 1. Icon Box (Left) ---
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  // Subtle background tint of the icon's color
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  data.icon,
                  color: accentColor,
                  size: 28,
                ),
              ),

              const SizedBox(width: 20),

              // --- 2. Text Content (Right) ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Big Value
                    Text(
                      data.value,
                      style: const TextStyle(
                        fontSize: 32, // Large font size matching design
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.0, // Tighter line height
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Title Label
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
