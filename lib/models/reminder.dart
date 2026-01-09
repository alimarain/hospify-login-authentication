enum ReminderType { medication, vitals, task, followUp, handover }

enum ReminderStatus { pending, completed, snoozed, missed }

class Reminder {
  final String id;
  final ReminderType type;
  final String title;
  final String description;
  final String? patientId;
  final String? patientName;
  final String? roomNumber;
  final DateTime scheduledTime;
  final DateTime? completedAt;
  final ReminderStatus status;
  final int snoozeCount;
  final bool isRecurring;
  final Duration? recurringInterval;

  Reminder({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.patientId,
    this.patientName,
    this.roomNumber,
    required this.scheduledTime,
    this.completedAt,
    this.status = ReminderStatus.pending,
    this.snoozeCount = 0,
    this.isRecurring = false,
    this.recurringInterval,
  });

  Reminder copyWith({
    ReminderStatus? status,
    DateTime? completedAt,
    DateTime? scheduledTime,
    int? snoozeCount,
  }) {
    return Reminder(
      id: id,
      type: type,
      title: title,
      description: description,
      patientId: patientId,
      patientName: patientName,
      roomNumber: roomNumber,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      isRecurring: isRecurring,
      recurringInterval: recurringInterval,
    );
  }
}
