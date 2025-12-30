// // main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/models/auth_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'screens/auth_screen.dart';
// import 'screens/nurse_dashboard.dart';
// import 'screens/doctor_dashboard.dart';
// import 'screens/dashboard_screen.dart';
// import 'providers/auth_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'https://fsdtshofbpdpseagdvmd.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzZHRzaG9mYnBkcHNlYWdkdm1kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwMTA5NDcsImV4cCI6MjA4MjU4Njk0N30.f4Iv_KITWMs76bLMqDGtuN_Yj-XOeIRpk7WVfQNt-cY',
//   );

//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);

//     return MaterialApp(
//       title: 'Hospital Dashboard',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0F172A),
//       ),
//       home:
//           authState.user != null ? const DashboardRouter() : const AuthScreen(),
//     );
//   }
// }

// class DashboardRouter extends ConsumerWidget {
//   const DashboardRouter({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);

//     if (authState.user == null) {
//       return const AuthScreen();
//     }

//     // Navigate based on user role
//     switch (authState.userRole) {
//       case UserRole.nurse:
//         return const NurseDashboard();
//       case UserRole.doctor:
//         return const DoctorDashboard();
//       case UserRole.admin:
//         return const DashboardScreen();
//       default:
//         return const AuthScreen();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'theme/app_theme.dart';
// import 'screens/auth_screen.dart';
// import 'screens/nurse_dashboard.dart';
// import 'screens/doctor_dashboard.dart';
// import 'screens/dashboard_screen.dart';
// import 'providers/auth_provider.dart';
// import 'models/auth_model.dart' as app; // ✅ FIX 1

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // 🔑 Supabase Initialization
//   await Supabase.initialize(
//     url: 'https://fsdtshofbpdpseagdvmd.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzZHRzaG9mYnBkcHNlYWdkdm1kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwMTA5NDcsImV4cCI6MjA4MjU4Njk0N30.f4Iv_KITWMs76bLMqDGtuN_Yj-XOeIRpk7WVfQNt-cY',
//   );

//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//     final session = Supabase.instance.client.auth.currentSession;

//     return MaterialApp(
//       title: 'Hospify',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       home: _resolveHome(session, authState),
//     );
//   }

//   /// 🔀 Centralized role-based navigation
//   Widget _resolveHome(Session? session, app.AuthState authState) {
//     // 🔴 No login → Auth screen
//     if (session == null) {
//       return const AuthScreen();
//     }

//     // 🟡 Logged in but role not loaded yet
//     if (authState.userRole == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     // 🟢 Role-based dashboard
//     switch (authState.userRole!) {
//       case app.UserRole.nurse:
//         return const NurseDashboard();
//       case app.UserRole.doctor:
//         return const DoctorDashboard();
//       case app.UserRole.admin:
//         return const DashboardScreen();
//     }

//     // 🛟 SAFETY FALLBACK (Fixes error #2)
//     return const AuthScreen();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/utils/responsive_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'theme/app_theme.dart';
import 'widgets/sidebar.dart'; // ✅ Import Sidebar
import 'screens/auth_screen.dart';
import 'screens/nurse_dashboard.dart';
import 'screens/doctor_dashboard.dart';
import 'screens/dashboard_screen.dart';
import 'providers/auth_provider.dart';
import 'models/auth_model.dart' as app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fsdtshofbpdpseagdvmd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzZHRzaG9mYnBkcHNlYWdkdm1kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwMTA5NDcsImV4cCI6MjA4MjU4Njk0N30.f4Iv_KITWMs76bLMqDGtuN_Yj-XOeIRpk7WVfQNt-cY',
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final session = Supabase.instance.client.auth.currentSession;

    return MaterialApp(
      title: 'Hospify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Default to light theme
      darkTheme: AppTheme.darkTheme, // Optional: Add dark theme support
      home: _resolveHome(session, authState),
    );
  }

  /// 🔀 Centralized role-based navigation with Responsive Wrapper
  Widget _resolveHome(Session? session, app.AuthState authState) {
    if (session == null) {
      return const AuthScreen();
    }

    if (authState.userRole == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Wrap the role-specific dashboards in the MainLayout shell
    switch (authState.userRole!) {
      case app.UserRole.nurse:
        // NurseDashboard likely has its own Scaffold, so we might return it directly
        // or wrap it if you want the global sidebar. Assuming standalone for now:
        return const NurseDashboard();

      case app.UserRole.doctor:
        // DoctorDashboard (from previous context) was content-only, needs the shell
        return const MainLayout(child: DoctorDashboard());

      case app.UserRole.admin:
        // Admin Dashboard was content-only, needs the shell
        return const MainLayout(child: DashboardScreen());
    }

    return const AuthScreen();
  }
}

/// 📱🖥️ Responsive Layout Wrapper
/// Handles switching between Sidebar (Desktop) and Drawer (Mobile)
class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Check if we are on mobile using your ResponsiveUtils
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      // 1. Mobile Header (Only show AppBar on mobile to open drawer)
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppTheme.background, // Match theme
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          : null,

      // 2. Mobile Navigation (Drawer)
      drawer: isMobile ? const Drawer(child: SideBar()) : null,

      // 3. Responsive Body
      body: Row(
        children: [
          // Desktop Navigation (Fixed Sidebar)
          if (!isMobile) const SizedBox(width: 250, child: SideBar()),

          // Main Content Area
          Expanded(
            child: Container(
              color: AppTheme.background,
              padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
              child: child, // The specific dashboard passed in
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'theme/app_theme.dart';
// import 'screens/main_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // 🔑 Initialize Supabase
//   await Supabase.initialize(
//     url: 'https://fsdtshofbpdpseagdvmd.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzZHRzaG9mYnBkcHNlYWdkdm1kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwMTA5NDcsImV4cCI6MjA4MjU4Njk0N30.f4Iv_KITWMs76bLMqDGtuN_Yj-XOeIRpk7WVfQNt-cY',
//   );

//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hospify',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       home: const MainScreen(),
//     );
//   }
// }
