import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Events', style: AppTextStyles.h2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () => _authController.logout(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Home Screen - Events will appear here',
          style: AppTextStyles.body,
        ),
      ),
    );
  }
}
