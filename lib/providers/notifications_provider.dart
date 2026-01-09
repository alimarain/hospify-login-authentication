import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_notification.dart';
import '../services/notification_service.dart';
import 'admissions_provider.dart';

class NotificationsNotifier extends StateNotifier<List<AppNotification>> {
  final NotificationService _notificationService;

  NotificationsNotifier(this._notificationService)
      : super(_initialNotifications);

  /// ---------------------------------------------------------------------------
  /// MOCK / INITIAL DATA (can be replaced with API or Supabase later)
  /// ---------------------------------------------------------------------------
  static final List<AppNotification> _initialNotifications = [
    AppNotification(
      id: 'N001',
      title: 'New Admission',
      body: 'John Smith admitted to ICU',
      type: NotificationType.admission,
      priority: NotificationPriority.high,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    AppNotification(
      id: 'N002',
      title: 'Medication Due',
      body: 'Medication for Room 205 due in 15 minutes',
      type: NotificationType.medication,
      priority: NotificationPriority.critical,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    AppNotification(
      id: 'N003',
      title: 'Discharge Ready',
      body: 'James Brown is ready for discharge',
      type: NotificationType.discharge,
      priority: NotificationPriority.medium,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  /// ---------------------------------------------------------------------------
  /// ADD NOTIFICATION (also triggers local notification)
  /// ---------------------------------------------------------------------------
  Future<void> addNotification(AppNotification notification) async {
    state = [notification, ...state];
    await _notificationService.showNotification(notification);
  }

  /// ---------------------------------------------------------------------------
  /// READ / UNREAD MANAGEMENT
  /// ---------------------------------------------------------------------------
  void markAsRead(String id) {
    state = state
        .map(
          (n) => n.id == id ? n.copyWith(isRead: true) : n,
        )
        .toList();
  }

  void markAllAsRead() {
    state = state.map((n) => n.copyWith(isRead: true)).toList();
  }

  /// ---------------------------------------------------------------------------
  /// DELETE / CLEAR
  /// ---------------------------------------------------------------------------
  void deleteNotification(String id) {
    state = state.where((n) => n.id != id).toList();
  }

  void clearAll() {
    state = [];
  }
}

/// ---------------------------------------------------------------------------
/// PROVIDERS
/// ---------------------------------------------------------------------------

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<AppNotification>>((ref) {
  return NotificationsNotifier(ref.read(notificationServiceProvider));
});

/// 🔔 REAL UNREAD COUNT (used by DashboardHeader badge)
final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider);
  return notifications.where((n) => !n.isRead).length;
});
