// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';

// // 1. Ward Summary Widget
// class WardSummaryWidget extends ConsumerWidget {
//   const WardSummaryWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final wards = ref.watch(wardSummaryProvider);

//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Ward Summary",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.textPrimary,
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child:
//                   Text("View All", style: TextStyle(color: AppTheme.primary)),
//             )
//           ],
//         ),
//         const SizedBox(height: 12),
//         // Horizontal Scroll for Wards
//         SizedBox(
//           height: 100, // Fixed height to prevent overflow
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: wards.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               final ward = wards[index];
//               // Wrap in Material to prevent "No Material Widget" error if InkWell is added later
//               return Material(
//                 color: AppTheme.cardColor,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   width: 140,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppTheme.border),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(radius: 4, backgroundColor: ward.color),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               ward.name,
//                               style: TextStyle(
//                                   fontSize: 12, color: AppTheme.textSecondary),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           if (ward.criticalCount > 0)
//                             Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: const BoxDecoration(
//                                   color: AppColors.redAccent,
//                                   shape: BoxShape.circle),
//                               child: Text(
//                                 "${ward.criticalCount}",
//                                 style: const TextStyle(
//                                     fontSize: 10, color: Colors.white),
//                               ),
//                             )
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "${ward.count}",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppTheme.textPrimary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: AppColors.redAccent.withOpacity(0.15),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: AppColors.redAccent.withOpacity(0.3)),
//           ),
//           child: const Text(
//             "3 critical patients across all wards",
//             style: TextStyle(
//                 color: AppColors.redAccent, fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }
// }

// // 2. Doctor Tasks (Checklist)
// class DoctorTasksWidget extends ConsumerWidget {
//   const DoctorTasksWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tasks = ref.watch(doctorTasksProvider);
//     final pending = tasks.where((t) => !t.isCompleted).toList();
//     final completed = tasks.where((t) => t.isCompleted).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Today's Tasks",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AppTheme.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 16),

//         // Pending Tasks List
//         if (pending.isEmpty)
//           const Text("No pending tasks", style: TextStyle(color: Colors.grey))
//         else
//           // Using Wrap for responsive grid-like behavior for tasks
//           Wrap(
//             spacing: 16,
//             runSpacing: 16,
//             children:
//                 pending.map((task) => _buildCard(context, ref, task)).toList(),
//           ),

//         // Completed Tasks List
//         if (completed.isNotEmpty) ...[
//           const SizedBox(height: 24),
//           Text(
//             "Completed",
//             style: TextStyle(color: AppTheme.textSecondary),
//           ),
//           const SizedBox(height: 8),
//           ...completed.map((task) => _buildCompletedRow(context, ref, task)),
//         ]
//       ],
//     );
//   }

//   Widget _buildCard(BuildContext context, WidgetRef ref, dynamic task) {
//     // Responsive width calculation to prevent overflow
//     // On Desktop: Fixed width cards (350px)
//     // On Mobile: Full width cards
//     final cardWidth = Responsive.isDesktop(context) ? 350.0 : double.infinity;

//     return Material(
//       color: AppTheme.cardColor,
//       borderRadius: BorderRadius.circular(12),
//       // Adding explicit ShapeDecoration or using Material props prevents ink splashes being hidden
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           // Optional: Navigate to task details
//         },
//         child: Container(
//           width: cardWidth,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: AppTheme.border),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Custom Checkbox via InkWell
//               Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   customBorder: const CircleBorder(),
//                   onTap: () => ref
//                       .read(doctorTasksProvider.notifier)
//                       .toggleTask(task.id),
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                     margin: const EdgeInsets.all(2), // Padding for touch target
//                     decoration: BoxDecoration(
//                       border: Border.all(color: AppTheme.textSecondary),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       task.title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time,
//                             size: 12, color: AppTheme.textSecondary),
//                         const SizedBox(width: 4),
//                         Text(
//                           task.time,
//                           style: TextStyle(
//                               fontSize: 12, color: AppTheme.textSecondary),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: _getColor(task.priority).withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Text(
//                             task.priority,
//                             style: TextStyle(
//                                 color: _getColor(task.priority), fontSize: 10),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCompletedRow(BuildContext context, WidgetRef ref, dynamic task) {
//     return Material(
//       color: Colors.transparent, // Use transparent so background shows through
//       child: InkWell(
//         onTap: () => ref.read(doctorTasksProvider.notifier).toggleTask(task.id),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//           child: Row(
//             children: [
//               const Icon(Icons.check_circle, color: Colors.grey, size: 20),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   task.title,
//                   style: const TextStyle(
//                     decoration: TextDecoration.lineThrough,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getColor(String p) => p == 'high'
//       ? AppColors.redAccent
//       : (p == 'medium' ? AppColors.orangeAccent : AppColors.secondaryAccent);
// }

// // 3. Appointments Widget
// class AppointmentsWidget extends ConsumerWidget {
//   const AppointmentsWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appts = ref.watch(appointmentsProvider);

//     // Using Material here for the dark card look
//     return Material(
//       color: Colors.black, // Specific dark styling for this widget
//       borderRadius: BorderRadius.circular(16),
//       elevation: 4,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Today's Appointments",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.add, size: 16),
//                   label: const Text("Add"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.cardBackground,
//                     foregroundColor: Colors.white,
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: appts.length,
//               separatorBuilder: (_, __) => const Divider(color: Colors.white10),
//               itemBuilder: (context, index) {
//                 final a = appts[index];
//                 return ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading: const CircleAvatar(
//                     backgroundColor: Colors.grey,
//                     child: Icon(Icons.person, color: Colors.white),
//                   ),
//                   title: Text(
//                     a.name,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   subtitle: Text(
//                     a.type,
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                   trailing: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         a.time,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       Text(
//                         a.duration,
//                         style:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';

// // ... (WardSummaryWidget remains the same as previous response) ...

// // 2. Doctor Tasks (Checklist UI)
// class DoctorTasksWidget extends ConsumerWidget {
//   const DoctorTasksWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tasks = ref.watch(doctorTasksProvider);
//     final pending = tasks.where((t) => !t.isCompleted).toList();
//     final completed = tasks.where((t) => t.isCompleted).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Icon(Icons.check_circle_outline, color: Colors.grey, size: 20),
//             const SizedBox(width: 8),
//             const Text("Today's Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
//             const SizedBox(width: 8),
//             Text("${pending.length} pending • ${completed.length} completed", style: const TextStyle(color: Colors.grey, fontSize: 13)),
//           ],
//         ),
//         const SizedBox(height: 16),

//         // Grid of pending tasks
//         Wrap(
//           spacing: 16,
//           runSpacing: 16,
//           children: pending.map((task) => _buildTaskCard(context, ref, task)).toList(),
//         ),

//         // Completed List
//         if (completed.isNotEmpty) ...[
//           const SizedBox(height: 24),
//           const Text("Completed", style: TextStyle(color: Colors.grey)),
//           const SizedBox(height: 8),
//           ...completed.map((task) => _buildCompletedRow(context, ref, task)),
//         ]
//       ],
//     );
//   }

//   Widget _buildTaskCard(BuildContext context, WidgetRef ref, dynamic task) {
//     // Determine card width based on screen size
//     final width = Responsive.isDesktop(context) ? 350.0 : double.infinity;

//     return Container(
//       width: width,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.white10),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Interactive Checkbox
//           InkWell(
//             onTap: () => ref.read(doctorTasksProvider.notifier).toggleTask(task.id),
//             child: Container(
//               width: 20, height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.grey),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(task.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Icon(Icons.access_time, size: 12, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Text(task.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                     const SizedBox(width: 12),
//                     _buildPriorityTag(task.priority),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildPriorityTag(String priority) {
//     Color color;
//     switch (priority) {
//       case 'high': color = AppColors.redAccent; break;
//       case 'medium': color = AppColors.orangeAccent; break;
//       default: color = AppColors.secondaryAccent;
//     }
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
//       child: Text(priority, style: TextStyle(color: color, fontSize: 10)),
//     );
//   }

//   Widget _buildCompletedRow(BuildContext context, WidgetRef ref, dynamic task) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: () => ref.read(doctorTasksProvider.notifier).toggleTask(task.id),
//             child: const Icon(Icons.check_circle, color: Colors.grey, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Text(task.title, style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)),
//         ],
//       ),
//     );
//   }
// }

// // 3. Appointments Widget
// class AppointmentsWidget extends ConsumerWidget {
//   const AppointmentsWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appts = ref.watch(appointmentsProvider);

//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.black, // Darker bg for this specific card per image
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white10),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("Today's Appointments", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//               Row(
//                 children: [
//                   const Text("3 scheduled", style: TextStyle(color: Colors.grey, fontSize: 13)),
//                   const SizedBox(width: 12),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.add, size: 16, color: Colors.white),
//                     label: const Text("Add", style: TextStyle(color: Colors.white)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.cardBackground,
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           const SizedBox(height: 20),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: appts.length,
//             separatorBuilder: (_, __) => const Divider(color: Colors.white10),
//             itemBuilder: (context, index) {
//               final a = appts[index];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Row(
//                   children: [
//                     const CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white)),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(a.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 4),
//                           Text(a.type, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(a.time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             const Icon(Icons.access_time, size: 12, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(a.duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                           ],
//                         )
//                       ],
//                     ),
//                     const SizedBox(width: 16),
//                     const Icon(Icons.more_vert, color: Colors.grey),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/dashboard_providers.dart';
import '../utils/responsive_utils.dart';

// --- 1. Ward Summary Widget ---
class WardSummaryWidget extends ConsumerWidget {
  const WardSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wards = ref.watch(wardSummaryProvider);

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.people_outline,
                    size: 20, color: AppColors.textPrimary),
                SizedBox(width: 8),
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
              child: const Row(
                children: [
                  Text("View All",
                      style: TextStyle(
                          color: AppColors.textPrimary, fontSize: 14)),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right,
                      size: 16, color: AppColors.textPrimary),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 12),

        // Cards List
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: wards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final ward = wards[index];
              return Material(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(
                    8), // Slightly sharper corners matching image
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 150, // Wider cards
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              Colors.white.withOpacity(0.05)), // Subtle border
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 4, backgroundColor: ward.color),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ward.name,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (ward.criticalCount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
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
                        Text("${ward.count}",
                            style: const TextStyle(
                                fontSize: 24,
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

        // Critical Alert Bar
        Material(
          color: AppColors.redAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.redAccent.withOpacity(0.3)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("3 critical patients across all wards",
                      style: TextStyle(
                          color: AppColors.redAccent,
                          fontWeight: FontWeight.w500)),
                  Text("View Details",
                      style: TextStyle(
                          color: AppColors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

// --- 2. Doctor Tasks Widget ---
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
        const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Text("Today's Tasks",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
          ],
        ),
        Text("${pending.length} pending • ${completed.length} completed",
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 16),

        // Task Grid
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: pending
              .map((task) => _buildTaskCard(context, ref, task))
              .toList(),
        ),

        if (completed.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text("Completed",
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          ...completed.map((task) => _buildCompletedRow(context, ref, task)),
        ]
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, WidgetRef ref, dynamic task) {
    final width = ResponsiveUtils.isDesktop(context) ? 350.0 : double.infinity;

    return Material(
      color: AppColors.card, // Dark card
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // No border or very subtle one
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => ref
                      .read(doctorTasksProvider.notifier)
                      .toggleTask(task.id),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            fontSize: 14)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(task.time,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(task.priority)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(task.priority,
                              style: TextStyle(
                                  color: _getPriorityColor(task.priority),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
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
    return Material(
      color: AppColors.card.withOpacity(0.4),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => ref.read(doctorTasksProvider.notifier).toggleTask(task.id),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.grey, size: 20),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(task.title,
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough))),
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
      default:
        return AppColors.secondaryAccent;
    }
  }
}

// --- 3. Appointments Widget ---
class AppointmentsWidget extends ConsumerWidget {
  const AppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appts = ref.watch(appointmentsProvider);

    return Material(
      color: const Color(0xFF111111), // Very dark background per image
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
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
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.add, size: 16, color: Colors.white),
                      label: const Text("Add",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.card,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appts.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.grey.withOpacity(0.1), height: 24),
              itemBuilder: (context, index) {
                final appt = appts[index];
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade800,
                      child: const Icon(Icons.person,
                          color: Colors.white70, size: 20),
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
                    const SizedBox(width: 16),
                    const Icon(Icons.more_vert, color: Colors.grey, size: 18),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
