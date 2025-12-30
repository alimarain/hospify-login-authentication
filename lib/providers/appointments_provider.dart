import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment_model.dart';

final appointmentsProvider =
    StateNotifierProvider<AppointmentsNotifier, List<Appointment>>(
  (ref) => AppointmentsNotifier(),
);

class AppointmentsNotifier extends StateNotifier<List<Appointment>> {
  AppointmentsNotifier()
      : super([
          Appointment(
            id: '1',
            patientName: 'Ali Muhammad',
            type: 'Consultation',
            dateTime: DateTime.now().add(const Duration(hours: 2)),
            status: 'Pending',
          ),
          Appointment(
            id: '2',
            patientName: 'Sara Khan',
            type: 'Surgery',
            dateTime: DateTime.now().add(const Duration(days: 1)),
            status: 'Completed',
          ),
          Appointment(
            id: '3',
            patientName: 'Ahmed Ali',
            type: 'Checkup',
            dateTime: DateTime.now().add(const Duration(days: 2)),
            status: 'Cancelled',
          ),
        ]);

  void updateStatus(String id, String newStatus) {
    state = [
      for (final a in state)
        if (a.id == id)
          Appointment(
            id: a.id,
            patientName: a.patientName,
            type: a.type,
            dateTime: a.dateTime,
            status: newStatus,
          )
        else
          a
    ];
  }

  void addAppointment(Appointment appointment) {
    state = [...state, appointment];
  }

  void removeAppointment(String id) {
    state = state.where((a) => a.id != id).toList();
  }
}
