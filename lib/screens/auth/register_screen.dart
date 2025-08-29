import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/auth_service.dart';
import '../home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                    color: AppColors.textPrimary,
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.3),
                  const SizedBox(height: 20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.white,
                    ),
                  )
                      .animate()
                      .scale(duration: 800.ms, curve: Curves.elasticOut)
                      .then()
                      .shimmer(duration: 1000.ms),
                  const SizedBox(height: 40),
                  Text(
                    'Create Account',
                    style: AppTextStyles.heading1,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideX(begin: -0.3, duration: 600.ms),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started with your new account',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 600.ms)
                      .slideX(begin: -0.3, duration: 600.ms),
                  const SizedBox(height: 40),
                  CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      if (value.length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ).animate().slideY(begin: 0.3, duration: 500.ms),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ).animate().slideY(begin: 0.3, duration: 600.ms),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    isPassword: true,
                    controller: _passwordController,
                    prefixIcon: Icons.lock_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ).animate().slideY(begin: 0.3, duration: 700.ms),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    prefixIcon: Icons.lock_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ).animate().slideY(begin: 0.3, duration: 800.ms),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Create Account',
                    isLoading: _isLoading,
                    onPressed: _register,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.textSecondary.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.textSecondary.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Continue with Google',
                    isOutlined: true,
                    onPressed: () {
                      // Add Google sign up
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Sign In',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}