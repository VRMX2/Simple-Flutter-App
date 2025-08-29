import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles{
	static TextStyle get heading1 => GoogleFonts.inter(
		fontSize: 32,
	fontWeight: FontWeight.bold,
	color:AppColors.textPrimary,
	height: 1.2
	);


	static TextStyle get heading2 =>GoogleFonts.inter(
	fontSize: 24,
	fontWeight: FontWeight.w600,
	color:AppColors.textPrimary,
	height: 1.3
	);


	static TextStyle get bodyLarge  => GoogleFonts.inter(
		fontSize: 16,
	fontWeight: FontWeight.w400,
	color:AppColors.textPrimary,
	height: 1.5
	);

	static TextStyle get bodyMedium  => GoogleFonts.inter(
		fontSize: 14,
	fontWeight: FontWeight.w400,
	color:AppColors.textPrimary,
	height: 1.4
	);

	static TextStyle get button => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
	);

	static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}