import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final realtimeBadgesProvider =
    StateNotifierProvider<RealtimeBadgesNotifier, Map<String, int>>(
  (ref) => RealtimeBadgesNotifier(),
);

class RealtimeBadgesNotifier extends StateNotifier<Map<String, int>> {
  RealtimeBadgesNotifier()
      : super({
          'Patients': 0,
          'Admissions': 0,
          'Appointments': 0,
          'Notifications': 0,
        }) {
    _init();
  }

  final SupabaseClient _supabase = Supabase.instance.client;
  final List<RealtimeChannel> _channels = [];

  Future<void> _init() async {
    await _loadCounts();
    _listenRealtime();
  }

  Future<void> _loadCounts() async {
    final patients =
        await _supabase.from('patients').select('id').count(CountOption.exact);

    final admissions = await _supabase
        .from('admissions')
        .select('id')
        .count(CountOption.exact);

    final appointments = await _supabase
        .from('appointments')
        .select('id')
        .count(CountOption.exact);

    final notifications = await _supabase
        .from('notifications')
        .select('id')
        .count(CountOption.exact);

    state = {
      'Patients': patients.count ?? 0,
      'Admissions': admissions.count ?? 0,
      'Appointments': appointments.count ?? 0,
      'Notifications': notifications.count ?? 0,
    };
  }

  void _listenRealtime() {
    _subscribe('patients', 'Patients');
    _subscribe('admissions', 'Admissions');
    _subscribe('appointments', 'Appointments');
    _subscribe('notifications', 'Notifications');
  }

  void _subscribe(String table, String key) {
    final channel = _supabase.channel('realtime:$table')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: table,
        callback: (_) => _loadCounts(),
      )
      ..subscribe();

    _channels.add(channel);
  }

  @override
  void dispose() {
    for (final c in _channels) {
      _supabase.removeChannel(c);
    }
    super.dispose();
  }
}
