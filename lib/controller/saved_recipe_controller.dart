import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipebook_app/model/my_recipe.dart';
import 'package:recipebook_app/model/recipe.dart';
import 'package:recipebook_app/dataaccess/my_recipe_dataaccess.dart';
import 'package:recipebook_app/utils/constants.dart';

class SavedRecipeController extends GetxController {
  var savedRecipes = <MyRecipe>[].obs;
  var isLoading = false.obs;
  var imagePath = "".obs;
  var videoPath = "".obs;

  final _dataAccess = MyRecipeDataAccess();

  Future<void> loadRecipes() async {
    isLoading.value = true;
    try {
      final result = await _dataAccess.getAllRecipes();
      savedRecipes.value = result;
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to load saved recipes",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> addRecipe(MyRecipe recipe) async {
    try {
      await _dataAccess.insertRecipe(recipe);
      await loadRecipes();
      Get.snackbar(
        "Success",
        "Recipe saved successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to save recipe: $e",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateRecipe(MyRecipe recipe) async {
    try {
      await _dataAccess.updateRecipe(recipe);
      await loadRecipes();
      Get.snackbar(
        "Success",
        "Recipe updated successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to update recipe: $e",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await _dataAccess.deleteRecipe(id);
      await loadRecipes();
      Get.snackbar(
        "Success",
        "Recipe deleted successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to delete recipe: $e",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> saveRecipeFromApi(Recipe recipe) async {
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final myRecipe = MyRecipe(
      apiId: recipe.apiId,
      name: recipe.name,
      category: recipe.category,
      area: recipe.area,
      imageUrl: recipe.imageUrl,
      localImagePath: "",
      localVideoPath: "",
      instructions: recipe.instructions,
      ingredients: recipe.ingredients,
      note: "",
      createdAt: now,
    );
    await addRecipe(myRecipe);
  }

  Future<void> pickImageFromCamera() async {
    if (kIsWeb) {
      Get.snackbar(
        "Info",
        "Camera is not available on Web. Please use Android for camera feature.",
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  Future<void> pickVideoFromCamera() async {
    if (kIsWeb) {
      Get.snackbar(
        "Info",
        "Video recording is only supported on Android APK for this project.",
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    try {
      final picker = ImagePicker();
      final XFile? video = await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 30),
      );
      if (video != null) {
        videoPath.value = video.path;
        Get.snackbar(
          "Success",
          "Video recorded successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to record video",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setImagePath(String path) {
    imagePath.value = path;
  }

  void setVideoPath(String path) {
    videoPath.value = path;
  }

  void clearImage() {
    imagePath.value = "";
  }

  void clearVideo() {
    videoPath.value = "";
  }

  void clearMedia() {
    imagePath.value = "";
    videoPath.value = "";
  }

  void showDeleteDialog(MyRecipe recipe) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Recipe"),
        content: Text("Are you sure you want to delete \"${recipe.name}\"?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              if (recipe.id != null) {
                deleteRecipe(recipe.id!);
              }
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
