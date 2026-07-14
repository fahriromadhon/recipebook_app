# AGENTS.md — RecipeBook Flutter Project Guidelines

## Context

This workspace contains a Flutter university coursework project with Pak Nur.

The current project is:

```text
RecipeBook App
```

RecipeBook App is a beginner-to-intermediate Flutter mobile application for searching recipes from a public API, viewing recipe details, saving favorite recipes locally, and managing personal recipes with SQLite CRUD.

Keep the code simple, readable, and aligned with what has been taught in class.

This project should demonstrate:

1. Flutter widget usage
2. Layout widgets
3. Navigation
4. ListView
5. Form
6. SQLite
7. SQLite CRUD
8. REST API
9. CRUD
10. Camera access
11. Simple REST API security and error handling

Do not build this project like a production enterprise app.
This is a university Flutter project, so prioritize clarity over complexity.

---

## Project Documentation Order

Before coding, read documentation in this order:

1. `docs/01_prd.md`
2. `docs/02_mvp.md`
3. `docs/03_features.md`
4. `docs/04_api_database.md`
5. `docs/05_project_plan.md`
6. `docs/06_user_flow.md`
7. `docs/07_screen_list.md`
8. `docs/08_implementation_guide.md`

Use UI references from:

1. `docs/ui-reference/01_login_home_recipe_detail.png`
2. `docs/ui-reference/02_saved_recipes_form_crud.png`
3. `docs/ui-reference/03_splash_profile_empty_error_states.png`

Follow this `AGENTS.md` strictly.
Do not overengineer.

---

## App Theme

The app theme is:

```text
Recipe / Cooking / Personal Cookbook
```

Main app concept:

RecipeBook App helps users search recipes, view recipe details, save favorite recipes, and manage their own personal recipes.

The app should feel:

1. Clean
2. Warm
3. Friendly
4. Simple
5. Easy to use
6. Suitable for a beginner-to-intermediate Flutter project

Recommended visual direction:

```text
Light mode only
Warm food-inspired colors
Clean cards
Readable typography
Simple Material Design
```

Suggested colors:

| Token      | Color     | Usage                 |
| ---------- | --------- | --------------------- |
| Primary    | `#E65100` | Main orange color     |
| Secondary  | `#FF9800` | Accent orange         |
| Background | `#FFF8F0` | Warm light background |
| Card       | `#FFFFFF` | Card background       |
| Text       | `#263238` | Main text             |
| Subtext    | `#757575` | Secondary text        |
| Error      | `#D32F2F` | Delete/error action   |

Do not use dark mode.

---

## Tech Stack Yang Diizinkan

| Kategori         | Library                                                    |
| ---------------- | ---------------------------------------------------------- |
| State Management | `get: ^4.x`                                                |
| Navigation       | GetX: `GetMaterialApp`, `Get.to`, `Get.back`, `Get.offAll` |
| Reactive UI      | GetX: `Obx`, `Rx`, `GetxController`                        |
| Database         | `sqflite`, `path_provider`, `path`                         |
| HTTP             | `http` atau `GetConnect()` bawaan GetX                     |
| Camera / Image   | `image_picker`                                             |
| Image URL        | `cached_network_image`                                     |
| Local Storage    | `shared_preferences`                                       |
| Date Formatting  | `intl`                                                     |
| Default Flutter  | `cupertino_icons`, `flutter_lints`                         |

Recommended package command:

```bash
flutter pub add get http sqflite path path_provider image_picker shared_preferences intl cached_network_image
```

Technology stack choices must stay within this list.
Do not introduce new libraries without asking.

---

## Public API

Recommended public API:

```text
TheMealDB API
```

Base URL:

```text
https://www.themealdb.com/api/json/v1/1
```

Main endpoints:

```text
GET /search.php?s=keyword
GET /lookup.php?i=id
GET /filter.php?c=category
GET /categories.php
```

The API is used for:

1. Displaying recipe list
2. Searching recipes
3. Showing recipe details
4. Displaying recipe image
5. Displaying ingredients and instructions

Do not use paid API features unless explicitly requested.

---

## Architecture — MVC Sederhana

Use this folder structure:

```text
lib/
  main.dart

  model/
    recipe.dart
    my_recipe.dart

  controller/
    auth_controller.dart
    recipe_controller.dart
    saved_recipe_controller.dart

  screen/
    splash_screen.dart
    login_screen.dart
    home_screen.dart
    detail_screen.dart
    saved_recipes_screen.dart
    recipe_form_screen.dart
    profile_screen.dart

  dataaccess/
    my_recipe_dataaccess.dart

  provider/
    database_provider.dart

  utils/
    constants.dart
```

Folder responsibility:

| Folder        | Responsibility                                     |
| ------------- | -------------------------------------------------- |
| `model/`      | Data classes with manual `fromMap()` and `toMap()` |
| `controller/` | GetX controllers for app logic and state           |
| `screen/`     | UI pages                                           |
| `dataaccess/` | SQLite CRUD logic                                  |
| `provider/`   | SQLite database provider singleton                 |
| `utils/`      | Constants, colors, API config                      |

Do not create these folders:

```text
repository/
usecase/
services/
bloc/
core/
domain/
infrastructure/
```

Do not use Clean Architecture, DDD, Repository Pattern, or layered enterprise structure.

---

## State Management Rules

Use GetX only.

Allowed:

```dart
var isLoading = false.obs;
var recipes = <Recipe>[].obs;
var selectedRecipe = Rxn<Recipe>();
```

Allowed UI binding:

```dart
Obx(() {
  return controller.isLoading.value
      ? const CircularProgressIndicator()
      : ListView.builder(...);
})
```

Allowed controller style:

```dart
class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRecipes() async {}
}
```

Do not use:

1. Provider
2. Riverpod
3. BLoC
4. Redux
5. Stream-based state management
6. ValueNotifier
7. RxDart

---

## Model Conventions

Models should be simple.

Use:

1. Public fields
2. Mutable fields
3. Manual constructor
4. Manual `fromMap()`
5. Manual `toMap()`

Example:

```dart
class Recipe {
  String id;
  String name;
  String category;
  String area;
  String imageUrl;
  String instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.imageUrl,
    required this.instructions,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) => Recipe(
        id: map["idMeal"] ?? "",
        name: map["strMeal"] ?? "",
        category: map["strCategory"] ?? "",
        area: map["strArea"] ?? "",
        imageUrl: map["strMealThumb"] ?? "",
        instructions: map["strInstructions"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "area": area,
        "imageUrl": imageUrl,
        "instructions": instructions,
      };
}
```

Do not use:

1. `freezed`
2. `json_serializable`
3. `build_runner`
4. `copyWith`
5. immutable pattern
6. private model fields

---

## SQLite Model Convention

For local saved recipes, use a separate model:

```text
MyRecipe
```

Recommended fields:

```text
id
apiId
name
category
area
imageUrl
localImagePath
instructions
ingredients
note
createdAt
```

SQLite table:

```text
my_recipes
```

Recommended columns:

```text
id
api_id
name
category
area
image_url
local_image_path
instructions
ingredients
note
created_at
```

Rules:

1. `id` is local SQLite ID.
2. `apiId` is recipe ID from API.
3. `localImagePath` is for camera photo.
4. Store image path only, not image binary.
5. Store ingredients as simple text, not complex relational tables.
6. Do not create multiple tables unless truly needed.

---

## Coding Style

| Aspek           | Aturan                                             |
| --------------- | -------------------------------------------------- |
| File naming     | `snake_case.dart`                                  |
| Class naming    | `PascalCase`                                       |
| Method/variable | `camelCase`                                        |
| Private members | Prefix `_`                                         |
| Const           | Use `const` when possible                          |
| Widget type     | Prefer `StatelessWidget`                           |
| Form            | `GlobalKey<FormState>` + `TextFormField` validator |
| Navigation      | `Get.to()`, `Get.back()`, `Get.offAll()`           |
| Notification    | `Get.snackbar()`                                   |
| Dialog          | `Get.dialog()`                                     |
| Imports         | Use `package:` imports, not relative imports       |

Example import:

```dart
import 'package:recipebook_app/controller/recipe_controller.dart';
```

Avoid:

```dart
import '../controller/recipe_controller.dart';
```

---

## Screen Rules

Required screens:

| Screen        | File                        | Purpose                   |
| ------------- | --------------------------- | ------------------------- |
| Splash        | `splash_screen.dart`        | Check login status        |
| Login         | `login_screen.dart`         | Simple login form         |
| Home          | `home_screen.dart`          | Show recipe list from API |
| Detail        | `detail_screen.dart`        | Show recipe details       |
| Saved Recipes | `saved_recipes_screen.dart` | Show SQLite saved recipes |
| Recipe Form   | `recipe_form_screen.dart`   | Add/edit personal recipe  |
| Profile       | `profile_screen.dart`       | Show user info and logout |

Do not add extra screens unless needed.

---

## Authentication Rules

Use simple local login only.

Default credential:

```text
Username: admin
Password: admin123
```

Use `shared_preferences` to store login status.

Allowed auth flow:

```text
Splash
  ├── if logged in → Home
  └── if not logged in → Login
```

After successful login:

```dart
Get.offAll(() => const HomeScreen());
```

After logout:

```dart
Get.offAll(() => const LoginScreen());
```

Do not implement:

1. Register
2. Forgot password
3. Backend login
4. Firebase Auth
5. OAuth
6. Role-based auth

---

## REST API Rules

Use `http` package or GetX `GetConnect()`.

Preferred for this project:

```text
http
```

Keep API logic in `RecipeController`.

Do not create:

```text
api_service.dart
recipe_service.dart
recipe_repository.dart
```

Controller methods can include:

```text
fetchRecipes()
searchRecipes(String keyword)
fetchRecipeDetail(String id)
fetchCategories()
```

Rules:

1. Use try-catch.
2. Use `isLoading`.
3. Use `Get.snackbar()` for errors.
4. Do not crash if API returns null.
5. If `meals` is null, show empty state.
6. Do not overbuild retry logic.

---

## SQLite Rules

Use:

1. `sqflite`
2. `path_provider`
3. `path`

Database file:

```text
recipebook.db
```

Table:

```text
my_recipes
```

Database provider:

```text
lib/provider/database_provider.dart
```

DataAccess:

```text
lib/dataaccess/my_recipe_dataaccess.dart
```

DataAccess methods:

```text
insertRecipe(MyRecipe recipe)
getAllRecipes()
getRecipeById(int id)
updateRecipe(MyRecipe recipe)
deleteRecipe(int id)
```

Rules:

1. DataAccess only handles SQLite queries.
2. Do not put UI logic in DataAccess.
3. Do not call `Get.snackbar()` in DataAccess.
4. Controller handles snackbar and navigation.
5. Use only one table for this project.

---

## Camera Rules

Use:

```text
image_picker
```

Camera feature is used for:

```text
Adding a photo for personal recipes
```

Flow:

```text
Recipe Form
  → Tap photo area
  → Open camera
  → Take food photo
  → Save local image path
  → Store path in SQLite
```

Do not use:

1. Image cropper
2. Image compressor
3. Upload to server
4. Firebase Storage
5. Barcode scanner

---

## UI Rules

Design style:

```text
Clean warm recipe app
Light mode only
Material Design
Simple Flutter widgets
```

Use:

1. `Scaffold`
2. `AppBar`
3. `Column`
4. `Row`
5. `Container`
6. `Card`
7. `ListView.builder`
8. `TextFormField`
9. `ElevatedButton`
10. `OutlinedButton`
11. `IconButton`
12. `CachedNetworkImage`
13. `Image.file`

Do not use:

1. Complex animations
2. Hero animations
3. CustomPainter
4. Custom route transitions
5. Glassmorphism
6. Neumorphism
7. Dark mode
8. Overly decorative UI

---

## Form Rules

Use forms for:

1. Login
2. Add recipe
3. Edit recipe

Use:

```dart
final formKey = GlobalKey<FormState>();
```

Required fields for personal recipe:

| Field         | Required |
| ------------- | -------- |
| Recipe Name   | Yes      |
| Category      | Yes      |
| Area / Origin | No       |
| Ingredients   | Yes      |
| Instructions  | Yes      |
| Note          | No       |
| Photo         | No       |

Keep form validation simple.

---

## What NOT To Do — Larangan Overengineering

| Jangan Gunakan                     | Cukup Pakai                    |
| ---------------------------------- | ------------------------------ |
| BLoC / Riverpod / Provider / Redux | GetX                           |
| Clean Architecture / DDD           | MVC sederhana                  |
| Repository Pattern                 | Controller + DataAccess        |
| Service layer                      | Controller langsung            |
| freezed / json_serializable        | `fromMap()` / `toMap()` manual |
| build_runner                       | Manual code                    |
| Firebase                           | SQLite + SharedPreferences     |
| Dio                                | `http`                         |
| Hive / Drift / Floor               | `sqflite`                      |
| Advanced DI                        | `Get.put()` / `Get.lazyPut()`  |
| Streams / RxDart                   | `.obs` + `Obx()`               |
| Complex loading state              | `isLoading.obs`                |
| Advanced error handling            | try-catch sederhana            |
| Unit/widget/integration test       | Manual testing checklist       |
| Dark mode                          | Light mode only                |
| Image upload                       | local image path               |
| Multi-table relational DB          | one simple SQLite table        |

---

## Example Reference Files

Use the existing coursework reference style:

1. Model style:
   - `flutter_restapi/lib/model/product.dart`

2. Controller style:
   - `flutter_restapi/lib/controller/productcontroller.dart`

3. DataAccess style:
   - `paknur10_sqlite_crud/flutter-sqlite-crud/lib/dataaccess/contact_dataaccess.dart`

4. Database Provider style:
   - `paknur10_sqlite_crud/flutter-sqlite-crud/lib/provider/database_provider.dart`

5. Screen style:
   - `flutter_restapi/lib/screen/home_screen.dart`

Follow the simplicity of these references.

---

## Final Goal

The final app should be able to:

1. Open Splash Screen
2. Login with local credential
3. Show recipe list from TheMealDB API
4. Search recipes
5. Open recipe detail
6. Save recipe to local SQLite
7. Show saved recipes
8. Add personal recipe manually
9. Edit personal recipe
10. Delete saved/personal recipe
11. Take recipe photo using camera
12. Show simple profile
13. Logout
14. Handle empty and error states simply

The project is considered successful if it demonstrates the course materials clearly and remains easy to explain during presentation.
