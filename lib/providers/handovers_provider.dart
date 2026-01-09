import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/handover.dart';

class HandoversNotifier extends StateNotifier<List<ShiftHandover>> {
  HandoversNotifier() : super(_generateSampleHandovers());

  static List<ShiftHandover> _generateSampleHandovers() {
    final now = DateTime.now();
    return [
      ShiftHandover(
        id: '1',
        outgoingStaffId: 'nurse1',
        outgoingStaffName: 'Sarah Johnson',
        incomingStaffId: 'nurse2',
        incomingStaffName: 'Emily Davis',
        shiftDate: now,
        shiftType: 'Morning → Afternoon',
        notes: [
          HandoverNote(
            id: 'n1',
            patientId: 'p1',
            patientName: 'John Smith',
            room: '101A',
            note: 'Patient reported chest discomfort at 10 AM. ECG performed, results normal. Continue monitoring.',
            priority: HandoverPriority.high,
            authorId: 'nurse1',
            authorName: 'Sarah Johnson',
            createdAt: now.subtract(const Duration(hours: 2)),
          ),
          HandoverNote(
            id: 'n2',
            patientId: 'p2',
            patientName: 'Mary Johnson',
            room: '102B',
            note: 'Post-surgery recovery progressing well. Pain medication administered at 11 AM.',
            priority: HandoverPriority.medium,
            authorId: 'nurse1',
            authorName: 'Sarah Johnson',
            createdAt: now.subtract(const Duration(hours: 1)),
          ),
          HandoverNote(
            id: 'n3',
            patientId: 'p3',
            patientName: 'Robert Williams',
            room: '105A',
            note: 'Blood sugar levels stable. Insulin dosage adjusted per physician orders.',
            priority: HandoverPriority.low,
            authorId: 'nurse1',
            authorName: 'Sarah Johnson',
            createdAt: now.subtract(const Duration(minutes: 30)),
          ),
        ],
        status: HandoverStatus.pending,
        createdAt: now,
      ),
      ShiftHandover(
        id: '2',
        outgoingStaffId: 'nurse3',
        outgoingStaffName: 'James Wilson',
        incomingStaffId: 'nurse1',
        incomingStaffName: 'Sarah Johnson',
        shiftDate: now.subtract(const Duration(days: 1)),
        shiftType: 'Night → Morning',
        notes: [
          HandoverNote(
            id: 'n4',
            patientId: 'p4',
            patientName: 'Emma Davis',
            room: '201A',
            note: 'Critical: Patient requires immediate attention. Vitals unstable throughout the night.',
            priority: HandoverPriority.critical,
            authorId: 'nurse3',
            authorName: 'James Wilson',
            createdAt: now.subtract(const Duration(days: 1)),
            isAcknowledged: true,
          ),
        ],
        status: HandoverStatus.completed,
        createdAt: now.subtract(const Duration(days: 1)),
        acknowledgedAt: now.subtract(const Duration(hours: 20)),
      ),
    ];
  }

  void addHandover(ShiftHandover handover) {
    state = [...state, handover];
  }

  void acknowledgeHandover(String handoverId) {
    state = state.map((h) {
      if (h.id == handoverId) {
        return h.copyWith(
          status: HandoverStatus.acknowledged,
          acknowledgedAt: DateTime.now(),
        );
      }
      return h;
    }).toList();
  }

  void completeHandover(String handoverId) {
    state = state.map((h) {
      if (h.id == handoverId) {
        return h.copyWith(status: HandoverStatus.completed);
      }
      return h;
    }).toList();
  }

  void addNoteToHandover(String handoverId, HandoverNote note) {
    state = state.map((h) {
      if (h.id == handoverId) {
        return h.copyWith(notes: [...h.notes, note]);
      }
      return h;
    }).toList();
  }

  void acknowledgeNote(String handoverId, String noteId) {
    state = state.map((h) {
      if (h.id == handoverId) {
        final updatedNotes = h.notes.map((n) {
          if (n.id == noteId) {
            return n.copyWith(isAcknowledged: true);
          }
          return n;
        }).toList();
        return h.copyWith(notes: updatedNotes);
      }
      return h;
    }).toList();
  }
}

final handoversProvider = StateNotifierProvider<HandoversNotifier, List<ShiftHandover>>((ref) {
  return HandoversNotifier();
});

final pendingHandoversProvider = Provider<List<ShiftHandover>>((ref) {
  final handovers = ref.watch(handoversProvider);
  return handovers.where((h) => h.status == HandoverStatus.pending).toList();
});

final completedHandoversProvider = Provider<List<ShiftHandover>>((ref) {
  final handovers = ref.watch(handoversProvider);
  return handovers.where((h) => h.status == HandoverStatus.completed).toList();
});
