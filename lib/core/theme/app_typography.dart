import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme get textTheme {
    return GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 57,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 45,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 36,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }
}
