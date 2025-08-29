import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../services/auth_service.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      User? user = _authService.currentUser;
      
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              user != null ? const HomeScreen() : const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  size: 60,
                  color: AppColors.primary,
                ),
              )
                  .animate()
                  .scale(duration: 1000.ms, curve: Curves.elasticOut)
                  .then()
                  .shimmer(duration: 1500.ms),
              const SizedBox(height: 40),
              Text(
                'Modern App',
                style: AppTextStyles.heading1.copyWith(
                  color: Colors.white,
                  fontSize: 36,
                ),
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 800.ms)
                  .slideY(begin: 0.3, duration: 800.ms),
              const SizedBox(height: 16),
              Text(
                'Welcome to the future',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                ),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 800.ms)
                  .slideY(begin: 0.3, duration: 800.ms),
              const SizedBox(height: 80),
              Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(duration: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}