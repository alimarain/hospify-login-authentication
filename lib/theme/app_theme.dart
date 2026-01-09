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
// }import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppColors {
//   // ---------------------------------------------------------------------------
//   // TARGET THEME COLORS (True Dark / Zinc Palette)
//   // ---------------------------------------------------------------------------

//   // 1. Backgrounds
//   // Main screen background: Very deep black/zinc (Matches your screenshots)
//   static const Color background = Color(0xFF09090B);

//   // Card background: Slightly lighter dark grey (Zinc-900)
//   static const Color card = Color(0xFF18181B);
//   static const Color cardBackground = Color(0xFF18181B);
//   static const Color surface = Color(0xFF18181B);

//   // 2. Borders
//   // Subtle dark grey to separate cards from background
//   static const Color border = Color(0xFF27272A);

//   // 3. Text Colors
//   static const Color textPrimary = Color(0xFFFAFAFA); // High contrast white
//   static const Color textSecondary = Color(0xFFA1A1AA); // Muted Zinc Grey
//   static const Color textMuted = Color(0xFF71717A); // Darker Grey
//   static const Color foreground = Colors.white;
//   static const Color mutedForeground = Colors.grey;

//   // 4. Accent Colors (UPDATED to Royal Blue)
//   // Changed from Purple (0xFF6C63FF) to Royal Blue (0xFF3B82F6)
//   static const Color primaryAccent = Color(0xFF3B82F6);

//   static const Color secondaryAccent = Color(0xFF14B8A6); // Teal (Orthopedics)
//   static const Color orangeAccent = Color(0xFFF97316); // Orange (Emergency)

//   // 5. Status Colors
//   static const Color redAccent = Color(0xFFEF4444); // Vibrant Red for Text
//   static const Color statusMild = Color(0xFF22C55E); // Green
//   static const Color statusStable = Color(0xFF3B82F6); // Blue
//   static const Color statusCritical =
//       Color(0xFFDC2626); // Deep Red (Icon Badges)

//   static const Color nurseColor = Color(0xFFEC407A);
//   static const Color nurseBg = Color(0xFF38232C);

//   // 6. Critical Alert Footer (Specific to your design)
//   static const Color criticalBg = Color(0xFF2A1212); // The Dark Red Background
//   static const Color criticalBorder = Color(0xFF451818); // The Dark Red Border

//   // ---------------------------------------------------------------------------
//   // LIGHT MODE COLORS (Unchanged)
//   // ---------------------------------------------------------------------------
//   static const Color backgroundLight = Color(0xFFF4F6F8);
//   static const Color surfaceLight = Colors.white;
//   static const Color borderLight = Color(0xFFE0E0E0);
//   static const Color textPrimaryLight = Color(0xFF1E1E2D);
//   static const Color textSecondaryLight = Color(0xFF637381);

//   static var inputFill;
// }

// class AppTheme {
//   // ---------------------------------------------------------------------------
//   // STATIC ACCESSORS
//   // ---------------------------------------------------------------------------
//   static const Color surface = AppColors.surface;
//   static const Color background = AppColors.background;
//   static const Color border = AppColors.border;
//   static const Color primary = AppColors.primaryAccent;

//   static const Color textPrimary = AppColors.textPrimary;
//   static const Color textSecondary = AppColors.textSecondary;
//   static const Color textMuted = AppColors.textMuted;

//   static const Color statusMild = AppColors.statusMild;
//   static const Color statusStable = AppColors.statusStable;
//   static const Color statusCritical = AppColors.statusCritical;

//   static const Color cardColor = AppColors.card;

//   // ---------------------------------------------------------------------------
//   // DARK THEME CONFIGURATION
//   // ---------------------------------------------------------------------------
//   static ThemeData get darkTheme {
//     return ThemeData.dark().copyWith(
//       scaffoldBackgroundColor: AppColors.background,
//       cardColor: AppColors.card,
//       canvasColor: AppColors.background, // Ensures Drawers match background

//       // Apply Google Fonts Inter to all text
//       textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
//         bodyColor: AppColors.textPrimary,
//         displayColor: AppColors.textPrimary,
//       ),

//       iconTheme: const IconThemeData(color: AppColors.textMuted),

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

//       // Updated Input Decoration to match the dark cards
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.surface, // Matches Card Color
//         hintStyle: const TextStyle(color: AppColors.textMuted),
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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

//       dividerColor: AppColors.border,

//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.primaryAccent,
//         secondary: AppColors.secondaryAccent,
//         surface: AppColors.surface,
//         background: AppColors.background,
//         error: AppColors.redAccent,
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------
//   // LIGHT THEME CONFIGURATION (Unchanged)
//   // ---------------------------------------------------------------------------
//   static ThemeData get lightTheme {
//     return ThemeData.light().copyWith(
//       scaffoldBackgroundColor: AppColors.backgroundLight,
//       cardColor: AppColors.surfaceLight,
//       textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
//         bodyColor: AppColors.textPrimaryLight,
//         displayColor: AppColors.textPrimaryLight,
//       ),
//       iconTheme: const IconThemeData(color: AppColors.textSecondaryLight),
//       appBarTheme: const AppBarTheme(
//         backgroundColor: AppColors.backgroundLight,
//         elevation: 0,
//         iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
//         titleTextStyle: TextStyle(
//           color: AppColors.textPrimaryLight,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.surfaceLight,
//         hintStyle: const TextStyle(color: AppColors.textSecondaryLight),
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.borderLight),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.borderLight),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.primaryAccent),
//         ),
//       ),
//       dividerColor: AppColors.borderLight,
//       colorScheme: const ColorScheme.light(
//         primary: AppColors.primaryAccent,
//         secondary: AppColors.secondaryAccent,
//         surface: AppColors.surfaceLight,
//         background: AppColors.backgroundLight,
//         error: AppColors.redAccent,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // -----------------------------------------------------------------------------
  // 01. BRAND & PRIMARY COLORS
  // -----------------------------------------------------------------------------
  static const Color primaryBlue = Color(0xFF3B82F6); // Vibrant Blue
  static const Color primaryDark =
      Color(0xFF1E293B); // Dark Slate (Text/Headers)
  static const Color background = Color(0xFFF8FAFC); // Light Grey Background
  static const Color surface = Colors.white;

  // -----------------------------------------------------------------------------
  // 02. DASHBOARD GRADIENTS (Matches the screenshot widgets)
  // -----------------------------------------------------------------------------
  static const Color statsBlueStart = Color(0xFF3B82F6);
  static const Color statsBlueEnd = Color(0xFF2563EB);

  static const Color statsPinkStart = Color(0xFFEC4899);
  static const Color statsPinkEnd = Color(0xFFDB2777);

  static const Color statsCyanStart = Color(0xFF06B6D4);
  static const Color statsCyanEnd = Color(0xFF0891B2);

  // -----------------------------------------------------------------------------
  // 03. WARD / SIDEBAR COLORS (Dark Theme Area)
  // -----------------------------------------------------------------------------
  static const Color wardBackground = Color(0xFF0F172A); // The dark sidebar bg
  static const Color wardSurface =
      Color(0xFF1E293B); // Lighter dark for cards in sidebar
  static const Color wardText = Colors.white;

  // -----------------------------------------------------------------------------
  // 04. STATUS COLORS
  // -----------------------------------------------------------------------------
  static const Color statusStable = Color(0xFF10B981); // Green
  static const Color statusCritical = Color(0xFFEF4444); // Red
  static const Color statusMild = Color(0xFF3B82F6); // Blue
  static const Color statusWarning = Color(0xFFF59E0B); // Orange

  // -----------------------------------------------------------------------------
  // 05. UI NEUTRALS
  // -----------------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color dividerColor = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF1F5F9);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      fontFamily: GoogleFonts.inter().fontFamily,

      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: primaryDark,
        surface: surface,
        background: background,
        error: statusCritical,
        onPrimary: Colors.white,
        onSurface: textPrimary,
      ),

      // Typography - Updated to match the clean dashboard look
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge:
            const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(
            color: textPrimary, fontWeight: FontWeight.w700, fontSize: 20),
        titleMedium: const TextStyle(
            color: textPrimary, fontWeight: FontWeight.w600, fontSize: 16),
        bodyLarge: const TextStyle(color: textPrimary, fontSize: 15),
        bodyMedium: const TextStyle(color: textSecondary, fontSize: 14),
      ),

      // -------------------------------------------------------------------------
      // PRESERVED CARD THEME (As requested)
      // -------------------------------------------------------------------------
      cardTheme: CardTheme(
        color: surface,
        elevation: 1.5,
        shadowColor: Colors.black.withOpacity(0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: dividerColor),
        ),
      ),

      // AppBar styling
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: background, // Blends into background like the design
        foregroundColor: textPrimary,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textSecondary),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
      ),

      // Input fields (Updated to be cleaner/lighter)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
            surface, // White background often looks cleaner on grey dashboards
        hoverColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 1.5),
        ),
        hintStyle: const TextStyle(color: textSecondary),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIconColor: textSecondary,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Chips / badges
      chipTheme: ChipThemeData(
        backgroundColor: inputFill,
        labelStyle:
            const TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide.none,
      ),
    );
  }
}
