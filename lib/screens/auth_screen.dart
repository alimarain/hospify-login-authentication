// // screens/auth_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/app_colors%20copy.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import '../models/auth_model.dart';
// import '../providers/auth_provider.dart';
// import '../widgets/role_tab.dart';
// import '../widgets/custom_text_field.dart';
// import '../widgets/custom_checkbox.dart';
// import 'nurse_dashboard.dart';
// import 'doctor_dashboard.dart';
// import 'dashboard_screen.dart';

// class AuthScreen extends ConsumerStatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   ConsumerState<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends ConsumerState<AuthScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSubmit() async {
//     final success = await ref.read(authStateProvider.notifier).signIn(
//           _emailController.text,
//           _passwordController.text,
//         );

//     if (success && mounted) {
//       final authState = ref.read(authStateProvider);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Welcome back!'), backgroundColor: Colors.green),
//       );

//       // Navigate to appropriate dashboard based on role
//       Widget dashboard;
//       switch (authState.userRole) {
//         case UserRole.nurse:
//           dashboard = const NurseDashboard();
//           break;
//         case UserRole.doctor:
//           dashboard = const DoctorDashboard();
//           break;
//         case UserRole.admin:
//           dashboard = const DashboardScreen();
//           break;
//         default:
//           return;
//       }

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => dashboard),
//       );
//     } else if (mounted) {
//       final error = ref.read(authStateProvider).errorMessage;
//       if (error != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(error), backgroundColor: AppColors.destructive),
//         );
//       }
//     }
//   }

//   void _showInfoSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: AppColors.infoColor),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authStateProvider);
//     final roleConfig = ref.watch(roleConfigProvider(authState.selectedRole));
//     final notifier = ref.read(authStateProvider.notifier);

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(ResponsiveUtils.getPadding(context)),
//             child: SizedBox(
//               width: ResponsiveUtils.getMaxWidth(context),
//               child: Column(
//                 children: [
//                   // Role Tabs
//                   Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: AppColors.card,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.border),
//                     ),
//                     child: Row(
//                       children: [
//                         RoleTab(
//                           role: UserRole.nurse,
//                           isSelected: authState.selectedRole == UserRole.nurse,
//                           onTap: () => notifier.setRole(UserRole.nurse),
//                           icon: Icons.favorite,
//                           label: 'Nurse',
//                         ),
//                         RoleTab(
//                           role: UserRole.doctor,
//                           isSelected: authState.selectedRole == UserRole.doctor,
//                           onTap: () => notifier.setRole(UserRole.doctor),
//                           icon: Icons.medical_services,
//                           label: 'Doctor',
//                         ),
//                         RoleTab(
//                           role: UserRole.admin,
//                           isSelected: authState.selectedRole == UserRole.admin,
//                           onTap: () => notifier.setRole(UserRole.admin),
//                           icon: Icons.shield,
//                           label: 'Admin',
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Login Card
//                   Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.card,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: AppColors.border),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.3),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         // Header
//                         Padding(
//                           padding: const EdgeInsets.all(32),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 64,
//                                 height: 64,
//                                 decoration: BoxDecoration(
//                                   color: Color(roleConfig.bgColorValue),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   _getRoleIcon(authState.selectedRole),
//                                   size: 32,
//                                   color: Color(roleConfig.colorValue),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 roleConfig.title,
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(roleConfig.colorValue),
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 roleConfig.description,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: AppColors.mutedForeground,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Form
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
//                           child: Column(
//                             children: [
//                               CustomTextField(
//                                 controller: _emailController,
//                                 label: 'Employee ID',
//                                 hint: 'Enter your employee ID',
//                                 prefixIcon: Icons.person_outline,
//                                 errorText: authState.emailError,
//                                 enabled: !authState.isSubmitting,
//                               ),
//                               const SizedBox(height: 20),
//                               CustomTextField(
//                                 controller: _passwordController,
//                                 label: 'Password',
//                                 hint: 'Enter your password',
//                                 prefixIcon: Icons.lock_outline,
//                                 obscureText: !authState.showPassword,
//                                 errorText: authState.passwordError,
//                                 enabled: !authState.isSubmitting,
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     authState.showPassword
//                                         ? Icons.visibility_off
//                                         : Icons.visibility,
//                                     color: AppColors.mutedForeground,
//                                     size: 18,
//                                   ),
//                                   onPressed: notifier.togglePassword,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),

//                               // Remember & Forgot
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomCheckbox(
//                                     value: authState.rememberMe,
//                                     label: 'Remember me',
//                                     onChanged: (_) =>
//                                         notifier.toggleRememberMe(),
//                                   ),
//                                   TextButton(
//                                     onPressed: () => _showInfoSnackbar(
//                                       'Please contact Admin for password reset.',
//                                     ),
//                                     child: Text(
//                                       'Forgot Password?',
//                                       style: TextStyle(
//                                         color: Color(roleConfig.colorValue),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),

//                               // Submit Button
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 48,
//                                 child: ElevatedButton(
//                                   onPressed: authState.isSubmitting
//                                       ? null
//                                       : _handleSubmit,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.primary,
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   child: authState.isSubmitting
//                                       ? const SizedBox(
//                                           width: 20,
//                                           height: 20,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                             color: Colors.white,
//                                           ),
//                                         )
//                                       : const Text(
//                                           'Sign In',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),

//                               // Contact Admin
//                               Wrap(
//                                 alignment: WrapAlignment.center,
//                                 children: [
//                                   const Text(
//                                     'New staff member? ',
//                                     style: TextStyle(
//                                       color: AppColors.mutedForeground,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () => _showInfoSnackbar(
//                                       'Please contact the Admin department for registration.',
//                                     ),
//                                     style: TextButton.styleFrom(
//                                       padding: EdgeInsets.zero,
//                                       minimumSize: Size.zero,
//                                       tapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                     ),
//                                     child: Text(
//                                       'Contact Admin for registration',
//                                       style: TextStyle(
//                                         color: Color(roleConfig.colorValue),
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Security Note
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: AppColors.infoBg,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                           color: AppColors.infoColor.withOpacity(0.2)),
//                     ),
//                     child: RichText(
//                       text: const TextSpan(
//                         style: TextStyle(
//                             fontSize: 14, color: AppColors.foreground),
//                         children: [
//                           TextSpan(
//                             text: 'Note: ',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.infoColor,
//                             ),
//                           ),
//                           TextSpan(
//                             text:
//                                 'For security purposes, your password will expire every 90 days. Contact IT support if you need assistance.',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   IconData _getRoleIcon(UserRole role) {
//     switch (role) {
//       case UserRole.nurse:
//         return Icons.favorite;
//       case UserRole.doctor:
//         return Icons.medical_services;
//       case UserRole.admin:
//         return Icons.shield;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/utils/app_colors copy.dart';
import 'package:hospify/utils/responsive_utils.dart';
import '../models/auth_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/role_tab.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_checkbox.dart';
import 'main_screen.dart'; // MainScreen handles dashboards + sidebar

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final success = await ref.read(authStateProvider.notifier).signIn(
          _emailController.text,
          _passwordController.text,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome back!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to MainScreen which handles sidebar & dashboards
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else if (mounted) {
      final error = ref.read(authStateProvider).errorMessage;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error), backgroundColor: AppColors.destructive),
        );
      }
    }
  }

  void _showInfoSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.infoColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final roleConfig = ref.watch(roleConfigProvider(authState.selectedRole));
    final notifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveUtils.getPadding(context)),
              child: SizedBox(
                width: ResponsiveUtils.getMaxWidth(context),
                child: Column(
                  children: [
                    // Role Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          RoleTab(
                            role: UserRole.nurse,
                            isSelected:
                                authState.selectedRole == UserRole.nurse,
                            onTap: () => notifier.setRole(UserRole.nurse),
                            icon: Icons.favorite,
                            label: 'Nurse',
                          ),
                          RoleTab(
                            role: UserRole.doctor,
                            isSelected:
                                authState.selectedRole == UserRole.doctor,
                            onTap: () => notifier.setRole(UserRole.doctor),
                            icon: Icons.medical_services,
                            label: 'Doctor',
                          ),
                          RoleTab(
                            role: UserRole.admin,
                            isSelected:
                                authState.selectedRole == UserRole.admin,
                            onTap: () => notifier.setRole(UserRole.admin),
                            icon: Icons.shield,
                            label: 'Admin',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Login Card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                        child: Column(
                          children: [
                            // Header (updates dynamically with RoleTab)
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Color(roleConfig.bgColorValue),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getRoleIcon(authState.selectedRole),
                                size: 32,
                                color: Color(roleConfig.colorValue),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              roleConfig.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(roleConfig.colorValue),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              roleConfig.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.mutedForeground,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Form Fields
                            CustomTextField(
                              controller: _emailController,
                              label: 'Employee ID',
                              hint: 'Enter your employee ID',
                              prefixIcon: Icons.person_outline,
                              errorText: authState.emailError,
                              enabled: !authState.isSubmitting,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: _passwordController,
                              label: 'Password',
                              hint: 'Enter your password',
                              prefixIcon: Icons.lock_outline,
                              obscureText: !authState.showPassword,
                              errorText: authState.passwordError,
                              enabled: !authState.isSubmitting,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  authState.showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.mutedForeground,
                                  size: 18,
                                ),
                                onPressed: notifier.togglePassword,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Remember & Forgot
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomCheckbox(
                                  value: authState.rememberMe,
                                  label: 'Remember me',
                                  onChanged: (_) => notifier.toggleRememberMe(),
                                ),
                                TextButton(
                                  onPressed: () => _showInfoSnackbar(
                                    'Please contact Admin for password reset.',
                                  ),
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: authState.isSubmitting
                                    ? null
                                    : _handleSubmit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: authState.isSubmitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Security Note
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.infoBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.infoColor.withOpacity(0.2)),
                      ),
                      child: const Text(
                        'Note: For security purposes, your password will expire every 90 days. Contact IT support if you need assistance.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.foreground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.nurse:
        return Icons.favorite;
      case UserRole.doctor:
        return Icons.medical_services;
      case UserRole.admin:
        return Icons.shield;
    }
  }
}
