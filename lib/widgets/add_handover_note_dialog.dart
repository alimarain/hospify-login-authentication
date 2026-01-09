import 'package:flutter/material.dart';
import '../models/handover.dart';

class AddHandoverNoteDialog extends StatefulWidget {
  final Function(HandoverNote) onAdd;

  const AddHandoverNoteDialog({super.key, required this.onAdd});

  @override
  State<AddHandoverNoteDialog> createState() => _AddHandoverNoteDialogState();
}

class _AddHandoverNoteDialogState extends State<AddHandoverNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _roomController = TextEditingController();
  final _noteController = TextEditingController();
  HandoverPriority _selectedPriority = HandoverPriority.medium;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Handover Note'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _patientNameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(
                  labelText: 'Room Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<HandoverPriority>(
                value: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: HandoverPriority.values
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                              p.name[0].toUpperCase() + p.name.substring(1)),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedPriority = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
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
              final note = HandoverNote(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                patientId: 'p_${DateTime.now().millisecondsSinceEpoch}',
                patientName: _patientNameController.text,
                room: _roomController.text,
                note: _noteController.text,
                priority: _selectedPriority,
                authorId: 'current_user',
                authorName: 'Current User',
                createdAt: DateTime.now(),
              );
              widget.onAdd(note);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5E9)),
          child: const Text('Add Note', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
