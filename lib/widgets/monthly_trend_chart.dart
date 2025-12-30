// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';

// class MonthlyTrendChart extends ConsumerWidget {
//   const MonthlyTrendChart({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final data = ref.watch(monthlyTrendProvider);

//     return Container(
//       height: 350,
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Monthly Trend",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text("Patients vs Appointments",
//                       style: TextStyle(
//                           color: AppColors.textSecondary, fontSize: 12)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   _buildLegend(AppColors.primaryAccent, "Patients"),
//                   const SizedBox(width: 16),
//                   _buildLegend(AppColors.secondaryAccent, "Appointments"),
//                 ],
//               )
//             ],
//           ),
//           const SizedBox(height: 24),
//           Expanded(
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: 350,
//                 barTouchData: BarTouchData(enabled: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         const style =
//                             TextStyle(color: Colors.grey, fontSize: 10);
//                         String text;
//                         switch (value.toInt()) {
//                           case 0:
//                             text = 'Jan';
//                             break;
//                           case 1:
//                             text = 'Feb';
//                             break;
//                           case 2:
//                             text = 'Mar';
//                             break;
//                           case 3:
//                             text = 'Apr';
//                             break;
//                           case 4:
//                             text = 'May';
//                             break;
//                           case 5:
//                             text = 'Jun';
//                             break;
//                           default:
//                             text = '';
//                         }
//                         return SideTitleWidget(
//                             axisSide: meta.axisSide,
//                             child: Text(text, style: style));
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 30,
//                         interval: 85,
//                         getTitlesWidget: (value, meta) {
//                           return Text(value.toInt().toString(),
//                               style: const TextStyle(
//                                   color: Colors.grey, fontSize: 10));
//                         }),
//                   ),
//                   topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   drawVerticalLine: true,
//                   getDrawingHorizontalLine: (value) =>
//                       const FlLine(color: Colors.white10, strokeWidth: 1),
//                   getDrawingVerticalLine: (value) =>
//                       const FlLine(color: Colors.white10, strokeWidth: 1),
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barGroups: data.map((point) {
//                   return BarChartGroupData(
//                     x: point.x,
//                     barRods: [
//                       BarChartRodData(
//                           toY: point.patients,
//                           color: AppColors.primaryAccent,
//                           width: 12,
//                           borderRadius: BorderRadius.circular(2)),
//                       BarChartRodData(
//                           toY: point.appointments,
//                           color: AppColors.secondaryAccent,
//                           width: 12,
//                           borderRadius: BorderRadius.circular(2)),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLegend(Color color, String text) {
//     return Row(
//       children: [
//         CircleAvatar(radius: 4, backgroundColor: color),
//         const SizedBox(width: 6),
//         Text(text,
//             style:
//                 const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
//       ],
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/dashboard_providers.dart';

class MonthlyTrendChart extends ConsumerWidget {
  const MonthlyTrendChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(monthlyTrendProvider);
    return Container(
      height: 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Monthly Trend",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, m) => Text(
                            [
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun'
                            ][v.toInt()],
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10)))),
                leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: data
                  .map((point) => BarChartGroupData(x: point.x, barRods: [
                        BarChartRodData(
                            toY: point.patients,
                            color: AppColors.primaryAccent,
                            width: 12,
                            borderRadius: BorderRadius.circular(2)),
                        BarChartRodData(
                            toY: point.appointments,
                            color: AppColors.secondaryAccent,
                            width: 12,
                            borderRadius: BorderRadius.circular(2)),
                      ]))
                  .toList(),
            )),
          ),
        ],
      ),
    );
  }
}
