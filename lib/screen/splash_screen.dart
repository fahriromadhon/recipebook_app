import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipebook_app/controller/auth_controller.dart';
import 'package:recipebook_app/controller/saved_recipe_controller.dart';
import 'package:recipebook_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(AuthController());
    Get.put(SavedRecipeController());
    final authController = Get.find<AuthController>();
    authController.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.menu_book_rounded,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'RecipeBook',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find and save your favorite recipes',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.subtext,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.subtext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
