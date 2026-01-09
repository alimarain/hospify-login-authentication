// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
// import '../models/auth_model.dart';
// import '../services/auth_service.dart';
// import '../utils/validators.dart';

// final supabaseProvider = Provider<SupabaseClient>((ref) {
//   return Supabase.instance.client;
// });

// final authServiceProvider = Provider<AuthService>((ref) {
//   return AuthService(ref.watch(supabaseProvider));
// });

// final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(ref.watch(authServiceProvider));
// });

// final roleConfigProvider = Provider.family<RoleConfig, UserRole>((ref, role) {
//   switch (role) {
//     case UserRole.nurse:
//       return const RoleConfig(
//         title: 'Nurse Login',
//         description: 'Access your nursing dashboard',
//         iconAsset: 'heart_pulse',
//         colorValue: 0xFF22C55E,
//         bgColorValue: 0x1A22C55E,
//       );
//     case UserRole.doctor:
//       return const RoleConfig(
//         title: 'Doctor Login',
//         description: 'Access your doctor dashboard',
//         iconAsset: 'stethoscope',
//         colorValue: 0xFF3B82F6,
//         bgColorValue: 0x1A3B82F6,
//       );
//     case UserRole.admin:
//       return const RoleConfig(
//         title: 'Admin Login',
//         description: 'Access all hospital dashboards',
//         iconAsset: 'shield',
//         colorValue: 0xFFA855F7,
//         bgColorValue: 0x1AA855F7,
//       );
//   }
// });

// class AuthNotifier extends StateNotifier<AuthState> {
//   final AuthService _authService;

//   AuthNotifier(this._authService) : super(const AuthState()) {
//     _checkAuth();
//   }

//   Future<void> _checkAuth() async {
//     final user = _authService.currentUser;
//     if (user != null) {
//       final userData = await _authService.getUserData(user.id);
//       if (userData != null) {
//         final role = _getRoleFromString(userData['role']);
//         state = state.copyWith(
//           user: user,
//           userRole: role,
//           userData: userData,
//         );
//       }
//     }
//   }

//   UserRole _getRoleFromString(String? roleString) {
//     switch (roleString?.toLowerCase()) {
//       case 'nurse':
//         return UserRole.nurse;
//       case 'doctor':
//         return UserRole.doctor;
//       case 'admin':
//         return UserRole.admin;
//       default:
//         return UserRole.nurse;
//     }
//   }

//   void setRole(UserRole role) {
//     state = state.copyWith(selectedRole: role);
//   }

//   void togglePassword() {
//     state = state.copyWith(showPassword: !state.showPassword);
//   }

//   void toggleRememberMe() {
//     state = state.copyWith(rememberMe: !state.rememberMe);
//   }

//   void clearErrors() {
//     state = state.copyWith(emailError: null, passwordError: null);
//   }

//   Future<bool> signIn(String email, String password) async {
//     clearErrors();

//     final emailError = Validators.validateEmail(email);
//     final passwordError = Validators.validatePassword(password);

//     if (emailError != null || passwordError != null) {
//       state = state.copyWith(
//         emailError: emailError,
//         passwordError: passwordError,
//       );
//       return false;
//     }

//     state = state.copyWith(isSubmitting: true);

//     try {
//       final response = await _authService.signIn(email, password);
//       if (response.user != null) {
//         final userData = await _authService.getUserData(response.user!.id);

//         if (userData != null) {
//           final role = _getRoleFromString(userData['role']);

//           // Check if user role matches selected role
//           if (role != state.selectedRole) {
//             state = state.copyWith(
//               isSubmitting: false,
//               errorMessage: 'Invalid credentials for selected role',
//             );
//             await _authService.signOut();
//             return false;
//           }

//           // Check password expiry
//           final passwordLastChanged =
//               DateTime.parse(userData['password_changed_at']);
//           final daysSinceChange =
//               DateTime.now().difference(passwordLastChanged).inDays;

//           if (daysSinceChange > 90) {
//             state = state.copyWith(
//               isSubmitting: false,
//               errorMessage:
//                   'Your password has expired. Please contact IT support.',
//             );
//             await _authService.signOut();
//             return false;
//           }

//           state = state.copyWith(
//             isSubmitting: false,
//             user: response.user,
//             userRole: role,
//             userData: userData,
//           );
//           return true;
//         } else {
//           state = state.copyWith(
//             isSubmitting: false,
//             errorMessage: 'User data not found',
//           );
//           return false;
//         }
//       } else {
//         state = state.copyWith(
//           isSubmitting: false,
//           errorMessage: 'Invalid email or password',
//         );
//         return false;
//       }
//     } catch (e) {
//       String message = 'An unexpected error occurred';
//       if (e is AuthException) {
//         if (e.message.contains('Invalid login credentials')) {
//           message = 'Invalid email or password. Please try again.';
//         } else if (e.message.contains('Email not confirmed')) {
//           message = 'Please confirm your email before logging in.';
//         } else {
//           message = e.message;
//         }
//       }
//       state = state.copyWith(isSubmitting: false, errorMessage: message);
//       return false;
//     }
//   }

//   Future<void> signOut() async {
//     await _authService.signOut();
//     state = const AuthState();
//   }
// }
//-----------------------------------------------------------------------------04-1-2025-----------------------------//

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
// import '../models/auth_model.dart';
// import '../services/auth_service.dart';
// import '../utils/validators.dart';

// /// --- Supabase client provider ---
// final supabaseProvider = Provider<SupabaseClient>((ref) {
//   return Supabase.instance.client;
// });

// /// --- AuthService provider ---
// final authServiceProvider = Provider<AuthService>((ref) {
//   return AuthService(ref.watch(supabaseProvider));
// });

// /// --- AppScreen enum ---
// enum AppScreen {
//   dashboard,
//   nursesDashboard,
//   doctorsDashboard,
//   patients,
// }

// /// --- Current screen provider ---
// final currentScreenProvider = StateProvider<AppScreen>((ref) {
//   return AppScreen.dashboard;
// });

// /// --- AuthNotifier / AuthState provider ---
// final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(ref.watch(authServiceProvider), ref);
// });

// /// --- Role config provider ---
// final roleConfigProvider = Provider.family<RoleConfig, UserRole>((ref, role) {
//   switch (role) {
//     case UserRole.nurse:
//       return const RoleConfig(
//         title: 'Nurse Login',
//         description: 'Access your nursing dashboard',
//         iconAsset: 'heart_pulse',
//         colorValue: 0xFF22C55E,
//         bgColorValue: 0x1A22C55E,
//       );
//     case UserRole.doctor:
//       return const RoleConfig(
//         title: 'Doctor Login',
//         description: 'Access your doctor dashboard',
//         iconAsset: 'stethoscope',
//         colorValue: 0xFF3B82F6,
//         bgColorValue: 0x1A3B82F6,
//       );
//     case UserRole.admin:
//       return const RoleConfig(
//         title: 'Admin Login',
//         description: 'Access all hospital dashboards',
//         iconAsset: 'shield',
//         colorValue: 0xFFA855F7,
//         bgColorValue: 0x1AA855F7,
//       );
//   }
// });

// /// --- AppUser provider for UI convenience ---
// final appUserProvider = Provider<AppUser?>((ref) {
//   final authState = ref.watch(authStateProvider);
//   if (authState.user != null && authState.userRole != null) {
//     final userName = authState.userData?['name'] as String? ??
//         authState.user!.email ??
//         'User';
//     return AppUser(
//       id: authState.user!.id,
//       name: userName,
//       email: authState.user!.email ?? '',
//       role: authState.userRole!,
//     );
//   }
//   return null;
// });

// /// --- AuthNotifier Implementation ---
// class AuthNotifier extends StateNotifier<AuthState> {
//   final AuthService _authService;
//   final Ref _ref;

//   AuthNotifier(this._authService, this._ref) : super(const AuthState()) {
//     _checkAuth();
//   }

//   /// Check if user is already signed in
//   Future<void> _checkAuth() async {
//     final user = _authService.currentUser;
//     if (user != null) {
//       final userData = await _authService.getUserData(user.id);
//       if (userData != null) {
//         final role = _getRoleFromString(userData['role']);
//         state = state.copyWith(
//           user: user,
//           userRole: role,
//           userData: userData,
//         );

//         // Update the screen based on role
//         _setScreenForRole(role);
//       }
//     }
//   }

//   /// Convert string to UserRole enum
//   UserRole _getRoleFromString(String? roleString) {
//     switch (roleString?.toLowerCase()) {
//       case 'nurse':
//         return UserRole.nurse;
//       case 'doctor':
//         return UserRole.doctor;
//       case 'admin':
//         return UserRole.admin;
//       default:
//         return UserRole.nurse;
//     }
//   }

//   /// Set selected role before login
//   void setRole(UserRole role) {
//     state = state.copyWith(selectedRole: role);
//   }

//   /// Toggle show password
//   void togglePassword() {
//     state = state.copyWith(showPassword: !state.showPassword);
//   }

//   /// Toggle remember me
//   void toggleRememberMe() {
//     state = state.copyWith(rememberMe: !state.rememberMe);
//   }

//   /// Clear validation errors
//   void clearErrors() {
//     state = state.copyWith(emailError: null, passwordError: null);
//   }

//   /// Sign in method
//   Future<bool> signIn(String email, String password) async {
//     clearErrors();

//     final emailError = Validators.validateEmail(email);
//     final passwordError = Validators.validatePassword(password);

//     if (emailError != null || passwordError != null) {
//       state = state.copyWith(
//         emailError: emailError,
//         passwordError: passwordError,
//       );
//       return false;
//     }

//     state = state.copyWith(isSubmitting: true);

//     try {
//       final response = await _authService.signIn(email, password);

//       if (response.user != null) {
//         final userData = await _authService.getUserData(response.user!.id);

//         if (userData != null) {
//           final role = _getRoleFromString(userData['role']);

//           // Role mismatch
//           if (role != state.selectedRole) {
//             state = state.copyWith(
//               isSubmitting: false,
//               errorMessage: 'Invalid credentials for selected role',
//             );
//             await _authService.signOut();
//             return false;
//           }

//           // Password expiry check
//           final passwordLastChanged =
//               DateTime.parse(userData['password_changed_at']);
//           final daysSinceChange =
//               DateTime.now().difference(passwordLastChanged).inDays;

//           if (daysSinceChange > 90) {
//             state = state.copyWith(
//               isSubmitting: false,
//               errorMessage:
//                   'Your password has expired. Please contact IT support.',
//             );
//             await _authService.signOut();
//             return false;
//           }

//           state = state.copyWith(
//             isSubmitting: false,
//             user: response.user,
//             userRole: role,
//             userData: userData,
//           );

//           // Set screen after login
//           _setScreenForRole(role);

//           return true;
//         } else {
//           state = state.copyWith(
//             isSubmitting: false,
//             errorMessage: 'User data not found',
//           );
//           return false;
//         }
//       } else {
//         state = state.copyWith(
//           isSubmitting: false,
//           errorMessage: 'Invalid email or password',
//         );
//         return false;
//       }
//     } catch (e) {
//       String message = 'An unexpected error occurred';
//       if (e is AuthException) {
//         if (e.message.contains('Invalid login credentials')) {
//           message = 'Invalid email or password. Please try again.';
//         } else if (e.message.contains('Email not confirmed')) {
//           message = 'Please confirm your email before logging in.';
//         } else {
//           message = e.message;
//         }
//       }
//       state = state.copyWith(isSubmitting: false, errorMessage: message);
//       return false;
//     }
//   }

//   /// Sign out
//   Future<void> signOut() async {
//     await _authService.signOut();
//     state = const AuthState();

//     // Reset to default screen
//     _ref.read(currentScreenProvider.notifier).state = AppScreen.dashboard;
//   }

//   /// Set screen based on user role
//   void _setScreenForRole(UserRole role) {
//     final screen = switch (role) {
//       UserRole.nurse => AppScreen.nursesDashboard,
//       UserRole.doctor => AppScreen.doctorsDashboard,
//       UserRole.admin => AppScreen.dashboard,
//     };

//     _ref.read(currentScreenProvider.notifier).state = screen;
//   }
// }
// //-----------------------------------------------------------------------------04-1-2025-----------updated at 10:03------------------//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
// import '../models/auth_model.dart';
// import '../services/auth_service.dart';
// import '../utils/validators.dart';

// /// --- Supabase client provider ---
// final supabaseProvider = Provider<SupabaseClient>((ref) {
//   return Supabase.instance.client;
// });

// /// --- AuthService provider ---
// final authServiceProvider = Provider<AuthService>((ref) {
//   return AuthService(ref.watch(supabaseProvider));
// });

// /// --- AppScreen enum ---
// enum AppScreen {
//   dashboard, // Admin
//   doctorsDashboard, // Doctor
//   nursesDashboard, // Nurse
//   patients,
//   appointments,
//   analytics,
//   settings,
// }

// /// --- Current screen provider ---
// final currentScreenProvider = StateProvider<AppScreen>((ref) {
//   return AppScreen.dashboard;
// });

// /// --- AuthNotifier provider ---
// final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   return AuthNotifier(ref.watch(authServiceProvider), ref);
// });

// /// --- Role config provider ---
// final roleConfigProvider = Provider.family<RoleConfig, UserRole>((ref, role) {
//   switch (role) {
//     case UserRole.nurse:
//       return const RoleConfig(
//         title: 'Nurse Login',
//         description: 'Access your nursing dashboard',
//         iconAsset: 'heart_pulse',
//         colorValue: 0xFF22C55E,
//         bgColorValue: 0x1A22C55E,
//       );
//     case UserRole.doctor:
//       return const RoleConfig(
//         title: 'Doctor Login',
//         description: 'Access your doctor dashboard',
//         iconAsset: 'stethoscope',
//         colorValue: 0xFF3B82F6,
//         bgColorValue: 0x1A3B82F6,
//       );
//     case UserRole.admin:
//       return const RoleConfig(
//         title: 'Admin Login',
//         description: 'Access all hospital dashboards',
//         iconAsset: 'shield',
//         colorValue: 0xFFA855F7,
//         bgColorValue: 0x1AA855F7,
//       );
//   }
// });

// /// --- AppUser provider ---
// final appUserProvider = Provider<AppUser?>((ref) {
//   final authState = ref.watch(authStateProvider);

//   if (authState.user != null && authState.userRole != null) {
//     return AppUser(
//       id: authState.user!.id,
//       name: authState.userData?['name'] ?? authState.user!.email ?? 'User',
//       email: authState.user!.email ?? '',
//       role: authState.userRole!,
//     );
//   }
//   return null;
// });

// /// --- AuthNotifier ---
// class AuthNotifier extends StateNotifier<AuthState> {
//   final AuthService _authService;
//   final Ref _ref;

//   AuthNotifier(this._authService, this._ref) : super(const AuthState()) {
//     _restoreSession();
//   }

//   /// --- Restore session ---
//   Future<void> _restoreSession() async {
//     final user = _authService.currentUser;
//     if (user == null) return;

//     final userData = await _authService.getUserData(user.id);
//     if (userData == null) return;

//     final role = _getRoleFromString(userData['role']);

//     state = state.copyWith(
//       user: user,
//       userRole: role,
//       selectedRole: role, // ensure selectedRole is set
//       userData: userData,
//     );

//     _setDefaultScreen(role);
//   }

//   UserRole _getRoleFromString(String? role) {
//     switch (role?.toLowerCase()) {
//       case 'admin':
//         return UserRole.admin;
//       case 'doctor':
//         return UserRole.doctor;
//       case 'nurse':
//       default:
//         return UserRole.nurse;
//     }
//   }

//   /// --- UI helpers ---
//   void setRole(UserRole role) => state = state.copyWith(selectedRole: role);

//   void togglePassword() =>
//       state = state.copyWith(showPassword: !state.showPassword);

//   void toggleRememberMe() =>
//       state = state.copyWith(rememberMe: !state.rememberMe);

//   void clearErrors() =>
//       state = state.copyWith(emailError: null, passwordError: null);

//   /// --- Sign In ---
//   Future<bool> signIn(String email, String password) async {
//     clearErrors();

//     final emailError = Validators.validateEmail(email);
//     final passwordError = Validators.validatePassword(password);

//     if (emailError != null || passwordError != null) {
//       state = state.copyWith(
//         emailError: emailError,
//         passwordError: passwordError,
//       );
//       return false;
//     }

//     state = state.copyWith(isSubmitting: true);

//     try {
//       final response = await _authService.signIn(email, password);
//       final user = response.user;

//       if (user == null) {
//         state = state.copyWith(
//           isSubmitting: false,
//           errorMessage: 'Invalid email or password',
//         );
//         return false;
//       }

//       final userData = await _authService.getUserData(user.id);
//       if (userData == null) {
//         state = state.copyWith(
//           isSubmitting: false,
//           errorMessage: 'User data not found',
//         );
//         return false;
//       }

//       final role = _getRoleFromString(userData['role']);

//       // Role mismatch protection
//       if (role != state.selectedRole) {
//         await _authService.signOut();
//         state = state.copyWith(
//           isSubmitting: false,
//           errorMessage: 'Invalid credentials for selected role',
//         );
//         return false;
//       }

//       state = state.copyWith(
//         isSubmitting: false,
//         user: user,
//         userRole: role,
//         selectedRole: role, // ensure selectedRole is synced
//         userData: userData,
//       );

//       _setDefaultScreen(role);
//       return true;
//     } catch (e) {
//       state = state.copyWith(
//         isSubmitting: false,
//         errorMessage: e.toString(),
//       );
//       return false;
//     }
//   }

//   /// --- Sign Out ---
//   Future<void> signOut() async {
//     await _authService.signOut();
//     state = const AuthState();
//     _ref.read(currentScreenProvider.notifier).state = AppScreen.dashboard;
//   }

//   /// --- Default screen by role ---
//   void _setDefaultScreen(UserRole role) {
//     final screen = switch (role) {
//       UserRole.admin => AppScreen.dashboard, // admin always sees full dashboard
//       UserRole.doctor => AppScreen.doctorsDashboard,
//       UserRole.nurse => AppScreen.nursesDashboard,
//     };

//     _ref.read(currentScreenProvider.notifier).state = screen;
//   }
// }
//-----------------------------------------------------------------------------05-1-2025-----------updated------------------//

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';

/// --- Supabase client provider ---
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// --- AuthService provider ---
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(supabaseProvider));
});

/// --- AppScreen enum ---
enum AppScreen {
  dashboard,
  doctorsDashboard,
  nursesDashboard,
  patients,
  appointments,
  admissions,
  discharges,
  notifications,
  analytics,
  settings,

  // ✅ NEW SCREENS
  shiftScheduling,
  handover,
  nurseAlerts,
  reminders,
}

/// --- Current screen provider ---
final currentScreenProvider = StateProvider<AppScreen>((ref) {
  return AppScreen.dashboard;
});

/// --- AuthNotifier provider ---
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider), ref);
});

/// --- Role config provider ---
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

/// --- AppUser provider ---
final appUserProvider = Provider<AppUser?>((ref) {
  final authState = ref.watch(authStateProvider);

  if (authState.user != null && authState.userRole != null) {
    return AppUser(
      id: authState.user!.id,
      name: authState.userData?['name'] ?? authState.user!.email ?? 'User',
      email: authState.user!.email ?? '',
      role: authState.userRole!,
    );
  }
  return null;
});

/// --- AuthNotifier ---
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final Ref _ref;

  AuthNotifier(this._authService, this._ref) : super(const AuthState()) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final user = _authService.currentUser;
    if (user == null) return;

    final userData = await _authService.getUserData(user.id);
    if (userData == null) return;

    final role = _getRoleFromString(userData['role']);

    state = state.copyWith(
      user: user,
      userRole: role,
      selectedRole: role,
      userData: userData,
    );

    _setDefaultScreen(role);
  }

  UserRole _getRoleFromString(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'doctor':
        return UserRole.doctor;
      case 'nurse':
      default:
        return UserRole.nurse;
    }
  }

  void setRole(UserRole role) => state = state.copyWith(selectedRole: role);
  void togglePassword() =>
      state = state.copyWith(showPassword: !state.showPassword);
  void toggleRememberMe() =>
      state = state.copyWith(rememberMe: !state.rememberMe);
  void clearErrors() =>
      state = state.copyWith(emailError: null, passwordError: null);

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
      final user = response.user;

      if (user == null) {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: 'Invalid email or password',
        );
        return false;
      }

      final userData = await _authService.getUserData(user.id);
      if (userData == null) {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: 'User data not found',
        );
        return false;
      }

      final role = _getRoleFromString(userData['role']);

      if (role != state.selectedRole) {
        await _authService.signOut();
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: 'Invalid credentials for selected role',
        );
        return false;
      }

      state = state.copyWith(
        isSubmitting: false,
        user: user,
        userRole: role,
        selectedRole: role,
        userData: userData,
      );

      _setDefaultScreen(role);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const AuthState();
    _ref.read(currentScreenProvider.notifier).state = AppScreen.dashboard;
  }

  void _setDefaultScreen(UserRole role) {
    final screen = switch (role) {
      UserRole.admin => AppScreen.dashboard,
      UserRole.doctor => AppScreen.doctorsDashboard,
      UserRole.nurse => AppScreen.nursesDashboard,
    };

    _ref.read(currentScreenProvider.notifier).state = screen;
  }
}
