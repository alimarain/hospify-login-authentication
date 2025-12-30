import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/utils/responsive_utils.dart';
import '../providers/filter_provider.dart';

class AdvancedFilterDialog extends ConsumerWidget {
  const AdvancedFilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final notifier = ref.read(filterProvider.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: Responsive.isDesktop(context) ? 600 : double.infinity,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Advanced Filter',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // ✅ Status Checkboxes
              _buildSectionTitle('Status'),
              Wrap(
                spacing: 10,
                children: ['Active', 'Inactive', 'Pending']
                    .map(
                      (s) => FilterChip(
                        label: Text(s),
                        selected: filter.status.contains(s),
                        onSelected: (_) => notifier.toggleStatus(s),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),

              // ✅ Gender Checkboxes
              _buildSectionTitle('Gender'),
              Wrap(
                spacing: 10,
                children: ['Male', 'Female', 'Other']
                    .map(
                      (g) => FilterChip(
                        label: Text(g),
                        selected: filter.gender.contains(g),
                        onSelected: (_) => notifier.toggleGender(g),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),

              // ✅ Age Range
              _buildSectionTitle('Age Range'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Min Age',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: notifier.setAgeMin,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Max Age',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: notifier.setAgeMax,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ✅ Date Range
              _buildSectionTitle('Date Range'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText:
                            filter.dateFrom.isEmpty ? 'From' : filter.dateFrom,
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          notifier.setDateFrom(
                              "${date.year}-${date.month}-${date.day}");
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: filter.dateTo.isEmpty ? 'To' : filter.dateTo,
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          notifier.setDateTo(
                              "${date.year}-${date.month}-${date.day}");
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ✅ Diagnosis Tags
              _buildSectionTitle('Diagnosis'),
              Wrap(
                spacing: 10,
                children: ['Flu', 'Diabetes', 'Covid', 'Cancer']
                    .map(
                      (d) => FilterChip(
                        label: Text(d),
                        selected: filter.diagnosis.contains(d),
                        onSelected: (_) => notifier.toggleDiagnosis(d),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 24),

              // ✅ Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => notifier.clearAll(),
                    child: const Text('Clear All'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
