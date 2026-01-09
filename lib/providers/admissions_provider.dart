import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/admission.dart';
import '../models/app_notification.dart';
import '../services/notification_service.dart';

class AdmissionsNotifier extends StateNotifier<List<Admission>> {
  final NotificationService _notificationService;

  AdmissionsNotifier(this._notificationService) : super(_sampleAdmissions);

  static final List<Admission> _sampleAdmissions = [
    Admission(
      id: 'ADM001',
      patientId: 'P001',
      patientName: 'John Smith',
      type: AdmissionType.emergency,
      status: AdmissionStatus.inProgress,
      admissionDate: DateTime.now().subtract(const Duration(hours: 2)),
      ward: 'ICU',
      room: '101',
      bed: 'A',
      admittingDoctor: 'Dr. Sarah Wilson',
      diagnosis: 'Acute Myocardial Infarction',
      requiredTests: ['ECG', 'Troponin', 'CBC'],
      insuranceVerified: true,
      consentSigned: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Admission(
      id: 'ADM002',
      patientId: 'P002',
      patientName: 'Emily Davis',
      type: AdmissionType.scheduled,
      status: AdmissionStatus.pending,
      admissionDate: DateTime.now().add(const Duration(hours: 4)),
      ward: 'Orthopedics',
      room: '205',
      bed: 'B',
      admittingDoctor: 'Dr. Michael Chen',
      diagnosis: 'Hip Replacement Surgery',
      requiredTests: ['X-Ray', 'Blood Type', 'Coagulation Panel'],
      insuranceVerified: false,
      consentSigned: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Admission(
      id: 'ADM003',
      patientId: 'P003',
      patientName: 'Robert Johnson',
      type: AdmissionType.transfer,
      status: AdmissionStatus.completed,
      admissionDate: DateTime.now().subtract(const Duration(days: 1)),
      ward: 'Cardiology',
      room: '302',
      bed: 'A',
      admittingDoctor: 'Dr. Sarah Wilson',
      diagnosis: 'Heart Failure',
      requiredTests: ['Echo', 'BNP', 'Chest X-Ray'],
      insuranceVerified: true,
      consentSigned: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Future<void> addAdmission(Admission admission) async {
    state = [...state, admission];

    // Send notification
    final notification = AppNotification(
      id: 'notif_${admission.id}',
      title: 'New Patient Admission',
      body: '${admission.patientName} admitted to ${admission.ward}',
      type: NotificationType.admission,
      priority: admission.type == AdmissionType.emergency
          ? NotificationPriority.critical
          : NotificationPriority.medium,
      timestamp: DateTime.now(),
    );

    await _notificationService.showNotification(notification);
  }

  Future<void> updateAdmissionStatus(String id, AdmissionStatus status) async {
    state = state.map((admission) {
      if (admission.id == id) {
        return admission.copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
      }
      return admission;
    }).toList();

    if (status == AdmissionStatus.completed) {
      final admission = state.firstWhere((a) => a.id == id);
      final notification = AppNotification(
        id: 'notif_complete_$id',
        title: 'Admission Completed',
        body: '${admission.patientName} admission process completed',
        type: NotificationType.admission,
        priority: NotificationPriority.medium,
        timestamp: DateTime.now(),
      );
      await _notificationService.showNotification(notification);
    }
  }

  void updateAdmission(Admission updated) {
    state = state.map((admission) {
      if (admission.id == updated.id) {
        return updated.copyWith(updatedAt: DateTime.now());
      }
      return admission;
    }).toList();
  }

  void deleteAdmission(String id) {
    state = state.where((admission) => admission.id != id).toList();
  }

  List<Admission> getByStatus(AdmissionStatus status) {
    return state.where((a) => a.status == status).toList();
  }
}

final notificationServiceProvider = Provider((ref) => NotificationService());

final admissionsProvider =
    StateNotifierProvider<AdmissionsNotifier, List<Admission>>((ref) {
  return AdmissionsNotifier(ref.read(notificationServiceProvider));
});

final pendingAdmissionsProvider = Provider((ref) {
  final admissions = ref.watch(admissionsProvider);
  return admissions.where((a) => a.status == AdmissionStatus.pending).toList();
});

final inProgressAdmissionsProvider = Provider((ref) {
  final admissions = ref.watch(admissionsProvider);
  return admissions
      .where((a) => a.status == AdmissionStatus.inProgress)
      .toList();
});
