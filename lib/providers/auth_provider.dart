import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(supabaseProvider));
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

final roleConfigProvider = Provider.family<RoleConfig, UserRole>((ref, role) {
  switch (role) {
    case UserRole.nurse:
      return const RoleConfig(
        title: 'Nurse Login',
        description: 'Access your nursing dashboard',
        iconAsset: 'heart_pulse',
        colorValue: 0xFF22C55E,
        bgColorValue: 0x1A22C55E,
      );
    case UserRole.doctor:
      return const RoleConfig(
        title: 'Doctor Login',
        description: 'Access your doctor dashboard',
        iconAsset: 'stethoscope',
        colorValue: 0xFF3B82F6,
        bgColorValue: 0x1A3B82F6,
      );
    case UserRole.admin:
      return const RoleConfig(
        title: 'Admin Login',
        description: 'Access all hospital dashboards',
        iconAsset: 'shield',
        colorValue: 0xFFA855F7,
        bgColorValue: 0x1AA855F7,
      );
  }
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AuthState()) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final user = _authService.currentUser;
    if (user != null) {
      final userData = await _authService.getUserData(user.id);
      if (userData != null) {
        final role = _getRoleFromString(userData['role']);
        state = state.copyWith(
          user: user,
          userRole: role,
          userData: userData,
        );
      }
    }
  }

  UserRole _getRoleFromString(String? roleString) {
    switch (roleString?.toLowerCase()) {
      case 'nurse':
        return UserRole.nurse;
      case 'doctor':
        return UserRole.doctor;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.nurse;
    }
  }

  void setRole(UserRole role) {
    state = state.copyWith(selectedRole: role);
  }

  void togglePassword() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  void clearErrors() {
    state = state.copyWith(emailError: null, passwordError: null);
  }

  Future<bool> signIn(String email, String password) async {
    clearErrors();

    final emailError = Validators.validateEmail(email);
    final passwordError = Validators.validatePassword(password);

    if (emailError != null || passwordError != null) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true);

    try {
      final response = await _authService.signIn(email, password);
      if (response.user != null) {
        final userData = await _authService.getUserData(response.user!.id);

        if (userData != null) {
          final role = _getRoleFromString(userData['role']);

          // Check if user role matches selected role
          if (role != state.selectedRole) {
            state = state.copyWith(
              isSubmitting: false,
              errorMessage: 'Invalid credentials for selected role',
            );
            await _authService.signOut();
            return false;
          }

          // Check password expiry
          final passwordLastChanged =
              DateTime.parse(userData['password_changed_at']);
          final daysSinceChange =
              DateTime.now().difference(passwordLastChanged).inDays;

          if (daysSinceChange > 90) {
            state = state.copyWith(
              isSubmitting: false,
              errorMessage:
                  'Your password has expired. Please contact IT support.',
            );
            await _authService.signOut();
            return false;
          }

          state = state.copyWith(
            isSubmitting: false,
            user: response.user,
            userRole: role,
            userData: userData,
          );
          return true;
        } else {
          state = state.copyWith(
            isSubmitting: false,
            errorMessage: 'User data not found',
          );
          return false;
        }
      } else {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: 'Invalid email or password',
        );
        return false;
      }
    } catch (e) {
      String message = 'An unexpected error occurred';
      if (e is AuthException) {
        if (e.message.contains('Invalid login credentials')) {
          message = 'Invalid email or password. Please try again.';
        } else if (e.message.contains('Email not confirmed')) {
          message = 'Please confirm your email before logging in.';
        } else {
          message = e.message;
        }
      }
      state = state.copyWith(isSubmitting: false, errorMessage: message);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const AuthState();
  }
}
