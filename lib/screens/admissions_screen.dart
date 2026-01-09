import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/admission.dart';
import '../providers/admissions_provider.dart';
import '../widgets/admission_card.dart';
import '../widgets/admission_form_dialog.dart';

class AdmissionsScreen extends ConsumerStatefulWidget {
  const AdmissionsScreen({super.key});

  @override
  ConsumerState<AdmissionsScreen> createState() => _AdmissionsScreenState();
}

class _AdmissionsScreenState extends ConsumerState<AdmissionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Admission> _filterAdmissions(
      List<Admission> admissions, AdmissionStatus? status) {
    var filtered = admissions;

    if (status != null) {
      filtered = filtered.where((a) => a.status == status).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((a) =>
              a.patientName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              a.ward.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              a.admittingDoctor
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final admissions = ref.watch(admissionsProvider);
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
                          'Patient Admissions',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Manage patient admission workflow',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: () => _showAdmissionForm(context),
                      icon: const Icon(Icons.add),
                      label: const Text('New Admission'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Stats Row
                Row(
                  children: [
                    _buildStatChip(
                      'Pending',
                      admissions
                          .where((a) => a.status == AdmissionStatus.pending)
                          .length,
                      Colors.amber,
                    ),
                    const SizedBox(width: 12),
                    _buildStatChip(
                      'In Progress',
                      admissions
                          .where((a) => a.status == AdmissionStatus.inProgress)
                          .length,
                      Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    _buildStatChip(
                      'Completed',
                      admissions
                          .where((a) => a.status == AdmissionStatus.completed)
                          .length,
                      Colors.green,
                    ),
                  ],
                ),
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
                    hintText: 'Search admissions...',
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
                    Tab(text: 'All'),
                    Tab(text: 'Pending'),
                    Tab(text: 'In Progress'),
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
                _buildAdmissionsList(_filterAdmissions(admissions, null)),
                _buildAdmissionsList(
                    _filterAdmissions(admissions, AdmissionStatus.pending)),
                _buildAdmissionsList(
                    _filterAdmissions(admissions, AdmissionStatus.inProgress)),
                _buildAdmissionsList(
                    _filterAdmissions(admissions, AdmissionStatus.completed)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$label: $count',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionsList(List<Admission> admissions) {
    if (admissions.isEmpty) {
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
              'No admissions found',
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
      itemCount: admissions.length,
      itemBuilder: (context, index) {
        return AdmissionCard(
          admission: admissions[index],
          onStatusChange: (status) {
            ref.read(admissionsProvider.notifier).updateAdmissionStatus(
                  admissions[index].id,
                  status,
                );
          },
          onTap: () => _showAdmissionDetails(admissions[index]),
        );
      },
    );
  }

  void _showAdmissionForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AdmissionFormDialog(
        onSubmit: (admission) {
          ref.read(admissionsProvider.notifier).addAdmission(admission);
        },
      ),
    );
  }

  void _showAdmissionDetails(Admission admission) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdmissionDetailsSheet(admission: admission),
    );
  }
}

class AdmissionDetailsSheet extends ConsumerWidget {
  final Admission admission;

  const AdmissionDetailsSheet({super.key, required this.admission});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor:
                            theme.colorScheme.primary.withOpacity(0.1),
                        child: Text(
                          admission.patientName.substring(0, 1),
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
                              admission.patientName,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ID: ${admission.patientId}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(admission.status, theme),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildInfoSection(
                      'Admission Details',
                      [
                        _buildInfoRow(
                            'Type', admission.type.name.toUpperCase(), theme),
                        _buildInfoRow(
                            'Date',
                            DateFormat('MMM dd, yyyy HH:mm')
                                .format(admission.admissionDate),
                            theme),
                        _buildInfoRow('Ward', admission.ward, theme),
                        _buildInfoRow('Room/Bed',
                            '${admission.room} / ${admission.bed}', theme),
                        _buildInfoRow(
                            'Doctor', admission.admittingDoctor, theme),
                      ],
                      theme),
                  const SizedBox(height: 16),
                  _buildInfoSection(
                      'Medical Information',
                      [
                        _buildInfoRow('Diagnosis', admission.diagnosis, theme),
                        if (admission.notes.isNotEmpty)
                          _buildInfoRow('Notes', admission.notes, theme),
                      ],
                      theme),
                  const SizedBox(height: 16),
                  _buildChecklistSection(theme),
                  if (admission.requiredTests.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildTestsSection(theme),
                  ],
                  const SizedBox(height: 24),
                  if (admission.status != AdmissionStatus.completed)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          final nextStatus =
                              admission.status == AdmissionStatus.pending
                                  ? AdmissionStatus.inProgress
                                  : AdmissionStatus.completed;
                          ref
                              .read(admissionsProvider.notifier)
                              .updateAdmissionStatus(
                                admission.id,
                                nextStatus,
                              );
                          Navigator.pop(context);
                        },
                        child: Text(
                          admission.status == AdmissionStatus.pending
                              ? 'Start Admission Process'
                              : 'Complete Admission',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(AdmissionStatus status, ThemeData theme) {
    final colors = {
      AdmissionStatus.pending: Colors.amber,
      AdmissionStatus.inProgress: Colors.blue,
      AdmissionStatus.completed: Colors.green,
      AdmissionStatus.cancelled: Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors[status]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors[status]!.withOpacity(0.3)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: colors[status],
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInfoSection(
      String title, List<Widget> children, ThemeData theme) {
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
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistSection(ThemeData theme) {
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
            'Admission Checklist',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildChecklistItem(
              'Insurance Verified', admission.insuranceVerified, theme),
          _buildChecklistItem('Consent Signed', admission.consentSigned, theme),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String label, bool checked, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle : Icons.circle_outlined,
            size: 20,
            color: checked
                ? Colors.green
                : theme.colorScheme.onSurface.withOpacity(0.4),
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
    );
  }

  Widget _buildTestsSection(ThemeData theme) {
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
            'Required Tests',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: admission.requiredTests
                .map((test) => Chip(
                      label: Text(test),
                      backgroundColor:
                          theme.colorScheme.primary.withOpacity(0.1),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
