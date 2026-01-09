// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // enum DashboardSection {
// //   dashboard,
// //   patients,
// //   appointments,
// //   analytics,
// //   settings,
// // }

// // final currentSectionProvider = StateProvider<DashboardSection>((ref) {
// //   return DashboardSection.dashboard;
// // });

// // final sidebarExpandedProvider = StateProvider<bool>((ref) => true);

// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // enum AppScreen { dashboard, nursesDashboard, doctorsDashboard, patients }

// // final currentScreenProvider =
// //     StateProvider<AppScreen>((ref) => AppScreen.dashboard);

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// 🔹 Enum to track which screen is currently active
// enum AppScreen {
//   dashboard,
//   nursesDashboard,
//   doctorsDashboard,
//   patients,
// }

// /// 🔹 StateProvider to hold the currently selected screen
// final currentScreenProvider = StateProvider<AppScreen>(
//   (ref) => AppScreen.dashboard, // default screen
// );
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationScreen {
  dashboard,
  patients,
  appointments,
  analytics,
  settings,
  admissions,
  discharges,
  notifications,
  shiftScheduling, // Add this
  handover, // Add this
  nurseAlerts,
  reminders,
}

class NavigationNotifier extends StateNotifier<NavigationScreen> {
  NavigationNotifier() : super(NavigationScreen.dashboard);

  void navigateTo(NavigationScreen screen) {
    state = screen;
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationScreen>((ref) {
  return NavigationNotifier();
});
