import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardSection {
  dashboard,
  patients,
  appointments,
  analytics,
  settings,
}

final currentSectionProvider = StateProvider<DashboardSection>((ref) {
  return DashboardSection.dashboard;
});

final sidebarExpandedProvider = StateProvider<bool>((ref) => true);
