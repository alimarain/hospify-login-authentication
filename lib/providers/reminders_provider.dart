// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/reminder.dart';
// import '../services/notification_service.dart';

// class RemindersNotifier extends StateNotifier<List<Reminder>> {
//   RemindersNotifier() : super([]) {
//     _loadSampleReminders();
//   }

//   void _loadSampleReminders() {
//     state = [
//       Reminder(
//         id: '1',
//         type: ReminderType.medication,
//         title: 'Administer Pain Medication',
//         description: 'Give Morphine 5mg IV to patient',
//         patientId: 'P001',
//         patientName: 'John Smith',
//         roomNumber: '101A',
//         scheduledTime: DateTime.now().add(const Duration(minutes: 15)),
//       ),
//       Reminder(
//         id: '2',
//         type: ReminderType.vitals,
//         title: 'Check Blood Pressure',
//         description: 'Hourly BP monitoring required',
//         patientId: 'P002',
//         patientName: 'Sarah Johnson',
//         roomNumber: '105B',
//         scheduledTime: DateTime.now().add(const Duration(minutes: 30)),
//         isRecurring: true,
//         recurringInterval: const Duration(hours: 1),
//       ),
//       Reminder(
//         id: '3',
//         type: ReminderType.task,
//         title: 'IV Line Check',
//         description: 'Inspect and flush IV line',
//         patientId: 'P003',
//         patientName: 'Michael Brown',
//         roomNumber: '203A',
//         scheduledTime: DateTime.now().add(const Duration(hours: 1)),
//       ),
//       Reminder(
//         id: '4',
//         type: ReminderType.followUp,
//         title: 'Post-Surgery Assessment',
//         description: 'Check surgical site and mobility',
//         patientId: 'P004',
//         patientName: 'Emily Davis',
//         roomNumber: '110C',
//         scheduledTime: DateTime.now().add(const Duration(hours: 2)),
//       ),
//       Reminder(
//         id: '5',
//         type: ReminderType.handover,
//         title: 'Prepare Shift Handover',
//         description: 'Document all patient updates for incoming shift',
//         scheduledTime: DateTime.now().add(const Duration(hours: 3)),
//       ),
//     ];
//   }

//   void completeReminder(String id) {
//     state = state.map((reminder) {
//       if (reminder.id == id) {
//         return reminder.copyWith(
//           status: ReminderStatus.completed,
//           completedAt: DateTime.now(),
//         );
//       }
//       return reminder;
//     }).toList();
//   }

//   void snoozeReminder(String id, Duration duration) {
//     state = state.map((reminder) {
//       if (reminder.id == id) {
//         return reminder.copyWith(
//           status: ReminderStatus.snoozed,
//           scheduledTime: DateTime.now().add(duration),
//           snoozeCount: reminder.snoozeCount + 1,
//         );
//       }
//       return reminder;
//     }).toList();
//   }

//   void addReminder(Reminder reminder) {
//     state = [reminder, ...state];
//     NotificationService().scheduleNotification(
//       id: reminder.id.hashCode,
//       title: reminder.title,
//       body: reminder.description,
//       scheduledTime: reminder.scheduledTime,
//       payload: reminder.id,
//     );
//   }

//   void deleteReminder(String id) {
//     state = state.where((r) => r.id != id).toList();
//   }
// }

// final remindersProvider =
//     StateNotifierProvider<RemindersNotifier, List<Reminder>>((ref) {
//   return RemindersNotifier();
// });

// final pendingRemindersProvider = Provider<List<Reminder>>((ref) {
//   final reminders = ref.watch(remindersProvider);
//   return reminders
//       .where((r) =>
//           r.status == ReminderStatus.pending ||
//           r.status == ReminderStatus.snoozed)
//       .toList()
//     ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
// });

// final upcomingRemindersCountProvider = Provider<int>((ref) {
//   final reminders = ref.watch(pendingRemindersProvider);
//   final now = DateTime.now();
//   return reminders
//       .where((r) => r.scheduledTime.difference(now).inMinutes <= 30)
//       .length;
// });
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reminder.dart';
import '../models/app_notification.dart';
import '../services/notification_service.dart';

class RemindersNotifier extends StateNotifier<List<Reminder>> {
  RemindersNotifier() : super([]) {
    _loadSampleReminders();
  }

  void _loadSampleReminders() {
    state = [
      Reminder(
        id: '1',
        type: ReminderType.medication,
        title: 'Administer Pain Medication',
        description: 'Give Morphine 5mg IV to patient',
        patientId: 'P001',
        patientName: 'John Smith',
        roomNumber: '101A',
        scheduledTime: DateTime.now().add(const Duration(minutes: 15)),
      ),
      Reminder(
        id: '2',
        type: ReminderType.vitals,
        title: 'Check Blood Pressure',
        description: 'Hourly BP monitoring required',
        patientId: 'P002',
        patientName: 'Sarah Johnson',
        roomNumber: '105B',
        scheduledTime: DateTime.now().add(const Duration(minutes: 30)),
        isRecurring: true,
        recurringInterval: const Duration(hours: 1),
      ),
      Reminder(
        id: '3',
        type: ReminderType.task,
        title: 'IV Line Check',
        description: 'Inspect and flush IV line',
        patientId: 'P003',
        patientName: 'Michael Brown',
        roomNumber: '203A',
        scheduledTime: DateTime.now().add(const Duration(hours: 1)),
      ),
      Reminder(
        id: '4',
        type: ReminderType.followUp,
        title: 'Post-Surgery Assessment',
        description: 'Check surgical site and mobility',
        patientId: 'P004',
        patientName: 'Emily Davis',
        roomNumber: '110C',
        scheduledTime: DateTime.now().add(const Duration(hours: 2)),
      ),
      Reminder(
        id: '5',
        type: ReminderType.handover,
        title: 'Prepare Shift Handover',
        description: 'Document all patient updates for incoming shift',
        scheduledTime: DateTime.now().add(const Duration(hours: 3)),
      ),
    ];
  }

  void completeReminder(String id) {
    state = state.map((reminder) {
      if (reminder.id == id) {
        return reminder.copyWith(
          status: ReminderStatus.completed,
          completedAt: DateTime.now(),
        );
      }
      return reminder;
    }).toList();
  }

  void snoozeReminder(String id, Duration duration) {
    state = state.map((reminder) {
      if (reminder.id == id) {
        return reminder.copyWith(
          status: ReminderStatus.snoozed,
          scheduledTime: DateTime.now().add(duration),
          snoozeCount: reminder.snoozeCount + 1,
        );
      }
      return reminder;
    }).toList();
  }

  void addReminder(Reminder reminder) {
    state = [reminder, ...state];

    // ✅ Create AppNotification for Reminder
    final notification = AppNotification(
      id: reminder.id,
      title: reminder.title,
      body: reminder.description,
      type: NotificationType.task, // map from ReminderType if needed
      priority: NotificationPriority.medium,
      timestamp: reminder.scheduledTime,
      actionRoute: '', // optional navigation
    );

    NotificationService()
        .scheduleNotification(notification, reminder.scheduledTime);
  }

  void deleteReminder(String id) {
    state = state.where((r) => r.id != id).toList();
  }
}

final remindersProvider =
    StateNotifierProvider<RemindersNotifier, List<Reminder>>((ref) {
  return RemindersNotifier();
});

final pendingRemindersProvider = Provider<List<Reminder>>((ref) {
  final reminders = ref.watch(remindersProvider);
  return reminders
      .where((r) =>
          r.status == ReminderStatus.pending ||
          r.status == ReminderStatus.snoozed)
      .toList()
    ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
});

final upcomingRemindersCountProvider = Provider<int>((ref) {
  final reminders = ref.watch(pendingRemindersProvider);
  final now = DateTime.now();
  return reminders
      .where((r) => r.scheduledTime.difference(now).inMinutes <= 30)
      .length;
});
