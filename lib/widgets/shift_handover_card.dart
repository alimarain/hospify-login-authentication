import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/handover.dart';
import '../providers/handovers_provider.dart';
import '../widgets/handover_card.dart';
import '../widgets/add_handover_note_dialog.dart';

class ShiftHandoverCard extends ConsumerStatefulWidget {
  const ShiftHandoverCard({super.key});

  @override
  ConsumerState<ShiftHandoverCard> createState() => _ShiftHandoverCardState();
}

class _ShiftHandoverCardState extends ConsumerState<ShiftHandoverCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingHandovers = ref.watch(pendingHandoversProvider);
    final completedHandovers = ref.watch(completedHandoversProvider);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, pendingHandovers.length),
            const SizedBox(height: 12),
            _buildCurrentShiftInfo(),
            const SizedBox(height: 16),
            _buildTabBar(context),
            const SizedBox(height: 12),
            SizedBox(
              height: 280,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHandoversList(pendingHandovers, isPending: true),
                  _buildHandoversList(completedHandovers, isPending: false),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () => _showCreateHandoverDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('New Handover'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Header ---
  Widget _buildHeader(BuildContext context, int pendingCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shift Handover',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              DateFormat('EEEE, MMM d').format(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        if (pendingCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF59E0B)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Color(0xFFF59E0B), size: 18),
                const SizedBox(width: 6),
                Text(
                  '$pendingCount Pending',
                  style: const TextStyle(
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// --- Current Shift Info ---
  Widget _buildCurrentShiftInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Current Shift',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 2),
                Text(
                  'Morning Shift (6:00 AM - 2:00 PM)',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --- Tabs ---
  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        labelColor: Theme.of(context).colorScheme.onSurface,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Pending'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }

  /// --- List ---
  Widget _buildHandoversList(List<ShiftHandover> handovers,
      {required bool isPending}) {
    if (handovers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPending ? Icons.pending_actions : Icons.check_circle_outline,
              size: 48,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 8),
            Text(
              isPending ? 'No pending handovers' : 'No completed handovers',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: handovers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HandoverCard(
            handover: handovers[index],
            onAcknowledge: () {
              ref
                  .read(handoversProvider.notifier)
                  .acknowledgeHandover(handovers[index].id);
            },
            onComplete: () {
              ref
                  .read(handoversProvider.notifier)
                  .completeHandover(handovers[index].id);
            },
            onAddNote: () => _showAddNoteDialog(context, handovers[index].id),
          ),
        );
      },
    );
  }

  /// --- Dialogs ---
  void _showCreateHandoverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Handover'),
        content: const Text(
            'This will create a new shift handover for the current shift.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newHandover = ShiftHandover(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                outgoingStaffId: 'current_user',
                outgoingStaffName: 'Sarah Johnson',
                shiftDate: DateTime.now(),
                shiftType: 'Morning → Afternoon',
                notes: [],
                createdAt: DateTime.now(),
              );
              ref.read(handoversProvider.notifier).addHandover(newHandover);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Handover created successfully'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5E9),
            ),
            child: const Text('Create', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, String handoverId) {
    showDialog(
      context: context,
      builder: (context) => AddHandoverNoteDialog(
        onAdd: (note) {
          ref
              .read(handoversProvider.notifier)
              .addNoteToHandover(handoverId, note);
        },
      ),
    );
  }
}
