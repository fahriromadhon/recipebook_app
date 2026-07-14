class Recipe {
  String apiId;
  String name;
  String category;
  String area;
  String imageUrl;
  String instructions;
  String ingredients;
  String youtubeUrl;

  Recipe({
    required this.apiId,
    required this.name,
    required this.category,
    required this.area,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
    required this.youtubeUrl,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    String name = map["strMeal"] ?? "Resep tanpa nama";
    String category = map["strCategory"] ?? "Kategori tidak tersedia";
    String area = map["strArea"] ?? "Area tidak tersedia";
    String imageUrl = map["strMealThumb"] ?? "";
    String instructions = map["strInstructions"] ?? "Instructions tidak tersedia";
    String youtubeUrl = map["strYoutube"] ?? "";

    List<String> ingredientLines = [];
    for (int i = 1; i <= 20; i++) {
      String ingredient = map["strIngredient$i"] ?? "";
      String measure = map["strMeasure$i"] ?? "";
      if (ingredient.trim().isNotEmpty) {
        if (measure.trim().isNotEmpty) {
          ingredientLines.add("$ingredient - $measure");
        } else {
          ingredientLines.add(ingredient);
        }
      }
    }
    String ingredients = ingredientLines.isNotEmpty
        ? ingredientLines.join("\n")
        : "Ingredients tidak tersedia";

    return Recipe(
      apiId: map["idMeal"] ?? "",
      name: name,
      category: category,
      area: area,
      imageUrl: imageUrl,
      instructions: instructions,
      ingredients: ingredients,
      youtubeUrl: youtubeUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "apiId": apiId,
      "name": name,
      "category": category,
      "area": area,
      "imageUrl": imageUrl,
      "instructions": instructions,
      "ingredients": ingredients,
      "youtubeUrl": youtubeUrl,
    };
  }
}
