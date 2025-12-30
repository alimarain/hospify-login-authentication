import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/dashboard_providers.dart';
import '../utils/responsive_utils.dart'; // Ensure correct path

// --- 1. Ward Summary Widget (Matches Image 4) ---
class WardSummaryWidget extends ConsumerWidget {
  const WardSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wards = ref.watch(wardSummaryProvider);

    return Column(
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.people_outline,
                    size: 20, color: AppColors.textPrimary),
                const SizedBox(width: 8),
                Text(
                  "Ward Summary",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text("View All",
                      style: TextStyle(color: AppColors.textPrimary)),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right,
                      size: 16, color: AppColors.textPrimary),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 12),

        // Horizontal Scrollable Cards
        SizedBox(
          height: 100, // Fixed height to prevent overflow
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: wards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final ward = wards[index];
              // ✅ FIX: Wrapped in Material to prevent crash
              return Material(
                color: AppColors
                    .card, // ✅ FIX: Use static color to avoid null error
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Top Row: Dot + Name + Critical Badge
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 4, backgroundColor: ward.color),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ward.name,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Critical Badge
                            if (ward.criticalCount > 0)
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: AppColors.redAccent,
                                    shape: BoxShape.circle),
                                child: Text("${ward.criticalCount}",
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              )
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Patient Count
                        Text("${ward.count}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // Critical Alert Bar (Bottom Red Bar)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.redAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.redAccent.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("3 critical patients across all wards",
                  style: TextStyle(color: AppColors.redAccent)),
              Text("View Details",
                  style: TextStyle(
                      color: AppColors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ],
          ),
        )
      ],
    );
  }
}

// --- 2. Doctor Tasks Widget (Matches Image 5) ---
class DoctorTasksWidget extends ConsumerWidget {
  const DoctorTasksWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(doctorTasksProvider);
    final pending = tasks.where((t) => !t.isCompleted).toList();
    final completed = tasks.where((t) => t.isCompleted).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text("Today's Tasks",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
          ],
        ),
        Text("${pending.length} pending • ${completed.length} completed",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 16),

        // Pending Tasks List
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: pending
              .map((task) => _buildTaskCard(context, ref, task))
              .toList(),
        ),

        // Completed Section
        if (completed.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text("Completed", style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          ...completed.map((task) => _buildCompletedRow(context, ref, task)),
        ]
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, WidgetRef ref, dynamic task) {
    final width = ResponsiveUtils.isDesktop(context) ? 350.0 : double.infinity;

    // ✅ FIX: Wrapped in Material to prevent "No Material widget found"
    return Material(
      color: AppColors.card, // ✅ FIX: Used AppColors.card
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => ref
                      .read(doctorTasksProvider.notifier)
                      .toggleTask(task.id),
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textSecondary),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(task.time,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                        const SizedBox(width: 12),
                        // Priority Tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(task.priority)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(task.priority,
                              style: TextStyle(
                                  color: _getPriorityColor(task.priority),
                                  fontSize: 10)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedRow(BuildContext context, WidgetRef ref, dynamic task) {
    // ✅ FIX: Wrapped in Material
    return Material(
      color: AppColors.card.withOpacity(0.5), // ✅ FIX: Use AppColors.card
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => ref.read(doctorTasksProvider.notifier).toggleTask(task.id),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.check_circle,
                  color: AppColors.textSecondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(task.title,
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.redAccent;
      case 'medium':
        return AppColors.orangeAccent;
      case 'low':
        return AppColors.secondaryAccent;
      default:
        return Colors.grey;
    }
  }
}

// --- 3. Appointments Widget (Matches Image 6) ---
class AppointmentsWidget extends ConsumerWidget {
  const AppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appts = ref.watch(appointmentsProvider);

    // ✅ FIX: Wrapped in Material
    return Material(
      color: Colors.black, // Dark background from screenshot
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Today's Appointments",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Row(
                  children: [
                    Text("${appts.length} scheduled",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(width: 12),
                    // Add Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.add, size: 16, color: Colors.white),
                      label: const Text("Add",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.card,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            // List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appts.length,
              separatorBuilder: (_, __) => const Divider(color: Colors.white10),
              itemBuilder: (context, index) {
                final appt = appts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade800,
                        child: const Icon(Icons.person, color: Colors.white70),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appt.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white)),
                            const SizedBox(height: 4),
                            Text(appt.type,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(appt.time,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 12, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(appt.duration,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
