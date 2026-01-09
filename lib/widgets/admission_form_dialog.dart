import 'package:flutter/material.dart';
import '../models/admission.dart';

class AdmissionFormDialog extends StatefulWidget {
  final Function(Admission) onSubmit;

  const AdmissionFormDialog({super.key, required this.onSubmit});

  @override
  State<AdmissionFormDialog> createState() => _AdmissionFormDialogState();
}

class _AdmissionFormDialogState extends State<AdmissionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _notesController = TextEditingController();
  final _roomController = TextEditingController();
  final _bedController = TextEditingController();

  AdmissionType _selectedType = AdmissionType.scheduled;
  String _selectedWard = 'General';
  String _selectedDoctor = 'Dr. Sarah Wilson';
  DateTime _admissionDate = DateTime.now();
  bool _insuranceVerified = false;
  bool _consentSigned = false;
  final List<String> _selectedTests = [];

  final List<String> _wards = [
    'General',
    'ICU',
    'Cardiology',
    'Orthopedics',
    'Pediatrics',
    'Neurology'
  ];
  final List<String> _doctors = [
    'Dr. Sarah Wilson',
    'Dr. Michael Chen',
    'Dr. Emily Brown',
    'Dr. James Lee'
  ];
  final List<String> _availableTests = [
    'CBC',
    'ECG',
    'X-Ray',
    'MRI',
    'CT Scan',
    'Blood Type',
    'Urinalysis'
  ];

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientIdController.dispose();
    _diagnosisController.dispose();
    _notesController.dispose();
    _roomController.dispose();
    _bedController.dispose();
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
                  Icon(Icons.person_add, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Text(
                    'New Patient Admission',
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
                      // Patient Information Section
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
                      const SizedBox(height: 24),
                      // Admission Details Section
                      _buildSectionTitle('Admission Details', theme),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<AdmissionType>(
                              value: _selectedType,
                              decoration: const InputDecoration(
                                labelText: 'Admission Type',
                                prefixIcon: Icon(Icons.category),
                              ),
                              items: AdmissionType.values.map((type) {
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
                              value: _selectedWard,
                              decoration: const InputDecoration(
                                labelText: 'Ward',
                                prefixIcon: Icon(Icons.local_hospital),
                              ),
                              items: _wards.map((ward) {
                                return DropdownMenuItem(
                                  value: ward,
                                  child: Text(ward),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedWard = value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _roomController,
                              decoration: const InputDecoration(
                                labelText: 'Room *',
                                prefixIcon: Icon(Icons.room),
                              ),
                              validator: (value) =>
                                  value?.isEmpty ?? true ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _bedController,
                              decoration: const InputDecoration(
                                labelText: 'Bed *',
                                prefixIcon: Icon(Icons.bed),
                              ),
                              validator: (value) =>
                                  value?.isEmpty ?? true ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedDoctor,
                        decoration: const InputDecoration(
                          labelText: 'Admitting Doctor',
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
                      const SizedBox(height: 24),
                      // Medical Information Section
                      _buildSectionTitle('Medical Information', theme),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _diagnosisController,
                        decoration: const InputDecoration(
                          labelText: 'Diagnosis *',
                          prefixIcon: Icon(Icons.medical_information),
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          prefixIcon: Icon(Icons.notes),
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Required Tests',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableTests.map((test) {
                          final isSelected = _selectedTests.contains(test);
                          return FilterChip(
                            label: Text(test),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedTests.add(test);
                                } else {
                                  _selectedTests.remove(test);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Checklist Section
                      _buildSectionTitle('Admission Checklist', theme),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        value: _insuranceVerified,
                        onChanged: (value) {
                          setState(() => _insuranceVerified = value!);
                        },
                        title: const Text('Insurance Verified'),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      CheckboxListTile(
                        value: _consentSigned,
                        onChanged: (value) {
                          setState(() => _consentSigned = value!);
                        },
                        title: const Text('Consent Form Signed'),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
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
                    child: const Text('Create Admission'),
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
      final admission = Admission(
        id: 'ADM${DateTime.now().millisecondsSinceEpoch}',
        patientId: _patientIdController.text,
        patientName: _patientNameController.text,
        type: _selectedType,
        status: AdmissionStatus.pending,
        admissionDate: _admissionDate,
        ward: _selectedWard,
        room: _roomController.text,
        bed: _bedController.text,
        admittingDoctor: _selectedDoctor,
        diagnosis: _diagnosisController.text,
        notes: _notesController.text,
        requiredTests: _selectedTests,
        insuranceVerified: _insuranceVerified,
        consentSigned: _consentSigned,
        createdAt: DateTime.now(),
      );

      widget.onSubmit(admission);
      Navigator.pop(context);
    }
  }
}
