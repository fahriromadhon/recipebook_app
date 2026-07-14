import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipebook_app/model/my_recipe.dart';
import 'package:recipebook_app/provider/database_provider.dart';

class MyRecipeDataAccess {
  static const String webRecipeKey = "web_my_recipes";

  Future<int> insertRecipe(MyRecipe recipe) async {
    if (kIsWeb) {
      return await _insertRecipeWeb(recipe);
    }
    final db = await DatabaseProvider.instance.database;
    return await db.insert("my_recipes", recipe.toInsertMap());
  }

  Future<List<MyRecipe>> getAllRecipes() async {
    if (kIsWeb) {
      return await _getAllRecipesWeb();
    }
    final db = await DatabaseProvider.instance.database;
    final result = await db.query(
      "my_recipes",
      orderBy: "id DESC",
    );
    return result.map((e) => MyRecipe.fromMap(e)).toList();
  }

  Future<MyRecipe?> getRecipeById(int id) async {
    if (kIsWeb) {
      return await _getRecipeByIdWeb(id);
    }
    final db = await DatabaseProvider.instance.database;
    final result = await db.query(
      "my_recipes",
      where: "id = ?",
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return MyRecipe.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateRecipe(MyRecipe recipe) async {
    if (kIsWeb) {
      return await _updateRecipeWeb(recipe);
    }
    final db = await DatabaseProvider.instance.database;
    return await db.update(
      "my_recipes",
      recipe.toMap(),
      where: "id = ?",
      whereArgs: [recipe.id],
    );
  }

  Future<int> deleteRecipe(int id) async {
    if (kIsWeb) {
      return await _deleteRecipeWeb(id);
    }
    final db = await DatabaseProvider.instance.database;
    return await db.delete(
      "my_recipes",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<MyRecipe>> _getWebRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(webRecipeKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List decoded = jsonDecode(jsonString);
    return decoded.map((item) => MyRecipe.fromMap(item)).toList();
  }

  Future<void> _saveWebRecipes(List<MyRecipe> recipes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      recipes.map((r) => r.toMap()).toList(),
    );
    await prefs.setString(webRecipeKey, encoded);
  }

  Future<int> _insertRecipeWeb(MyRecipe recipe) async {
    final recipes = await _getWebRecipes();
    final newId = recipes.isEmpty
        ? 1
        : (recipes.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
    recipe.id = newId;
    recipes.insert(0, recipe);
    await _saveWebRecipes(recipes);
    return newId;
  }

  Future<List<MyRecipe>> _getAllRecipesWeb() async {
    final recipes = await _getWebRecipes();
    recipes.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
    return recipes;
  }

  Future<MyRecipe?> _getRecipeByIdWeb(int id) async {
    final recipes = await _getWebRecipes();
    for (final recipe in recipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  Future<int> _updateRecipeWeb(MyRecipe recipe) async {
    final recipes = await _getWebRecipes();
    final index = recipes.indexWhere((r) => r.id == recipe.id);
    if (index == -1) return 0;
    recipes[index] = recipe;
    await _saveWebRecipes(recipes);
    return 1;
  }

  Future<int> _deleteRecipeWeb(int id) async {
    final recipes = await _getWebRecipes();
    final index = recipes.indexWhere((r) => r.id == id);
    if (index == -1) return 0;
    recipes.removeAt(index);
    await _saveWebRecipes(recipes);
    return 1;
  }
}
