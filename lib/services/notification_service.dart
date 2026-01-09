import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/app_notification.dart';
import '../providers/notifications_provider.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap - navigate to specific screen
    print('Notification tapped: ${response.payload}');
  }

  Future<void> requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> showNotification(AppNotification notification) async {
    final androidDetails = AndroidNotificationDetails(
      'hospital_channel',
      'Hospital Notifications',
      channelDescription: 'Notifications for hospital management',
      importance: _getImportance(notification.priority),
      priority: _getPriority(notification.priority),
      icon: '@mipmap/ic_launcher',
      color: _getColor(notification.type),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      notification.id.hashCode,
      notification.title,
      notification.body,
      details,
      payload: notification.actionRoute,
    );
  }

  Future<void> scheduleNotification(
    AppNotification notification,
    DateTime scheduledDate,
  ) async {
    final androidDetails = AndroidNotificationDetails(
      'hospital_scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Scheduled notifications for hospital management',
      importance: _getImportance(notification.priority),
      priority: _getPriority(notification.priority),
    );

    const iosDetails = DarwinNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      notification.id.hashCode,
      notification.title,
      notification.body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: notification.actionRoute,
    );
  }

  Future<void> cancelNotification(String id) async {
    await _notifications.cancel(id.hashCode);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Importance _getImportance(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Importance.low;
      case NotificationPriority.medium:
        return Importance.defaultImportance;
      case NotificationPriority.high:
        return Importance.high;
      case NotificationPriority.critical:
        return Importance.max;
    }
  }

  Priority _getPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Priority.low;
      case NotificationPriority.medium:
        return Priority.defaultPriority;
      case NotificationPriority.high:
        return Priority.high;
      case NotificationPriority.critical:
        return Priority.max;
    }
  }

  Color _getColor(NotificationType type) {
    switch (type) {
      case NotificationType.admission:
        return const Color(0xFF10B981);
      case NotificationType.discharge:
        return const Color(0xFF3B82F6);
      case NotificationType.medication:
        return const Color(0xFF8B5CF6);
      case NotificationType.appointment:
        return const Color(0xFFF59E0B);
      case NotificationType.alert:
        return const Color(0xFFEF4444);
      case NotificationType.task:
        return const Color(0xFF6366F1);
      case NotificationType.system:
        return const Color(0xFF64748B);
    }
  }
}

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/nurse_alert.dart';
// import '../models/app_notification.dart';
// import '../services/notification_service.dart'; // ✅ import your service

// class NurseAlertsNotifier extends StateNotifier<List<NurseAlert>> {
//   NurseAlertsNotifier() : super([]) {
//     _loadSampleAlerts();
//   }

//   void _loadSampleAlerts() {
//     state = [
//       NurseAlert(
//         id: '1',
//         type: AlertType.critical,
//         priority: AlertPriority.high,
//         title: 'Critical Vitals Alert',
//         message: 'Blood pressure critically high: 180/120 mmHg',
//         patientId: 'P001',
//         patientName: 'John Smith',
//         roomNumber: '101A',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
//         requiresAction: true,
//       ),
//       NurseAlert(
//         id: '2',
//         type: AlertType.medication,
//         priority: AlertPriority.high,
//         title: 'Medication Due',
//         message: 'Insulin injection due in 10 minutes',
//         patientId: 'P002',
//         patientName: 'Sarah Johnson',
//         roomNumber: '105B',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
//         requiresAction: true,
//       ),
//       NurseAlert(
//         id: '3',
//         type: AlertType.vitals,
//         priority: AlertPriority.medium,
//         title: 'Vitals Check Required',
//         message: 'Scheduled vitals check overdue by 15 minutes',
//         patientId: 'P003',
//         patientName: 'Michael Brown',
//         roomNumber: '203A',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
//         requiresAction: true,
//       ),
//       NurseAlert(
//         id: '4',
//         type: AlertType.task,
//         priority: AlertPriority.low,
//         title: 'Wound Dressing Change',
//         message: 'Post-operative wound dressing needs changing',
//         patientId: 'P004',
//         patientName: 'Emily Davis',
//         roomNumber: '110C',
//         createdAt: DateTime.now().subtract(const Duration(hours: 1)),
//         requiresAction: true,
//       ),
//       NurseAlert(
//         id: '5',
//         type: AlertType.system,
//         priority: AlertPriority.low,
//         title: 'Shift Handover',
//         message: 'Your shift ends in 30 minutes. Prepare handover notes.',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
//         requiresAction: false,
//       ),
//     ];
//   }

//   void acknowledgeAlert(String id) {
//     state = state.map((alert) {
//       if (alert.id == id) {
//         return alert.copyWith(
//           status: AlertStatus.acknowledged,
//           acknowledgedAt: DateTime.now(),
//         );
//       }
//       return alert;
//     }).toList();
//   }

//   void resolveAlert(String id) {
//     state = state.map((alert) {
//       if (alert.id == id) {
//         return alert.copyWith(status: AlertStatus.resolved);
//       }
//       return alert;
//     }).toList();
//   }

//   void dismissAlert(String id) {
//     state = state.map((alert) {
//       if (alert.id == id) {
//         return alert.copyWith(status: AlertStatus.dismissed);
//       }
//       return alert;
//     }).toList();
//   }

//   /// ---------------------------------------------------------------------------
//   /// ADD ALERT (converted to AppNotification)
//   /// ---------------------------------------------------------------------------
//   void addAlert(NurseAlert alert) {
//     state = [alert, ...state];

//     // ✅ Convert NurseAlert to AppNotification before sending to NotificationService
//     final notification = AppNotification(
//       id: alert.id,
//       title: alert.title,
//       body: alert.message,
//       type: NotificationType.alert, // map as needed
//       priority: NotificationPriority.high, // map as needed
//       timestamp: DateTime.now(),
//       actionRoute: '', // optional route
//     );

//     // ✅ Call your service exactly as it is
//     NotificationService().showNotification(notification);
//   }
// }

// /// ---------------------------------------------------------------------------
// /// PROVIDERS
// /// ---------------------------------------------------------------------------
// final nurseAlertsProvider =
//     StateNotifierProvider<NurseAlertsNotifier, List<NurseAlert>>((ref) {
//   return NurseAlertsNotifier();
// });

// final activeAlertsProvider = Provider<List<NurseAlert>>((ref) {
//   final alerts = ref.watch(nurseAlertsProvider);
//   return alerts.where((a) => a.status == AlertStatus.active).toList();
// });

// final criticalAlertsCountProvider = Provider<int>((ref) {
//   final alerts = ref.watch(activeAlertsProvider);
//   return alerts.where((a) => a.priority == AlertPriority.high).length;
// });
