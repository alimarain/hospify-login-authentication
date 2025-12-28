import 'package:flutter/material.dart';
import 'package:hospify/utils/app_colors%20copy.dart';
import '../models/auth_model.dart';

class RoleTab extends StatelessWidget {
  final UserRole role;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String label;

  const RoleTab({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  Color get _activeColor {
    switch (role) {
      case UserRole.nurse:
        return AppColors.nurseColor;
      case UserRole.doctor:
        return AppColors.doctorColor;
      case UserRole.admin:
        return AppColors.adminColor;
    }
  }

  Color get _activeBg {
    switch (role) {
      case UserRole.nurse:
        return AppColors.nurseBg;
      case UserRole.doctor:
        return AppColors.doctorBg;
      case UserRole.admin:
        return AppColors.adminBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? _activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? _activeColor : AppColors.mutedForeground,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? _activeColor : AppColors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
