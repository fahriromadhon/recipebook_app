import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipebook_app/controller/saved_recipe_controller.dart';
import 'package:recipebook_app/model/my_recipe.dart';
import 'package:recipebook_app/screen/profile_screen.dart';
import 'package:recipebook_app/screen/recipe_form_screen.dart';
import 'package:recipebook_app/utils/constants.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({super.key});

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  final savedRecipeController = Get.find<SavedRecipeController>();

  @override
  void initState() {
    super.initState();
    savedRecipeController.loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Saved Recipes"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const ProfileScreen()),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          savedRecipeController.clearMedia();
          await Get.to(() => const RecipeFormScreen(), arguments: {
            "mode": "add",
          });
          savedRecipeController.loadRecipes();
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (savedRecipeController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (savedRecipeController.savedRecipes.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bookmark_border,
                    size: 48,
                    color: AppColors.subtext,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No recipes saved yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Save your favorite recipe or add your own recipe.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.subtext,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () async {
                      savedRecipeController.clearMedia();
                      await Get.to(() => const RecipeFormScreen(), arguments: {
                        "mode": "add",
                      });
                      savedRecipeController.loadRecipes();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Recipe"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: savedRecipeController.savedRecipes.length,
          itemBuilder: (context, index) {
            final recipe = savedRecipeController.savedRecipes[index];
            return _buildSavedRecipeCard(recipe);
          },
        );
      }),
    );
  }

  Widget _buildSavedRecipeCard(MyRecipe recipe) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: _buildRecipeImage(recipe),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.category, size: 14, color: AppColors.subtext),
                    const SizedBox(width: 4),
                    Text(
                      recipe.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.subtext,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.public, size: 14, color: AppColors.subtext),
                    const SizedBox(width: 4),
                    Text(
                      recipe.area,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.subtext,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (recipe.localImagePath.isNotEmpty) ...[
                      const Icon(Icons.photo, size: 14, color: AppColors.primary),
                      const SizedBox(width: 4),
                      const Text(
                        "Photo",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (recipe.localVideoPath.isNotEmpty) ...[
                      const Icon(Icons.videocam, size: 14, color: AppColors.primary),
                      const SizedBox(width: 4),
                      const Text(
                        "Video",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        savedRecipeController.setImagePath(recipe.localImagePath);
                        savedRecipeController.setVideoPath(recipe.localVideoPath);
                        await Get.to(() => const RecipeFormScreen(), arguments: {
                          "mode": "edit",
                          "recipe": recipe,
                        });
                        savedRecipeController.loadRecipes();
                      },
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text("Edit"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        savedRecipeController.showDeleteDialog(recipe);
                      },
                      icon: const Icon(Icons.delete, size: 16, color: AppColors.error),
                      label: const Text(
                        "Delete",
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeImage(MyRecipe recipe) {
    if (!kIsWeb && recipe.localImagePath.isNotEmpty) {
      return Image.file(
        File(recipe.localImagePath),
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    if (recipe.imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: recipe.imageUrl,
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 180,
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.restaurant, size: 50, color: AppColors.subtext),
      ),
    );
  }
}
