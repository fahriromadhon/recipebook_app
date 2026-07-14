import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recipebook_app/controller/saved_recipe_controller.dart';
import 'package:recipebook_app/model/my_recipe.dart';
import 'package:recipebook_app/utils/constants.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({super.key});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final savedRecipeController = Get.find<SavedRecipeController>();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final areaController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  final noteController = TextEditingController();

  bool isEditMode = false;
  MyRecipe? existingRecipe;
  String localImagePath = "";
  String localVideoPath = "";

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    isEditMode = args["mode"] == "edit";

    if (isEditMode && args["recipe"] != null) {
      existingRecipe = args["recipe"] as MyRecipe;
      nameController.text = existingRecipe!.name;
      categoryController.text = existingRecipe!.category;
      areaController.text = existingRecipe!.area;
      ingredientsController.text = existingRecipe!.ingredients;
      instructionsController.text = existingRecipe!.instructions;
      noteController.text = existingRecipe!.note;
      localImagePath = existingRecipe!.localImagePath;
      localVideoPath = existingRecipe!.localVideoPath;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    areaController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isEditMode ? "Edit Recipe" : "Add Recipe"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Photo",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: _buildPhotoPreview(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Video",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              _buildVideoSection(),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Recipe Name *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Recipe name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: "Category *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Category is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: areaController,
                decoration: const InputDecoration(
                  labelText: "Area / Origin",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ingredientsController,
                decoration: const InputDecoration(
                  labelText: "Ingredients *",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Ingredients are required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: instructionsController,
                decoration: const InputDecoration(
                  labelText: "Instructions *",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Instructions are required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: "Note",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    isEditMode ? "Update Recipe" : "Save Recipe",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPreview() {
    String path = localImagePath.isNotEmpty
        ? localImagePath
        : savedRecipeController.imagePath.value;

    if (!kIsWeb && path.isNotEmpty) {
      final file = File(path);
      if (file.existsSync()) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                file,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    localImagePath = "";
                    savedRecipeController.clearImage();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt, size: 48, color: AppColors.subtext),
          const SizedBox(height: 8),
          const Text(
            "Add food photo",
            style: TextStyle(fontSize: 14, color: AppColors.subtext),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.camera_alt, size: 18),
            label: const Text("Take Photo"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    final hasVideo = localVideoPath.isNotEmpty ||
        savedRecipeController.videoPath.value.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(
            hasVideo ? Icons.videocam : Icons.videocam_outlined,
            size: 48,
            color: hasVideo ? AppColors.primary : AppColors.subtext,
          ),
          const SizedBox(height: 8),
          Text(
            hasVideo ? "Video recorded" : "No video recorded",
            style: TextStyle(
              fontSize: 14,
              color: hasVideo ? AppColors.text : AppColors.subtext,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _pickVideo,
                icon: const Icon(Icons.videocam, size: 18),
                label: const Text("Record Video"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              if (hasVideo) ...[
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      localVideoPath = "";
                      savedRecipeController.clearVideo();
                    });
                  },
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text("Remove Video"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
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
    await savedRecipeController.pickImageFromCamera();
    setState(() {
      localImagePath = savedRecipeController.imagePath.value;
    });
  }

  Future<void> _pickVideo() async {
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
    await savedRecipeController.pickVideoFromCamera();
    setState(() {
      localVideoPath = savedRecipeController.videoPath.value;
    });
  }

  void _handleSave() {
    if (!formKey.currentState!.validate()) return;

    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final imagePathToSave = localImagePath.isNotEmpty ? localImagePath : "";
    final videoPathToSave = localVideoPath.isNotEmpty
        ? localVideoPath
        : savedRecipeController.videoPath.value;

    if (isEditMode && existingRecipe != null) {
      final updatedRecipe = MyRecipe(
        id: existingRecipe!.id,
        apiId: existingRecipe!.apiId,
        name: nameController.text.trim(),
        category: categoryController.text.trim(),
        area: areaController.text.trim(),
        imageUrl: existingRecipe!.imageUrl,
        localImagePath: imagePathToSave.isNotEmpty
            ? imagePathToSave
            : existingRecipe!.localImagePath,
        localVideoPath: videoPathToSave.isNotEmpty
            ? videoPathToSave
            : existingRecipe!.localVideoPath,
        instructions: instructionsController.text.trim(),
        ingredients: ingredientsController.text.trim(),
        note: noteController.text.trim(),
        createdAt: existingRecipe!.createdAt,
      );
      savedRecipeController.updateRecipe(updatedRecipe);
      Get.back();
    } else {
      final newRecipe = MyRecipe(
        apiId: "",
        name: nameController.text.trim(),
        category: categoryController.text.trim(),
        area: areaController.text.trim(),
        imageUrl: "",
        localImagePath: imagePathToSave,
        localVideoPath: videoPathToSave,
        instructions: instructionsController.text.trim(),
        ingredients: ingredientsController.text.trim(),
        note: noteController.text.trim(),
        createdAt: now,
      );
      savedRecipeController.addRecipe(newRecipe);
      Get.back();
    }
  }
}
