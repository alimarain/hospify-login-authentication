import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/discharge.dart';
import '../models/app_notification.dart';
import '../services/notification_service.dart';
import 'admissions_provider.dart';

class DischargesNotifier extends StateNotifier<List<Discharge>> {
  final NotificationService _notificationService;

  DischargesNotifier(this._notificationService) : super(_sampleDischarges);

  static final List<Discharge> _sampleDischarges = [
    Discharge(
      id: 'DIS001',
      patientId: 'P004',
      patientName: 'Mary Williams',
      admissionId: 'ADM004',
      type: DischargeType.normal,
      status: DischargeStatus.billingReview,
      plannedDischargeDate: DateTime.now().add(const Duration(hours: 6)),
      dischargingDoctor: 'Dr. Sarah Wilson',
      dischargeSummary: 'Patient recovered well from pneumonia treatment.',
      medications: ['Amoxicillin 500mg', 'Paracetamol PRN'],
      followUpInstructions: ['Rest for 1 week', 'Follow up in 2 weeks'],
      nextAppointmentDate: '2024-02-15',
      billingCleared: false,
      pharmacyCleared: true,
      nursingCleared: true,
      patientEducationCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    Discharge(
      id: 'DIS002',
      patientId: 'P005',
      patientName: 'James Brown',
      admissionId: 'ADM005',
      type: DischargeType.normal,
      status: DischargeStatus.readyForDischarge,
      plannedDischargeDate: DateTime.now().add(const Duration(hours: 2)),
      dischargingDoctor: 'Dr. Michael Chen',
      dischargeSummary: 'Post-operative recovery complete.',
      medications: ['Ibuprofen 400mg', 'Omeprazole 20mg'],
      followUpInstructions: ['Wound care daily', 'Physical therapy'],
      nextAppointmentDate: '2024-02-20',
      billingCleared: true,
      pharmacyCleared: true,
      nursingCleared: true,
      patientEducationCompleted: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Future<void> addDischarge(Discharge discharge) async {
    state = [...state, discharge];

    final notification = AppNotification(
      id: 'notif_${discharge.id}',
      title: 'Discharge Initiated',
      body: '${discharge.patientName} discharge process started',
      type: NotificationType.discharge,
      priority: NotificationPriority.medium,
      timestamp: DateTime.now(),
    );

    await _notificationService.showNotification(notification);
  }

  Future<void> updateDischargeStatus(String id, DischargeStatus status) async {
    state = state.map((discharge) {
      if (discharge.id == id) {
        return discharge.copyWith(
          status: status,
          updatedAt: DateTime.now(),
          actualDischargeDate:
              status == DischargeStatus.completed ? DateTime.now() : null,
        );
      }
      return discharge;
    }).toList();

    if (status == DischargeStatus.readyForDischarge) {
      final discharge = state.firstWhere((d) => d.id == id);
      final notification = AppNotification(
        id: 'notif_ready_$id',
        title: 'Patient Ready for Discharge',
        body: '${discharge.patientName} is ready for discharge',
        type: NotificationType.discharge,
        priority: NotificationPriority.high,
        timestamp: DateTime.now(),
      );
      await _notificationService.showNotification(notification);
    }
  }

  void updateChecklistItem(String id, String field, bool value) {
    state = state.map((discharge) {
      if (discharge.id == id) {
        switch (field) {
          case 'billing':
            return discharge.copyWith(billingCleared: value);
          case 'pharmacy':
            return discharge.copyWith(pharmacyCleared: value);
          case 'nursing':
            return discharge.copyWith(nursingCleared: value);
          case 'education':
            return discharge.copyWith(patientEducationCompleted: value);
        }
      }
      return discharge;
    }).toList();
  }

  void updateDischarge(Discharge updated) {
    state = state.map((discharge) {
      if (discharge.id == updated.id) {
        return updated.copyWith(updatedAt: DateTime.now());
      }
      return discharge;
    }).toList();
  }
}

final dischargesProvider =
    StateNotifierProvider<DischargesNotifier, List<Discharge>>((ref) {
  return DischargesNotifier(ref.read(notificationServiceProvider));
});

final pendingDischargesProvider = Provider((ref) {
  final discharges = ref.watch(dischargesProvider);
  return discharges
      .where((d) =>
          d.status != DischargeStatus.completed &&
          d.status != DischargeStatus.cancelled)
      .toList();
});
