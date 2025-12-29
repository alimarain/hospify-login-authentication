// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/models/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screen.dart';
import 'screens/nurse_dashboard.dart';
import 'screens/doctor_dashboard.dart';
import 'screens/admin_dashboard.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fsdtshofbpdpseagdvmd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzZHRzaG9mYnBkcHNlYWdkdm1kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwMTA5NDcsImV4cCI6MjA4MjU4Njk0N30.f4Iv_KITWMs76bLMqDGtuN_Yj-XOeIRpk7WVfQNt-cY',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Hospital Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home:
          authState.user != null ? const DashboardRouter() : const AuthScreen(),
    );
  }
}

class DashboardRouter extends ConsumerWidget {
  const DashboardRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.user == null) {
      return const AuthScreen();
    }

    // Navigate based on user role
    switch (authState.userRole) {
      case UserRole.nurse:
        return const NurseDashboard();
      case UserRole.doctor:
        return const DoctorDashboard();
      case UserRole.admin:
        return const AdminDashboard();
      default:
        return const AuthScreen();
    }
  }
}
