import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// 1. ResponsiveUtils (Preserved & Enhanced)
// -----------------------------------------------------------------------------
class ResponsiveUtils {
  // Existing breakpoints
  static const double mobileBreakpoint = 480;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;

  // Existing methods
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint &&
      MediaQuery.of(context).size.width < desktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;

  static double getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < tabletBreakpoint) return width * 0.9;
    if (width < desktopBreakpoint) return 450;
    return 420;
  }

  static double getPadding(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 24;
    return 32;
  }

  static double getFontSize(BuildContext context, double base) {
    if (isMobile(context)) return base * 0.9;
    return base;
  }

  // --- NEW: Helper for dynamic Grid Counts on Dashboard ---
  static int getCrossAxisCount(BuildContext context, {int base = 4}) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1400) return base; // Wide Desktop
    if (width >= 1100) return base - 1; // Desktop
    if (width >= 700) return 2; // Tablet
    return 1; // Mobile
  }
}

// -----------------------------------------------------------------------------
// 2. Responsive Widget (Preserved & Enhanced)
// -----------------------------------------------------------------------------
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  // These static checks use your specific breakpoints (850/1100)
  // I kept them exactly as they were in your snippet.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1100) {
      return desktop;
    } else if (size.width >= 850 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

// -----------------------------------------------------------------------------
// 3. ScreenType (Preserved)
// -----------------------------------------------------------------------------
class ScreenType {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
