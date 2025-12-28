
import 'package:supabase_flutter/supabase_flutter.dart';

enum UserRole { nurse, doctor, admin }

class RoleConfig {
  final String title;
  final String description;
  final String iconAsset;
  final int colorValue;
  final int bgColorValue;

  const RoleConfig({
    required this.title,
    required this.description,
    required this.iconAsset,
    required this.colorValue,
    required this.bgColorValue,
  });
}

class AuthState {
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final UserRole selectedRole;
  final bool showPassword;
  final bool rememberMe;
  final String? emailError;
  final String? passwordError;
  final User? user;
  final UserRole? userRole;
  final Map<String, dynamic>? userData;

  const AuthState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.selectedRole = UserRole.nurse,
    this.showPassword = false,
    this.rememberMe = false,
    this.emailError,
    this.passwordError,
    this.user,
    this.userRole,
    this.userData,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    UserRole? selectedRole,
    bool? showPassword,
    bool? rememberMe,
    String? emailError,
    String? passwordError,
    User? user,
    UserRole? userRole,
    Map<String, dynamic>? userData,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      selectedRole: selectedRole ?? this.selectedRole,
      showPassword: showPassword ?? this.showPassword,
      rememberMe: rememberMe ?? this.rememberMe,
      emailError: emailError,
      passwordError: passwordError,
      user: user ?? this.user,
      userRole: userRole ?? this.userRole,
      userData: userData ?? this.userData,
    );
  }
}