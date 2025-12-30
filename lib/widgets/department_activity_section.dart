import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/utils/responsive_utils.dart';
import '../theme/app_theme.dart';
import '../providers/dashboard_providers.dart';

class DepartmentActivitySection extends StatelessWidget {
  const DepartmentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const Column(
        children: [
          _DepartmentOverview(),
          SizedBox(height: 24),
          _RecentActivity(),
        ],
      ),
      desktop: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _DepartmentOverview()),
          SizedBox(width: 24),
          Expanded(flex: 1, child: _RecentActivity()),
        ],
      ),
    );
  }
}

class _DepartmentOverview extends ConsumerWidget {
  const _DepartmentOverview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depts = ref.watch(departmentDataProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Department Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: depts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final dept = depts[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dept.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text("${(dept.percentage * 100).toInt()}%",
                          style: TextStyle(
                              color: dept.color, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text("${dept.patients} patients • ${dept.staff} staff",
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: dept.percentage,
                    backgroundColor: Colors.black26,
                    color: dept.color,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class _RecentActivity extends ConsumerWidget {
  const _RecentActivity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(recentActivityProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recent Activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final item = activities[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(radius: 4, backgroundColor: item.color),
                      if (index != activities.length - 1)
                        Container(
                            width: 1,
                            height: 30,
                            color: Colors.white10,
                            margin: const EdgeInsets.only(top: 4))
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description,
                            style: const TextStyle(fontSize: 13, height: 1.2)),
                        const SizedBox(height: 4),
                        Text(item.timeAgo,
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 11)),
                      ],
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
