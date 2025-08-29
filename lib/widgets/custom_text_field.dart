import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.surface,
            border: Border.all(
              color: _isFocused 
                  ? AppColors.primary 
                  : AppColors.textSecondary.withOpacity(0.2),
              width: _isFocused ? 2 : 1,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType,
            style: AppTextStyles.bodyLarge,
            onTap: () => setState(() => _isFocused = true),
            onEditingComplete: () => setState(() => _isFocused = false),
            onFieldSubmitted: (_) => setState(() => _isFocused = false),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused 
                          ? AppColors.primary 
                          : AppColors.textSecondary,
                    )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () => setState(() => _obscureText = !_obscureText),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    ).animate()
      .fadeIn(duration: 500.ms)
      .slideX(begin: -0.1, duration: 500.ms);
  }
}