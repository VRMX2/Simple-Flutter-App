import 'package:flutter/material.dart';

class AppColors{
	static const Color primary = Color(0xFF6C63FF);
	static const Color secondary = Color(0xFF50E3C2);
	static const Color accent = Color(0xFFFF6B9D);
	static const Color background = Color(0xFFF8FAFF);
	static const Color surface = Color(0xFFFFFFFF);
	static const Color textPrimary= Color(0xFF2D3748);
	static const Color textSecondary = Color(0xFF718096);
	static const Color error = Color(0xFFE53E3E);
	static const Color success = Color(0xFF38A169);
	static const Color warning = Color(0xFFD69E2E);

	static const LinearGradient primaryGradient = LinearGradient(
	begin:Alignment.topLeft,
	end:Alignment.bottomRight,
    colors: [primary,Color(0xFF9F7AEA)]
	);

	static const LinearGradient backgroundGradient = LinearGradient(
	begin:Alignment.topCenter,
	end:Alignment.bottomCenter,
    colors:[Color(0xFFF8FAFF),Color(0xFFE6F3FF)]
	);
}