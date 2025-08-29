import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2))
            .then()
            .scale(begin: const Offset(1.2, 1.2), end: const Offset(0.8, 0.8)),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}