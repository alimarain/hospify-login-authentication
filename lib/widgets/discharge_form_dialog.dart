import 'package:flutter/material.dart';
import '../models/discharge.dart';

class DischargeFormDialog extends StatefulWidget {
  final Function(Discharge) onSubmit;

  const DischargeFormDialog({super.key, required this.onSubmit});

  @override
  State<DischargeFormDialog> createState() => _DischargeFormDialogState();
}

class _DischargeFormDialogState extends State<DischargeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _admissionIdController = TextEditingController();
  final _summaryController = TextEditingController();
  final _medicationController = TextEditingController();
  final _instructionController = TextEditingController();

  DischargeType _selectedType = DischargeType.normal;
  String _selectedDoctor = 'Dr. Sarah Wilson';
  DateTime _plannedDate = DateTime.now().add(const Duration(days: 1));
  final List<String> _medications = [];
  final List<String> _instructions = [];

  final List<String> _doctors = [
    'Dr. Sarah Wilson',
    'Dr. Michael Chen',
    'Dr. Emily Brown',
    'Dr. James Lee'
  ];

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientIdController.dispose();
    _admissionIdController.dispose();
    _summaryController.dispose();
    _medicationController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.05),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Text(
                    'Initiate Patient Discharge',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            // Form
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient Information
                      _buildSectionTitle('Patient Information', theme),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _patientNameController,
                              decoration: const InputDecoration(
                                labelText: 'Patient Name *',
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) =>
                                  value?.isEmpty ?? true ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _patientIdController,
                              decoration: const InputDecoration(
                                labelText: 'Patient ID *',
                                prefixIcon: Icon(Icons.badge),
                              ),
                              validator: (value) =>
                                  value?.isEmpty ?? true ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _admissionIdController,
                        decoration: const InputDecoration(
                          labelText: 'Admission ID *',
                          prefixIcon: Icon(Icons.assignment),
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),
                      // Discharge Details
                      _buildSectionTitle('Discharge Details', theme),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<DischargeType>(
                              value: _selectedType,
                              decoration: const InputDecoration(
                                labelText: 'Discharge Type',
                                prefixIcon: Icon(Icons.category),
                              ),
                              items: DischargeType.values.map((type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Text(type.name.toUpperCase()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedType = value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedDoctor,
                              decoration: const InputDecoration(
                                labelText: 'Discharging Doctor',
                                prefixIcon: Icon(Icons.medical_services),
                              ),
                              items: _doctors.map((doctor) {
                                return DropdownMenuItem(
                                  value: doctor,
                                  child: Text(doctor),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedDoctor = value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _summaryController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Discharge Summary *',
                          prefixIcon: Icon(Icons.description),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),
                      // Medications
                      _buildSectionTitle('Medications', theme),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _medicationController,
                              decoration: const InputDecoration(
                                labelText: 'Add Medication',
                                prefixIcon: Icon(Icons.medication),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton.filled(
                            onPressed: () {
                              if (_medicationController.text.isNotEmpty) {
                                setState(() {
                                  _medications.add(_medicationController.text);
                                  _medicationController.clear();
                                });
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      if (_medications.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _medications
                              .map((med) => Chip(
                                    label: Text(med),
                                    onDeleted: () {
                                      setState(() => _medications.remove(med));
                                    },
                                  ))
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: 24),
                      // Follow-up Instructions
                      _buildSectionTitle('Follow-up Instructions', theme),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _instructionController,
                              decoration: const InputDecoration(
                                labelText: 'Add Instruction',
                                prefixIcon: Icon(Icons.list_alt),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton.filled(
                            onPressed: () {
                              if (_instructionController.text.isNotEmpty) {
                                setState(() {
                                  _instructions
                                      .add(_instructionController.text);
                                  _instructionController.clear();
                                });
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      if (_instructions.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ...List.generate(
                            _instructions.length,
                            (index) => ListTile(
                                  leading: CircleAvatar(
                                    radius: 12,
                                    child: Text('${index + 1}',
                                        style: const TextStyle(fontSize: 12)),
                                  ),
                                  title: Text(_instructions[index]),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.close, size: 18),
                                    onPressed: () {
                                      setState(
                                          () => _instructions.removeAt(index));
                                    },
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                )),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            // Actions
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: theme.dividerColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _submitForm,
                    child: const Text('Initiate Discharge'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final discharge = Discharge(
        id: 'DIS${DateTime.now().millisecondsSinceEpoch}',
        patientId: _patientIdController.text,
        patientName: _patientNameController.text,
        admissionId: _admissionIdController.text,
        type: _selectedType,
        status: DischargeStatus.pending,
        plannedDischargeDate: _plannedDate,
        dischargingDoctor: _selectedDoctor,
        dischargeSummary: _summaryController.text,
        medications: List.from(_medications),
        followUpInstructions: List.from(_instructions),
        createdAt: DateTime.now(),
      );

      widget.onSubmit(discharge);
      Navigator.pop(context);
    }
  }
}
