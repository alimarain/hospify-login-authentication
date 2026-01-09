import 'package:flutter/material.dart';
import 'package:hospify/utils/app_colors copy.dart';
import '../models/auth_model.dart';

class RoleTab extends StatefulWidget {
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

  @override
  State<RoleTab> createState() => _RoleTabState();
}

class _RoleTabState extends State<RoleTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant RoleTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger bounce when tab becomes selected
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _activeColor {
    switch (widget.role) {
      case UserRole.nurse:
        return AppColors.nurseColor;
      case UserRole.doctor:
        return AppColors.doctorColor;
      case UserRole.admin:
        return AppColors.adminColor;
    }
  }

  Color get _activeBg {
    switch (widget.role) {
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
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected ? _activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _bounceAnimation,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  offset:
                      widget.isSelected ? const Offset(0, -0.05) : Offset.zero,
                  child: Icon(
                    widget.icon,
                    size: 16,
                    color: widget.isSelected
                        ? _activeColor
                        : AppColors.mutedForeground,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.isSelected
                      ? _activeColor
                      : AppColors.mutedForeground,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
