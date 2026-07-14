import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recipebook_app/utils/constants.dart';
import 'package:recipebook_app/model/recipe.dart';

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var selectedRecipe = Rxn<Recipe>();
  var isLoading = false.obs;
  var errorMessage = "".obs;

  Future<void> fetchRecipes() async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/search.php?s=chicken"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meals = data["meals"];
        if (meals != null) {
          recipes.value =
              (meals as List).map((e) => Recipe.fromMap(e)).toList();
        } else {
          recipes.clear();
        }
      } else {
        errorMessage.value = "Failed to load recipes";
        Get.snackbar(
          "Error",
          "Failed to load recipes",
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = "Connection error";
      Get.snackbar(
        "Error",
        "Connection error. Please try again.",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> searchRecipes(String keyword) async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/search.php?s=$keyword"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meals = data["meals"];
        if (meals != null) {
          recipes.value =
              (meals as List).map((e) => Recipe.fromMap(e)).toList();
        } else {
          recipes.clear();
        }
      } else {
        errorMessage.value = "Failed to search recipes";
        Get.snackbar(
          "Error",
          "Failed to search recipes",
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = "Connection error";
      Get.snackbar(
        "Error",
        "Connection error. Please try again.",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> fetchRecipeDetail(String id) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/lookup.php?i=$id"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meals = data["meals"];
        if (meals != null && meals.isNotEmpty) {
          selectedRecipe.value = Recipe.fromMap(meals[0]);
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to load recipe detail",
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Connection error. Please try again.",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  void clearRecipes() {
    recipes.clear();
    errorMessage.value = "";
  }
}
