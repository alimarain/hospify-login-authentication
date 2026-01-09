import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shift.dart';

class ShiftsNotifier extends StateNotifier<List<Shift>> {
  ShiftsNotifier() : super(_generateSampleShifts());

  static List<Shift> _generateSampleShifts() {
    final now = DateTime.now();
    return [
      Shift(
        id: '1',
        staffId: 'nurse1',
        staffName: 'Sarah Johnson',
        role: 'Nurse',
        department: 'ICU',
        date: now,
        type: ShiftType.morning,
        startTime: const TimeOfDay(hour: 6, minute: 0),
        endTime: const TimeOfDay(hour: 14, minute: 0),
        status: ShiftStatus.inProgress,
      ),
      Shift(
        id: '2',
        staffId: 'nurse2',
        staffName: 'Emily Davis',
        role: 'Nurse',
        department: 'Emergency',
        date: now,
        type: ShiftType.afternoon,
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        status: ShiftStatus.scheduled,
      ),
      Shift(
        id: '3',
        staffId: 'doc1',
        staffName: 'Dr. Michael Chen',
        role: 'Doctor',
        department: 'Cardiology',
        date: now,
        type: ShiftType.morning,
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 16, minute: 0),
        status: ShiftStatus.inProgress,
      ),
      Shift(
        id: '4',
        staffId: 'nurse3',
        staffName: 'James Wilson',
        role: 'Nurse',
        department: 'Pediatrics',
        date: now,
        type: ShiftType.night,
        startTime: const TimeOfDay(hour: 22, minute: 0),
        endTime: const TimeOfDay(hour: 6, minute: 0),
        status: ShiftStatus.scheduled,
      ),
      Shift(
        id: '5',
        staffId: 'doc2',
        staffName: 'Dr. Lisa Anderson',
        role: 'Doctor',
        department: 'Surgery',
        date: now.add(const Duration(days: 1)),
        type: ShiftType.morning,
        startTime: const TimeOfDay(hour: 7, minute: 0),
        endTime: const TimeOfDay(hour: 15, minute: 0),
        status: ShiftStatus.scheduled,
      ),
      Shift(
        id: '6',
        staffId: 'nurse4',
        staffName: 'Maria Garcia',
        role: 'Nurse',
        department: 'ICU',
        date: now.add(const Duration(days: 1)),
        type: ShiftType.afternoon,
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        status: ShiftStatus.scheduled,
      ),
      Shift(
        id: '7',
        staffId: 'doc3',
        staffName: 'Dr. Robert Kim',
        role: 'Doctor',
        department: 'Emergency',
        date: now.add(const Duration(days: 2)),
        type: ShiftType.night,
        startTime: const TimeOfDay(hour: 22, minute: 0),
        endTime: const TimeOfDay(hour: 6, minute: 0),
        status: ShiftStatus.scheduled,
      ),
    ];
  }

  void addShift(Shift shift) {
    state = [...state, shift];
  }

  void updateShift(Shift updatedShift) {
    state = state.map((s) => s.id == updatedShift.id ? updatedShift : s).toList();
  }

  void deleteShift(String shiftId) {
    state = state.where((s) => s.id != shiftId).toList();
  }

  List<Shift> getShiftsForDate(DateTime date) {
    return state.where((s) =>
      s.date.year == date.year &&
      s.date.month == date.month &&
      s.date.day == date.day
    ).toList();
  }

  List<Shift> getShiftsForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return state.where((s) =>
      s.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
      s.date.isBefore(weekEnd)
    ).toList();
  }
}

final shiftsProvider = StateNotifierProvider<ShiftsNotifier, List<Shift>>((ref) {
  return ShiftsNotifier();
});

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final shiftsForSelectedDateProvider = Provider<List<Shift>>((ref) {
  final shifts = ref.watch(shiftsProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  return shifts.where((s) =>
    s.date.year == selectedDate.year &&
    s.date.month == selectedDate.month &&
    s.date.day == selectedDate.day
  ).toList();
});
