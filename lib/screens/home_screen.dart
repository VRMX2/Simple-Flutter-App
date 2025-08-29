import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../services/auth_service.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  String _userName = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userData = await _authService.getUserData();
      if (userData.exists && mounted) {
        setState(() {
          _userName = userData['name'] ?? _authService.currentUser?.displayName ?? 'User';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _userName = _authService.currentUser?.displayName ?? 'User';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Sign Out', style: AppTextStyles.heading2),
        content: Text(
          'Are you sure you want to sign out?',
          style: AppTextStyles.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _authService.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _userName,
                          style: AppTextStyles.heading2,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _signOut,
                        icon: const Icon(Icons.logout, color: AppColors.error),
                        tooltip: 'Sign Out',
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.3, duration: 600.ms),
                
                const SizedBox(height: 40),
                
                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Tasks',
                        '24',
                        Icons.task_alt,
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Projects',
                        '8',
                        Icons.folder,
                        AppColors.secondary,
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideY(begin: 0.3, duration: 600.ms),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Completed',
                        '16',
                        Icons.check_circle,
                        AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'In Progress',
                        '8',
                        Icons.pending,
                        AppColors.warning,
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(begin: 0.3, duration: 600.ms),
                
                const SizedBox(height: 40),
                
                // Recent Activity
                Text(
                  'Recent Activity',
                  style: AppTextStyles.heading2,
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideX(begin: -0.3, duration: 600.ms),
                
                const SizedBox(height: 20),
                
                ...List.generate(
                  5,
                  (index) => _buildActivityItem(
                    'Task ${index + 1}',
                    'Completed project milestone',
                    '${index + 1}h ago',
                    Icons.check_circle,
                    AppColors.success,
                  ).animate(delay: (800 + index * 100).ms)
                      .fadeIn(duration: 500.ms)
                      .slideX(begin: 0.3, duration: 500.ms),
                ),
                
                const SizedBox(height: 40),
                
                // Quick Actions
                Text(
                  'Quick Actions',
                  style: AppTextStyles.heading2,
                )
                    .animate()
                    .fadeIn(delay: 1300.ms, duration: 600.ms)
                    .slideX(begin: -0.3, duration: 600.ms),
                
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        'New Task',
                        Icons.add_task,
                        AppColors.primary,
                        () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildActionButton(
                        'View Reports',
                        Icons.analytics,
                        AppColors.secondary,
                        () {},
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(delay: 1500.ms, duration: 600.ms)
                    .slideY(begin: 0.3, duration: 600.ms),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: AppTextStyles.heading1.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyLarge),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
          Text(time, style: AppTextStyles.caption),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Column(
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}