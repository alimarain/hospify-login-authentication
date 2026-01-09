import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/nurse_alert.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final nurseAlertsProvider =
    StateNotifierProvider<NurseAlertsNotifier, AsyncValue<List<NurseAlert>>>(
        (ref) {
  final client = ref.watch(supabaseClientProvider);
  return NurseAlertsNotifier(client);
});

final unreadAlertsCountProvider = Provider<int>((ref) {
  final alerts = ref.watch(nurseAlertsProvider);
  return alerts.maybeWhen(
    data: (data) => data.where((a) => !a.isRead).length,
    orElse: () => 0,
  );
});

final criticalAlertsCountProvider = Provider<int>((ref) {
  final alerts = ref.watch(nurseAlertsProvider);
  return alerts.maybeWhen(
    data: (data) => data
        .where((a) =>
            !a.isRead &&
            (a.type == AlertType.admin || a.type == AlertType.post))
        .length,
    orElse: () => 0,
  );
});

class NurseAlertsNotifier extends StateNotifier<AsyncValue<List<NurseAlert>>> {
  final SupabaseClient _client;
  RealtimeChannel? _channel;
  StreamSubscription? _subscription;

  NurseAlertsNotifier(this._client) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    await fetchAlerts();
    _subscribeToRealtime();
  }

  Future<void> fetchAlerts() async {
    try {
      state = const AsyncValue.loading();

      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        state = const AsyncValue.data([]);
        return;
      }

      final response = await _client
          .from('nurse_alerts')
          .select()
          .eq('nurse_id', userId)
          .order('created_at', ascending: false);

      final alerts =
          (response as List).map((json) => NurseAlert.fromJson(json)).toList();

      state = AsyncValue.data(alerts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void _subscribeToRealtime() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    _channel = _client.channel('nurse_alerts_$userId');

    _channel!
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'nurse_alerts',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'nurse_id',
            value: userId,
          ),
          callback: (payload) {
            final newAlert = NurseAlert.fromJson(payload.newRecord);
            state.whenData((alerts) {
              state = AsyncValue.data([newAlert, ...alerts]);
            });
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'nurse_alerts',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'nurse_id',
            value: userId,
          ),
          callback: (payload) {
            final updatedAlert = NurseAlert.fromJson(payload.newRecord);
            state.whenData((alerts) {
              state = AsyncValue.data(
                alerts
                    .map((a) => a.id == updatedAlert.id ? updatedAlert : a)
                    .toList(),
              );
            });
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'nurse_alerts',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'nurse_id',
            value: userId,
          ),
          callback: (payload) {
            final deletedId = payload.oldRecord['id'] as String;
            state.whenData((alerts) {
              state = AsyncValue.data(
                alerts.where((a) => a.id != deletedId).toList(),
              );
            });
          },
        )
        .subscribe();
  }

  Future<void> addAlert(NurseAlert alert) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final alertWithNurse = alert.copyWith(nurseId: userId);
    await _client.from('nurse_alerts').insert(alertWithNurse.toJson());
  }

  Future<void> markAsRead(String id) async {
    await _client.from('nurse_alerts').update({'is_read': true}).eq('id', id);
  }

  Future<void> dismissAlert(String id) async {
    await _client.from('nurse_alerts').delete().eq('id', id);
  }

  Future<void> acknowledgeAlert(String id) async {
    await _client.from('nurse_alerts').update({
      'is_read': false,
      'triggered': true,
    }).eq('id', id);
  }

  Future<void> escalateAlert(String id, AlertType newType) async {
    await _client.from('nurse_alerts').update({
      'type': newType.value,
      'time': newType == AlertType.onTime
          ? 'Due now'
          : newType == AlertType.post
              ? 'Overdue'
              : 'Escalated to Admin',
    }).eq('id', id);
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    _subscription?.cancel();
    super.dispose();
  }
}
