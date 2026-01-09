import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/discharge.dart';
import '../providers/discharges_provider.dart';
import '../widgets/discharge_form_dialog.dart';
import '../widgets/discharge_card.dart';

class DischargesScreen extends ConsumerStatefulWidget {
  const DischargesScreen({super.key});

  @override
  ConsumerState<DischargesScreen> createState() => _DischargesScreenState();
}

class _DischargesScreenState extends ConsumerState<DischargesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Discharge> _filterDischarges(List<Discharge> discharges, String filter) {
    var filtered = discharges;

    if (filter == 'pending') {
      filtered = filtered
          .where((d) =>
              d.status != DischargeStatus.completed &&
              d.status != DischargeStatus.cancelled)
          .toList();
    } else if (filter == 'ready') {
      filtered = filtered
          .where((d) => d.status == DischargeStatus.readyForDischarge)
          .toList();
    } else if (filter == 'completed') {
      filtered =
          filtered.where((d) => d.status == DischargeStatus.completed).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((d) =>
              d.patientName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              d.dischargingDoctor
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final discharges = ref.watch(dischargesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: theme.dividerColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient Discharges',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Manage patient discharge workflow',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: () => _showDischargeForm(context),
                      icon: const Icon(Icons.add),
                      label: const Text('New Discharge'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Workflow Progress
                _buildWorkflowProgress(discharges, theme),
              ],
            ),
          ),
          // Search and Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search discharges...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
                const SizedBox(height: 16),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'In Progress'),
                    Tab(text: 'Ready'),
                    Tab(text: 'Completed'),
                  ],
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDischargesList(_filterDischarges(discharges, 'pending')),
                _buildDischargesList(_filterDischarges(discharges, 'ready')),
                _buildDischargesList(
                    _filterDischarges(discharges, 'completed')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowProgress(List<Discharge> discharges, ThemeData theme) {
    final pending = discharges
        .where((d) =>
            d.status != DischargeStatus.completed &&
            d.status != DischargeStatus.cancelled)
        .length;
    final ready = discharges
        .where((d) => d.status == DischargeStatus.readyForDischarge)
        .length;
    final completed =
        discharges.where((d) => d.status == DischargeStatus.completed).length;

    return Row(
      children: [
        Expanded(
            child: _buildWorkflowStep('Pending', pending, Colors.amber, theme)),
        Container(
          height: 2,
          width: 24,
          color: theme.dividerColor,
        ),
        Expanded(child: _buildWorkflowStep('Ready', ready, Colors.blue, theme)),
        Container(
          height: 2,
          width: 24,
          color: theme.dividerColor,
        ),
        Expanded(
            child: _buildWorkflowStep(
                'Completed', completed, Colors.green, theme)),
      ],
    );
  }

  Widget _buildWorkflowStep(
      String label, int count, Color color, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDischargesList(List<Discharge> discharges) {
    if (discharges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No discharges found',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: discharges.length,
      itemBuilder: (context, index) {
        return DischargeCard(
          discharge: discharges[index],
          onTap: () => _showDischargeDetails(discharges[index]),
        );
      },
    );
  }

  void _showDischargeForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DischargeFormDialog(
        onSubmit: (discharge) {
          ref.read(dischargesProvider.notifier).addDischarge(discharge);
        },
      ),
    );
  }

  void _showDischargeDetails(Discharge discharge) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DischargeDetailsSheet(discharge: discharge),
    );
  }
}

class DischargeDetailsSheet extends ConsumerWidget {
  final Discharge discharge;

  const DischargeDetailsSheet({super.key, required this.discharge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor:
                            theme.colorScheme.primary.withOpacity(0.1),
                        child: Text(
                          discharge.patientName.substring(0, 1),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              discharge.patientName,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ID: ${discharge.patientId}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Progress Indicator
                  _buildProgressIndicator(theme),
                  const SizedBox(height: 24),
                  // Checklist
                  _buildChecklist(context, ref, theme),
                  const SizedBox(height: 16),
                  // Discharge Summary
                  _buildSection(
                      'Discharge Summary', discharge.dischargeSummary, theme),
                  const SizedBox(height: 16),
                  // Medications
                  if (discharge.medications.isNotEmpty)
                    _buildListSection('Prescribed Medications',
                        discharge.medications, Icons.medication, theme),
                  const SizedBox(height: 16),
                  // Follow-up Instructions
                  if (discharge.followUpInstructions.isNotEmpty)
                    _buildListSection('Follow-up Instructions',
                        discharge.followUpInstructions, Icons.list_alt, theme),
                  const SizedBox(height: 24),
                  // Action Buttons
                  if (discharge.status != DischargeStatus.completed)
                    _buildActionButtons(context, ref, theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discharge Progress',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${discharge.completionPercentage.toInt()}%',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: discharge.completionPercentage / 100,
            minHeight: 8,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildChecklist(BuildContext context, WidgetRef ref, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discharge Checklist',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildChecklistItem(
            'Billing Cleared',
            discharge.billingCleared,
            () => ref.read(dischargesProvider.notifier).updateChecklistItem(
                  discharge.id,
                  'billing',
                  !discharge.billingCleared,
                ),
            theme,
          ),
          _buildChecklistItem(
            'Pharmacy Cleared',
            discharge.pharmacyCleared,
            () => ref.read(dischargesProvider.notifier).updateChecklistItem(
                  discharge.id,
                  'pharmacy',
                  !discharge.pharmacyCleared,
                ),
            theme,
          ),
          _buildChecklistItem(
            'Nursing Cleared',
            discharge.nursingCleared,
            () => ref.read(dischargesProvider.notifier).updateChecklistItem(
                  discharge.id,
                  'nursing',
                  !discharge.nursingCleared,
                ),
            theme,
          ),
          _buildChecklistItem(
            'Patient Education Completed',
            discharge.patientEducationCompleted,
            () => ref.read(dischargesProvider.notifier).updateChecklistItem(
                  discharge.id,
                  'education',
                  !discharge.patientEducationCompleted,
                ),
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(
      String label, bool checked, VoidCallback onTap, ThemeData theme) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: checked ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked ? Colors.green : theme.colorScheme.outline,
                  width: 2,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                decoration: checked ? TextDecoration.lineThrough : null,
                color: checked
                    ? theme.colorScheme.onSurface.withOpacity(0.5)
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(
      String title, List<String> items, IconData icon, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(item)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, WidgetRef ref, ThemeData theme) {
    final canComplete = discharge.billingCleared &&
        discharge.pharmacyCleared &&
        discharge.nursingCleared &&
        discharge.patientEducationCompleted;

    return Column(
      children: [
        if (!canComplete)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber, color: Colors.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Complete all checklist items before finalizing discharge',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: canComplete
                ? () {
                    ref.read(dischargesProvider.notifier).updateDischargeStatus(
                          discharge.id,
                          DischargeStatus.completed,
                        );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${discharge.patientName} has been discharged'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                : null,
            child: const Text('Complete Discharge'),
          ),
        ),
      ],
    );
  }
}
