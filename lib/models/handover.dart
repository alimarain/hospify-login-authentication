enum HandoverPriority { low, medium, high, critical }

enum HandoverStatus { pending, acknowledged, completed }

class HandoverNote {
  final String id;
  final String patientId;
  final String patientName;
  final String room;
  final String note;
  final HandoverPriority priority;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final bool isAcknowledged;

  HandoverNote({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.room,
    required this.note,
    required this.priority,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    this.isAcknowledged = false,
  });

  HandoverNote copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? room,
    String? note,
    HandoverPriority? priority,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    bool? isAcknowledged,
  }) {
    return HandoverNote(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      room: room ?? this.room,
      note: note ?? this.note,
      priority: priority ?? this.priority,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      isAcknowledged: isAcknowledged ?? this.isAcknowledged,
    );
  }

  String get priorityLabel {
    switch (priority) {
      case HandoverPriority.low:
        return 'Low';
      case HandoverPriority.medium:
        return 'Medium';
      case HandoverPriority.high:
        return 'High';
      case HandoverPriority.critical:
        return 'Critical';
    }
  }
}

class ShiftHandover {
  final String id;
  final String outgoingStaffId;
  final String outgoingStaffName;
  final String? incomingStaffId;
  final String? incomingStaffName;
  final DateTime shiftDate;
  final String shiftType;
  final List<HandoverNote> notes;
  final HandoverStatus status;
  final DateTime createdAt;
  final DateTime? acknowledgedAt;

  ShiftHandover({
    required this.id,
    required this.outgoingStaffId,
    required this.outgoingStaffName,
    this.incomingStaffId,
    this.incomingStaffName,
    required this.shiftDate,
    required this.shiftType,
    required this.notes,
    this.status = HandoverStatus.pending,
    required this.createdAt,
    this.acknowledgedAt,
  });

  ShiftHandover copyWith({
    String? id,
    String? outgoingStaffId,
    String? outgoingStaffName,
    String? incomingStaffId,
    String? incomingStaffName,
    DateTime? shiftDate,
    String? shiftType,
    List<HandoverNote>? notes,
    HandoverStatus? status,
    DateTime? createdAt,
    DateTime? acknowledgedAt,
  }) {
    return ShiftHandover(
      id: id ?? this.id,
      outgoingStaffId: outgoingStaffId ?? this.outgoingStaffId,
      outgoingStaffName: outgoingStaffName ?? this.outgoingStaffName,
      incomingStaffId: incomingStaffId ?? this.incomingStaffId,
      incomingStaffName: incomingStaffName ?? this.incomingStaffName,
      shiftDate: shiftDate ?? this.shiftDate,
      shiftType: shiftType ?? this.shiftType,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
    );
  }
}
