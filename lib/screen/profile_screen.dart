import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipebook_app/controller/auth_controller.dart';
import 'package:recipebook_app/controller/saved_recipe_controller.dart';
import 'package:recipebook_app/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final savedRecipeController = Get.find<SavedRecipeController>();

  @override
  void initState() {
    super.initState();
    savedRecipeController.loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              "admin",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "RecipeBook User",
              style: TextStyle(fontSize: 14, color: AppColors.subtext),
            ),
            const SizedBox(height: 32),
            Obx(
              () => Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.bookmark, color: AppColors.primary),
                  title: const Text(
                    "Saved Recipes",
                    style: TextStyle(color: AppColors.text),
                  ),
                  trailing: Text(
                    "${savedRecipeController.savedRecipes.length}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.info_outline, color: AppColors.subtext),
                title: const Text(
                  "App Version",
                  style: TextStyle(color: AppColors.text),
                ),
                trailing: Text(
                  AppConstants.appVersion,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.subtext,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => authController.showLogoutDialog(),
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
