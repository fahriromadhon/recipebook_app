import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipebook_app/model/recipe.dart';
import 'package:recipebook_app/controller/saved_recipe_controller.dart';
import 'package:recipebook_app/utils/constants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = Get.arguments as Recipe;
    final savedRecipeController = Get.isRegistered<SavedRecipeController>()
        ? Get.find<SavedRecipeController>()
        : Get.put(SavedRecipeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Recipe Detail"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: recipe.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              )
            else
              Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.restaurant, size: 50, color: AppColors.subtext),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.category, size: 16, color: AppColors.primary),
                        label: Text(
                          recipe.category,
                          style: const TextStyle(fontSize: 12, color: AppColors.text),
                        ),
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                      ),
                      Chip(
                        avatar: const Icon(Icons.public, size: 16, color: AppColors.primary),
                        label: Text(
                          recipe.area,
                          style: const TextStyle(fontSize: 12, color: AppColors.text),
                        ),
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recipe.ingredients,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.text,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Instructions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recipe.instructions,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.text,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        savedRecipeController.saveRecipeFromApi(recipe);
                      },
                      icon: const Icon(Icons.bookmark_add),
                      label: const Text(
                        "Save to Saved Recipes",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
