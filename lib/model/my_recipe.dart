class MyRecipe {
  int? id;
  String apiId;
  String name;
  String category;
  String area;
  String imageUrl;
  String localImagePath;
  String localVideoPath;
  String instructions;
  String ingredients;
  String note;
  String createdAt;

  MyRecipe({
    this.id,
    required this.apiId,
    required this.name,
    required this.category,
    required this.area,
    required this.imageUrl,
    required this.localImagePath,
    required this.localVideoPath,
    required this.instructions,
    required this.ingredients,
    required this.note,
    required this.createdAt,
  });

  factory MyRecipe.fromMap(Map<String, dynamic> map) {
    return MyRecipe(
      id: map["id"],
      apiId: map["api_id"] ?? "",
      name: map["name"] ?? "",
      category: map["category"] ?? "",
      area: map["area"] ?? "",
      imageUrl: map["image_url"] ?? "",
      localImagePath: map["local_image_path"] ?? "",
      localVideoPath: map["local_video_path"] ?? "",
      instructions: map["instructions"] ?? "",
      ingredients: map["ingredients"] ?? "",
      note: map["note"] ?? "",
      createdAt: map["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "api_id": apiId,
      "name": name,
      "category": category,
      "area": area,
      "image_url": imageUrl,
      "local_image_path": localImagePath,
      "local_video_path": localVideoPath,
      "instructions": instructions,
      "ingredients": ingredients,
      "note": note,
      "created_at": createdAt,
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      "api_id": apiId,
      "name": name,
      "category": category,
      "area": area,
      "image_url": imageUrl,
      "local_image_path": localImagePath,
      "local_video_path": localVideoPath,
      "instructions": instructions,
      "ingredients": ingredients,
      "note": note,
      "created_at": createdAt,
    };
  }
}
