import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width = double.infinity,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: 56,
        decoration: BoxDecoration(
          gradient: widget.isOutlined ? null : AppColors.primaryGradient,
          border: widget.isOutlined 
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: !widget.isOutlined && !_isPressed
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        transform: Matrix4.identity()
          ..scale(_isPressed ? 0.95 : 1.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              alignment: Alignment.center,
              child: widget.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.text,
                      style: widget.isOutlined
                          ? AppTextStyles.button.copyWith(
                              color: AppColors.primary,
                            )
                          : AppTextStyles.button,
                    ),
            ),
          ),
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: 0.3, duration: 600.ms);
  }
}