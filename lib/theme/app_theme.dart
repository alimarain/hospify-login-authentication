// import 'package:flutter/material.dart';

// class AppTheme {
//   static const Color primary = Color(0xFF0EA5E9);
//   static const Color primaryLight = Color(0xFF38BDF8);
//   static const Color secondary = Color(0xFF1E293B);
//   static const Color background = Color(0xFFF8FAFC);
//   static const Color surface = Color(0xFFFFFFFF);
//   static const Color cardBackground = Color(0xFFFFFFFF);

//   static const Color statusMild = Color(0xFF22C55E);
//   static const Color statusStable = Color(0xFF3B82F6);
//   static const Color statusCritical = Color(0xFFEF4444);

//   static const Color textPrimary = Color(0xFF0F172A);
//   static const Color textSecondary = Color(0xFF64748B);
//   static const Color textMuted = Color(0xFF94A3B8);

//   static const Color border = Color(0xFFE2E8F0);

//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: ColorScheme.light(
//         primary: primary,
//         secondary: secondary,
//         surface: surface,
//         background: background,
//       ),
//       scaffoldBackgroundColor: background,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: surface,
//         foregroundColor: textPrimary,
//         elevation: 0,
//       ),
//       cardTheme: CardTheme(
//         color: cardBackground,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//           side: const BorderSide(color: border),
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: surface,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: border),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: border),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: primary, width: 2),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppColors {
//   // Base Backgrounds
//   static const Color background = Color(0xFF1E1E2D);
//   static const Color cardBackground = Color(0xFF2D2D3F); // Keeping for backward compatibility
//   static const Color card = Color(0xFF2D2D3F); // Alias for 'card'
//   static const Color surface = Color(0xFF2D2D3F); // Alias for 'surface'

//   // Borders & Dividers
//   static const Color border = Color(0xFF3E3E4E);

//   // Text Colors
//   static const Color textPrimary = Colors.white;
//   static const Color textSecondary = Colors.grey;
//   static const Color textMuted = Color(0xFF9E9E9E); // Muted grey for icons/secondary info
//   static const Color foreground = Colors.white; // Alias for 'foreground'
//   static const Color mutedForeground = Colors.grey; // Alias for 'mutedForeground'

//   // Accents
//   static const Color primaryAccent = Color(0xFF6C63FF); // Purple
//   static const Color secondaryAccent = Color(0xFF00D2B4); // Cyan/Teal
//   static const Color orangeAccent = Color(0xFFFF8C00);
//   static const Color redAccent = Color(0xFFFF5252);

//   // Status Colors
//   static const Color statusMild = Color(0xFF4CAF50); // Green
//   static const Color statusStable = Color(0xFF2196F3); // Blue
//   static const Color statusCritical = Color(0xFFF44336); // Red

//   // Nurse Specific Colors
//   static const Color nurseColor = Color(0xFFEC407A); // Pink
//   static const Color nurseBg = Color(0xFF38232C); // Dark muted pink background
// }

// class AppTheme {
//   // Direct static accessors for colors
//   static const Color surface = AppColors.surface;
//   static const Color background = AppColors.background;
//   static const Color border = AppColors.border;
//   static const Color primary = AppColors.primaryAccent;

//   // Text colors
//   static const Color textPrimary = AppColors.textPrimary;
//   static const Color textSecondary = AppColors.textSecondary;
//   static const Color textMuted = AppColors.textMuted;

//   // Status colors used in Stats Cards
//   static const Color statusMild = AppColors.statusMild;
//   static const Color statusStable = AppColors.statusStable;
//   static const Color statusCritical = AppColors.statusCritical;

//   static ThemeData get darkTheme {
//     return ThemeData.dark().copyWith(
//       scaffoldBackgroundColor: AppColors.background,
//       cardColor: AppColors.card,

//       // Text Theme
//       textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
//         bodyColor: AppColors.textPrimary,
//         displayColor: AppColors.textPrimary,
//       ),

//       // Icon Theme
//       iconTheme: const IconThemeData(color: AppColors.textMuted),

//       // AppBar Theme
//       appBarTheme: const AppBarTheme(
//         backgroundColor: AppColors.background,
//         elevation: 0,
//         iconTheme: IconThemeData(color: AppColors.textPrimary),
//         titleTextStyle: TextStyle(
//           color: AppColors.textPrimary,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),

//       // Input Decoration Theme (for TextField)
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.surface,
//         hintStyle: const TextStyle(color: AppColors.textMuted),
//         contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.border),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.border),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.primaryAccent),
//         ),
//       ),

//       // Divider Theme
//       dividerColor: AppColors.border,

//       // Color Scheme
//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.primaryAccent,
//         secondary: AppColors.secondaryAccent,
//         surface: AppColors.surface,
//         background: AppColors.background,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ---------------------------------------------------------------------------
  // EXISTING COLORS (Do not remove - used by other screens)
  // ---------------------------------------------------------------------------
  static const Color background = Color(0xFF1E1E2D);
  static const Color cardBackground = Color(0xFF2D2D3F);
  static const Color card = Color(0xFF2D2D3F);
  static const Color surface = Color(0xFF2D2D3F);
  static const Color border = Color(0xFF3E3E4E);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey;
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color foreground = Colors.white;
  static const Color mutedForeground = Colors.grey;

  static const Color primaryAccent = Color(0xFF6C63FF);
  static const Color secondaryAccent = Color(0xFF00D2B4);
  static const Color orangeAccent = Color(0xFFFF8C00);
  static const Color redAccent = Color(0xFFFF5252);

  static const Color statusMild = Color(0xFF4CAF50);
  static const Color statusStable = Color(0xFF2196F3);
  static const Color statusCritical = Color(0xFFF44336);

  static const Color nurseColor = Color(0xFFEC407A);
  static const Color nurseBg = Color(0xFF38232C);

  // ---------------------------------------------------------------------------
  // NEW COLORS (For Light Theme support in main.dart)
  // ---------------------------------------------------------------------------
  static const Color backgroundLight = Color(0xFFF4F6F8);
  static const Color surfaceLight = Colors.white;
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color textPrimaryLight = Color(0xFF1E1E2D);
  static const Color textSecondaryLight = Color(0xFF637381);
}

class AppTheme {
  // ---------------------------------------------------------------------------
  // STATIC ACCESSORS (Preserved for existing screens)
  // ---------------------------------------------------------------------------
  static const Color surface = AppColors.surface;
  static const Color background = AppColors.background;
  static const Color border = AppColors.border;
  static const Color primary = AppColors.primaryAccent;

  static const Color textPrimary = AppColors.textPrimary;
  static const Color textSecondary = AppColors.textSecondary;
  static const Color textMuted = AppColors.textMuted;

  static const Color statusMild = AppColors.statusMild;
  static const Color statusStable = AppColors.statusStable;
  static const Color statusCritical = AppColors.statusCritical;

  static var cardColor;

  // ---------------------------------------------------------------------------
  // DARK THEME (Existing)
  // ---------------------------------------------------------------------------
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.card,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textMuted),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryAccent),
        ),
      ),
      dividerColor: AppColors.border,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryAccent,
        secondary: AppColors.secondaryAccent,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.redAccent,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LIGHT THEME (New - Added for main.dart)
  // ---------------------------------------------------------------------------
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.surfaceLight,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: AppColors.textPrimaryLight,
        displayColor: AppColors.textPrimaryLight,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondaryLight),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        hintStyle: const TextStyle(color: AppColors.textSecondaryLight),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryAccent),
        ),
      ),
      dividerColor: AppColors.borderLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryAccent,
        secondary: AppColors.secondaryAccent,
        surface: AppColors.surfaceLight,
        background: AppColors.backgroundLight,
        error: AppColors.redAccent,
      ),
    );
  }
}
