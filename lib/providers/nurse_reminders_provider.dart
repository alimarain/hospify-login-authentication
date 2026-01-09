import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/nurse_reminder.dart';
import 'nurse_alerts_provider.dart';

final nurseRemindersProvider = StateNotifierProvider<NurseRemindersNotifier,
    AsyncValue<List<NurseReminder>>>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return NurseRemindersNotifier(client);
});

final pendingRemindersProvider = Provider<List<NurseReminder>>((ref) {
  final reminders = ref.watch(nurseRemindersProvider);
  return reminders.maybeWhen(
    data: (data) => data
        .where((r) =>
            r.status == ReminderStatus.pending ||
            r.status == ReminderStatus.snoozed)
        .toList()
      ..sort((a, b) => a.dueAt.compareTo(b.dueAt)),
    orElse: () => [],
  );
});

final overdueRemindersProvider = Provider<List<NurseReminder>>((ref) {
  final reminders = ref.watch(pendingRemindersProvider);
  return reminders.where((r) => r.isOverdue).toList();
});

final upcomingRemindersProvider = Provider<List<NurseReminder>>((ref) {
  final reminders = ref.watch(pendingRemindersProvider);
  final now = DateTime.now();
  final oneHourLater = now.add(const Duration(hours: 1));
  return reminders
      .where((r) => !r.isOverdue && r.dueAt.isBefore(oneHourLater))
      .toList();
});

class NurseRemindersNotifier
    extends StateNotifier<AsyncValue<List<NurseReminder>>> {
  final SupabaseClient _client;
  RealtimeChannel? _channel;

  NurseRemindersNotifier(this._client) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    await fetchReminders();
    _subscribeToRealtime();
  }

  Future<void> fetchReminders() async {
    try {
      state = const AsyncValue.loading();

      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        state = const AsyncValue.data([]);
        return;
      }

      final response = await _client
          .from('nurse_reminders')
          .select()
          .eq('nurse_id', userId)
          .order('due_at', ascending: true);

      final reminders = (response as List)
          .map((json) => NurseReminder.fromJson(json))
          .toList();

      state = AsyncValue.data(reminders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void _subscribeToRealtime() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    _channel = _client.channel('nurse_reminders_$userId');

    _channel!
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'nurse_reminders',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'nurse_id',
            value: userId,
          ),
          callback: (payload) {
            final newReminder = NurseReminder.fromJson(payload.newRecord);
            state.whenData((reminders) {
              final updated = [...reminders, newReminder];
              updated.sort((a, b) => a.dueAt.compareTo(b.dueAt));
              state = AsyncValue.data(updated);
            });
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'nurse_reminders',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'nurse_id',
            value: userId,
          ),
          callback: (payload) {
            final updatedReminder = NurseReminder.fromJson(payload.newRecord);
            state.whenData((reminders) {
              state = AsyncValue.data(
                reminders
                    .map(
                        (r) => r.id == updatedReminder.id ? updatedReminder : r)
                    .toList(),
              );
            });
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'nurse_reminders',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'nurse_id',
            value: userId,
          ),
          callback: (payload) {
            final deletedId = payload.oldRecord['id'] as String;
            state.whenData((reminders) {
              state = AsyncValue.data(
                reminders.where((r) => r.id != deletedId).toList(),
              );
            });
          },
        )
        .subscribe();
  }

  Future<void> addReminder(NurseReminder reminder) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final reminderWithNurse = reminder.copyWith(nurseId: userId);
    await _client.from('nurse_reminders').insert(reminderWithNurse.toJson());
  }

  Future<void> completeReminder(String id) async {
    await _client.from('nurse_reminders').update({
      'status': ReminderStatus.completed.value,
    }).eq('id', id);
  }

  Future<void> snoozeReminder(String id, Duration duration) async {
    state.whenData((reminders) async {
      final reminder = reminders.firstWhere((r) => r.id == id);
      final newDueAt = DateTime.now().add(duration);

      await _client.from('nurse_reminders').update({
        'status': ReminderStatus.snoozed.value,
        'due_at': newDueAt.toIso8601String(),
      }).eq('id', id);
    });
  }

  Future<void> deleteReminder(String id) async {
    await _client.from('nurse_reminders').delete().eq('id', id);
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }
}
