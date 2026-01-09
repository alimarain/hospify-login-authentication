import 'package:flutter/material.dart';
import '../models/shift.dart';

class AddShiftDialog extends StatefulWidget {
  final DateTime selectedDate;
  final Function(Shift) onAdd;

  const AddShiftDialog({
    super.key,
    required this.selectedDate,
    required this.onAdd,
  });

  @override
  State<AddShiftDialog> createState() => _AddShiftDialogState();
}

class _AddShiftDialogState extends State<AddShiftDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedRole = 'Nurse';
  String _selectedDepartment = 'ICU';
  ShiftType _selectedShiftType = ShiftType.morning;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Shift'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Staff Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: ['Nurse', 'Doctor', 'Technician']
                    .map((role) =>
                        DropdownMenuItem(value: role, child: Text(role)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedRole = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDepartment,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'ICU',
                  'Emergency',
                  'Cardiology',
                  'Pediatrics',
                  'Surgery'
                ]
                    .map((dept) =>
                        DropdownMenuItem(value: dept, child: Text(dept)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedDepartment = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ShiftType>(
                value: _selectedShiftType,
                decoration: const InputDecoration(
                  labelText: 'Shift Type',
                  border: OutlineInputBorder(),
                ),
                items: ShiftType.values
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.name[0].toUpperCase() +
                              type.name.substring(1)),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedShiftType = value!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final shift = Shift(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                staffId: 'staff_${DateTime.now().millisecondsSinceEpoch}',
                staffName: _nameController.text,
                role: _selectedRole,
                department: _selectedDepartment,
                date: widget.selectedDate,
                type: _selectedShiftType,
                startTime: _getStartTime(_selectedShiftType),
                endTime: _getEndTime(_selectedShiftType),
              );
              widget.onAdd(shift);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5E9)),
          child: const Text('Add Shift', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  TimeOfDay _getStartTime(ShiftType type) {
    switch (type) {
      case ShiftType.morning:
        return const TimeOfDay(hour: 6, minute: 0);
      case ShiftType.afternoon:
        return const TimeOfDay(hour: 14, minute: 0);
      case ShiftType.night:
        return const TimeOfDay(hour: 22, minute: 0);
    }
  }

  TimeOfDay _getEndTime(ShiftType type) {
    switch (type) {
      case ShiftType.morning:
        return const TimeOfDay(hour: 14, minute: 0);
      case ShiftType.afternoon:
        return const TimeOfDay(hour: 22, minute: 0);
      case ShiftType.night:
        return const TimeOfDay(hour: 6, minute: 0);
    }
  }
}
