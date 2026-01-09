import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings {
  final bool darkMode;
  final bool notifications;
  final bool emailAlerts;
  final bool smsAlerts;
  final String language;
  final String dateFormat;
  final String timeFormat;

  AppSettings({
    this.darkMode = false,
    this.notifications = true,
    this.emailAlerts = true,
    this.smsAlerts = false,
    this.language = 'English',
    this.dateFormat = 'MM/DD/YYYY',
    this.timeFormat = '12h',
  });

  AppSettings copyWith({
    bool? darkMode,
    bool? notifications,
    bool? emailAlerts,
    bool? smsAlerts,
    String? language,
    String? dateFormat,
    String? timeFormat,
  }) {
    return AppSettings(
      darkMode: darkMode ?? this.darkMode,
      notifications: notifications ?? this.notifications,
      emailAlerts: emailAlerts ?? this.emailAlerts,
      smsAlerts: smsAlerts ?? this.smsAlerts,
      language: language ?? this.language,
      dateFormat: dateFormat ?? this.dateFormat,
      timeFormat: timeFormat ?? this.timeFormat,
    );
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(AppSettings());

  void toggleDarkMode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }

  void toggleNotifications() {
    state = state.copyWith(notifications: !state.notifications);
  }

  void toggleEmailAlerts() {
    state = state.copyWith(emailAlerts: !state.emailAlerts);
  }

  void toggleSmsAlerts() {
    state = state.copyWith(smsAlerts: !state.smsAlerts);
  }

  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }

  void setDateFormat(String format) {
    state = state.copyWith(dateFormat: format);
  }

  void setTimeFormat(String format) {
    state = state.copyWith(timeFormat: format);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});
