import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment.dart';

class AppointmentsNotifier extends StateNotifier<List<Appointment>> {
  AppointmentsNotifier() : super(_initialAppointments);

  static final List<Appointment> _initialAppointments = [
    Appointment(
      id: '1',
      patientId: 'P001',
      patientName: 'John Smith',
      doctorId: 'D001',
      doctorName: 'Dr. Sarah Johnson',
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      type: 'General Checkup',
      status: AppointmentStatus.scheduled,
      room: 'Room 101',
    ),
    Appointment(
      id: '2',
      patientId: 'P002',
      patientName: 'Emily Davis',
      doctorId: 'D002',
      doctorName: 'Dr. Michael Chen',
      dateTime: DateTime.now().add(const Duration(hours: 4)),
      type: 'Follow-up',
      status: AppointmentStatus.scheduled,
      room: 'Room 203',
    ),
    Appointment(
      id: '3',
      patientId: 'P003',
      patientName: 'Robert Wilson',
      doctorId: 'D001',
      doctorName: 'Dr. Sarah Johnson',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      type: 'Lab Results Review',
      status: AppointmentStatus.completed,
      room: 'Room 101',
    ),
    Appointment(
      id: '4',
      patientId: 'P004',
      patientName: 'Maria Garcia',
      doctorId: 'D003',
      doctorName: 'Dr. Lisa Park',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      type: 'Consultation',
      status: AppointmentStatus.scheduled,
      room: 'Room 305',
    ),
    Appointment(
      id: '5',
      patientId: 'P005',
      patientName: 'James Brown',
      doctorId: 'D002',
      doctorName: 'Dr. Michael Chen',
      dateTime: DateTime.now(),
      type: 'Emergency',
      status: AppointmentStatus.inProgress,
      room: 'ER-1',
    ),
  ];

  void updateStatus(String id, AppointmentStatus status) {
    state = state.map((apt) {
      if (apt.id == id) {
        return apt.copyWith(status: status);
      }
      return apt;
    }).toList();
  }

  void addAppointment(Appointment appointment) {
    state = [...state, appointment];
  }

  void cancelAppointment(String id) {
    updateStatus(id, AppointmentStatus.cancelled);
  }
}

final appointmentsProvider =
    StateNotifierProvider<AppointmentsNotifier, List<Appointment>>((ref) {
  return AppointmentsNotifier();
});

final todayAppointmentsProvider = Provider<List<Appointment>>((ref) {
  final appointments = ref.watch(appointmentsProvider);
  final now = DateTime.now();
  return appointments.where((apt) {
    return apt.dateTime.year == now.year &&
        apt.dateTime.month == now.month &&
        apt.dateTime.day == now.day;
  }).toList()
    ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
});

final upcomingAppointmentsProvider = Provider<List<Appointment>>((ref) {
  final appointments = ref.watch(appointmentsProvider);
  return appointments
      .where((apt) =>
          apt.status == AppointmentStatus.scheduled &&
          apt.dateTime.isAfter(DateTime.now()))
      .toList()
    ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
});
