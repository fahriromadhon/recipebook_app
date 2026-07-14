import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipebook_app/utils/constants.dart';
import 'package:recipebook_app/screen/home_screen.dart';
import 'package:recipebook_app/screen/login_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<void> checkLoginStatus() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    } catch (e) {
      isLoggedIn.value = false;
    }
    isLoading.value = false;

    if (isLoggedIn.value) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (username == AppConstants.defaultUsername &&
          password == AppConstants.defaultPassword) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        isLoggedIn.value = true;
        isLoading.value = false;
        Get.offAll(() => const HomeScreen());
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Login Failed',
          'Invalid username or password',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn.value = false;
    Get.offAll(() => LoginScreen());
  }

  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
