# Implementation Guide - RecipeBook App

## 1. Ringkasan

Dokumen ini adalah panduan implementasi coding untuk project **RecipeBook App**.

Panduan ini dibuat agar proses pengembangan aplikasi tetap sederhana, rapi, dan sesuai dengan aturan di `AGENTS.md`.

Project ini menggunakan:

- Flutter
- Dart
- GetX
- REST API
- SQLite
- Image Picker
- SharedPreferences

Project tidak menggunakan arsitektur kompleks seperti Clean Architecture, Repository Pattern, BLoC, Riverpod, Firebase, code generation, atau layer tambahan yang tidak diajarkan.

---

## 2. Prinsip Implementasi

Selama implementasi, ikuti prinsip berikut:

1. Kode harus sederhana dan mudah dibaca.
2. Gunakan GetX untuk state management dan navigation.
3. Gunakan MVC sederhana.
4. Jangan membuat folder `repository/`, `usecase/`, atau `services/`.
5. Model menggunakan `fromMap()` dan `toMap()` manual.
6. State menggunakan `.obs`.
7. UI menggunakan `Obx()` untuk membaca state.
8. Form menggunakan `GlobalKey<FormState>`.
9. Error handling cukup menggunakan try-catch sederhana.
10. Gunakan `Get.snackbar()` untuk pesan berhasil atau gagal.
11. Gunakan `Get.dialog()` untuk konfirmasi delete dan logout.
12. Jangan overengineering.

---

## 3. Urutan Dokumentasi yang Harus Dibaca

Sebelum coding, baca dokumen dalam urutan berikut:

```text id="q9wjus"
docs/01_prd.md
docs/02_mvp.md
docs/03_features.md
docs/04_api_database.md
docs/05_project_plan.md
docs/06_user_flow.md
docs/07_screen_list.md
docs/08_implementation_guide.md
```

Gunakan referensi UI dari:

```text id="ysdacc"
docs/ui-reference/01_login_home_recipe_detail.png
docs/ui-reference/02_saved_recipes_form_crud.png
docs/ui-reference/03_splash_profile_empty_error_states.png
```

---

## 4. Package yang Digunakan

Package yang digunakan dalam project:

```bash id="4jhbsk"
flutter pub add get http sqflite path path_provider image_picker shared_preferences intl cached_network_image
```

Keterangan package:

| Package                | Fungsi                                         |
| ---------------------- | ---------------------------------------------- |
| `get`                  | Navigation, state management, snackbar, dialog |
| `http`                 | Mengambil data dari REST API                   |
| `sqflite`              | Database SQLite                                |
| `path`                 | Menggabungkan path database                    |
| `path_provider`        | Menentukan lokasi file database SQLite         |
| `image_picker`         | Mengambil foto makanan                         |
| `shared_preferences`   | Menyimpan status login                         |
| `intl`                 | Format tanggal                                 |
| `cached_network_image` | Menampilkan gambar dari URL                    |

Catatan:

- Jangan menambahkan package baru tanpa kebutuhan jelas.
- Jangan menggunakan Dio, Provider, Riverpod, BLoC, Firebase, Hive, atau Drift.
- Jika package tambahan benar-benar dibutuhkan, tanyakan dulu.

---

## 5. Struktur Folder Final

Gunakan struktur folder berikut:

```text id="t5p3jz"
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

Jangan membuat folder berikut:

```text id="4rbyzl"
repository/
usecase/
services/
bloc/
core/
domain/
infrastructure/
```

Catatan:

- Folder `provider/` hanya digunakan untuk database provider SQLite.
- State management tetap menggunakan GetX di folder `controller/`.

---

## 6. Urutan Implementasi Coding

Implementasi sebaiknya dilakukan bertahap agar mudah dicek.

Urutan pengerjaan yang disarankan:

1. Setup package.
2. Buat folder project.
3. Buat `utils/constants.dart`.
4. Buat model `recipe.dart`.
5. Buat model `my_recipe.dart`.
6. Buat `main.dart` dengan `GetMaterialApp`.
7. Buat `auth_controller.dart`.
8. Buat `splash_screen.dart`.
9. Buat `login_screen.dart`.
10. Buat `home_screen.dart` dengan data dummy.
11. Buat `detail_screen.dart`.
12. Buat navigation antar screen.
13. Buat `recipe_controller.dart` untuk REST API.
14. Hubungkan Home Screen ke API.
15. Buat `database_provider.dart`.
16. Buat `my_recipe_dataaccess.dart`.
17. Buat `saved_recipe_controller.dart`.
18. Buat `saved_recipes_screen.dart`.
19. Buat `recipe_form_screen.dart`.
20. Implementasi CRUD SQLite.
21. Implementasi kamera dengan `image_picker`.
22. Buat `profile_screen.dart`.
23. Implementasi logout.
24. Rapikan UI sesuai referensi gambar.
25. Testing manual.

---

## 7. File `constants.dart`

File:

```text id="6vl7nh"
lib/utils/constants.dart
```

Fungsi:

1. Menyimpan base URL.
2. Menyimpan warna utama.
3. Menyimpan nama aplikasi.
4. Menyimpan app version.
5. Menyimpan teks default jika dibutuhkan.

Isi minimal:

```dart id="xvkj7t"
import 'package:flutter/material.dart';

const String appName = "RecipeBook";
const String appVersion = "1.0.0";

const String baseUrl = "https://www.themealdb.com/api/json/v1/1";

const Color primaryColor = Color(0xFFE65100);
const Color secondaryColor = Color(0xFFFF9800);
const Color backgroundColor = Color(0xFFFFF8F0);
const Color textColor = Color(0xFF263238);
const Color subTextColor = Color(0xFF757575);
const Color errorColor = Color(0xFFD32F2F);
```

Catatan:

- TheMealDB API dasar tidak membutuhkan API key.
- Base URL cukup diletakkan di satu file ini.
- Jangan menulis base URL langsung di banyak screen.
- Jangan tampilkan konfigurasi API di UI.

---

## 8. Implementasi `main.dart`

File:

```text id="chfmhe"
lib/main.dart
```

Gunakan `GetMaterialApp`.

Konsep isi:

```dart id="dp44r7"
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipebook_app/screen/splash_screen.dart';
import 'package:recipebook_app/utils/constants.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatelessWidget {
  const RecipeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
```

Catatan:

- Gunakan `GetMaterialApp`, bukan `MaterialApp`.
- Jangan membuat routing kompleks dulu.
- Untuk project sederhana, `Get.to()` langsung cukup.

---

## 9. Model `Recipe`

File:

```text id="kjuomo"
lib/model/recipe.dart
```

Fungsi:

Model untuk data resep dari API.

Field minimal:

```text id="nxa9kx"
apiId
name
category
area
imageUrl
instructions
ingredients
youtubeUrl
```

Aturan:

1. Field public.
2. Tidak perlu immutable.
3. Tidak perlu `copyWith`.
4. Gunakan `fromMap()` manual.
5. Gunakan default value jika data API kosong.

### Catatan penting ingredients

TheMealDB menyimpan bahan dalam field:

```text id="76t1rp"
strIngredient1 sampai strIngredient20
```

Takaran bahan ada di:

```text id="fu7oh7"
strMeasure1 sampai strMeasure20
```

Gabungkan menjadi string sederhana.

Contoh:

```text id="761opw"
Chicken - 500g
Salt - 1 tsp
Garlic - 2 cloves
```

Contoh konsep model:

```dart id="h2n3rz"
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
    String ingredientsText = "";

    for (int i = 1; i <= 20; i++) {
      String ingredient = map["strIngredient$i"] ?? "";
      String measure = map["strMeasure$i"] ?? "";

      if (ingredient.trim().isNotEmpty) {
        ingredientsText += "$ingredient";
        if (measure.trim().isNotEmpty) {
          ingredientsText += " - $measure";
        }
        ingredientsText += "\n";
      }
    }

    return Recipe(
      apiId: map["idMeal"] ?? "",
      name: map["strMeal"] ?? "Resep tanpa nama",
      category: map["strCategory"] ?? "Kategori tidak tersedia",
      area: map["strArea"] ?? "Area tidak tersedia",
      imageUrl: map["strMealThumb"] ?? "",
      instructions: map["strInstructions"] ?? "Instructions tidak tersedia",
      ingredients: ingredientsText.isEmpty ? "Ingredients tidak tersedia" : ingredientsText,
      youtubeUrl: map["strYoutube"] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
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
```

---

## 10. Model `MyRecipe`

File:

```text id="hqw4j7"
lib/model/my_recipe.dart
```

Fungsi:

Model untuk data resep yang disimpan ke SQLite.

Field minimal:

```text id="v2txbb"
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

Contoh konsep:

```dart id="eg8kiu"
class MyRecipe {
  int? id;
  String apiId;
  String name;
  String category;
  String area;
  String imageUrl;
  String localImagePath;
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
    required this.instructions,
    required this.ingredients,
    required this.note,
    required this.createdAt,
  });

  factory MyRecipe.fromMap(Map<String, dynamic> map) => MyRecipe(
        id: map["id"],
        apiId: map["api_id"] ?? "",
        name: map["name"] ?? "",
        category: map["category"] ?? "",
        area: map["area"] ?? "",
        imageUrl: map["image_url"] ?? "",
        localImagePath: map["local_image_path"] ?? "",
        instructions: map["instructions"] ?? "",
        ingredients: map["ingredients"] ?? "",
        note: map["note"] ?? "",
        createdAt: map["created_at"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "api_id": apiId,
        "name": name,
        "category": category,
        "area": area,
        "image_url": imageUrl,
        "local_image_path": localImagePath,
        "instructions": instructions,
        "ingredients": ingredients,
        "note": note,
        "created_at": createdAt,
      };
}
```

Catatan:

- Jika insert data baru, `id` boleh null.
- Jika error karena id null saat insert, hapus `id` dari map sebelum insert.
- Ingredients disimpan sebagai string biasa.

---

## 11. Auth Controller

File:

```text id="0h9ctq"
lib/controller/auth_controller.dart
```

Fungsi:

1. Mengecek status login.
2. Login sederhana.
3. Logout.
4. Menyimpan status login ke SharedPreferences.

State:

```text id="ap6ynq"
isLoading
isLoggedIn
```

Data login default:

```text id="6xclbg"
username: admin
password: admin123
```

Method yang dibutuhkan:

| Method               | Fungsi                   |
| -------------------- | ------------------------ |
| `checkLoginStatus()` | Mengecek status login    |
| `login()`            | Login sederhana          |
| `logout()`           | Logout                   |
| `showLogoutDialog()` | Dialog konfirmasi logout |

Konsep implementasi:

```dart id="5nc0hw"
class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<void> checkLoginStatus() async {}

  Future<void> login(String username, String password) async {}

  Future<void> logout() async {}

  void showLogoutDialog() {}
}
```

Catatan:

- Gunakan SharedPreferences.
- Setelah login berhasil, gunakan `Get.offAll(() => const HomeScreen())`.
- Setelah logout, gunakan `Get.offAll(() => const LoginScreen())`.
- Gunakan `Get.snackbar()` untuk pesan.

---

## 12. Recipe Controller

File:

```text id="t3vwpn"
lib/controller/recipe_controller.dart
```

Fungsi:

1. Mengambil daftar resep dari API.
2. Search resep.
3. Mengambil detail resep.
4. Menyimpan data selected recipe.
5. Mengatur loading.

State:

```text id="tsm8pq"
recipes
selectedRecipe
isLoading
```

Method yang dibutuhkan:

| Method                          | Fungsi                                |
| ------------------------------- | ------------------------------------- |
| `fetchRecipes()`                | Mengambil list resep default          |
| `searchRecipes(String keyword)` | Search resep                          |
| `fetchRecipeDetail(String id)`  | Mengambil detail resep                |
| `clearSearch()`                 | Menghapus search dan memuat list awal |

Endpoint:

```text id="u1gyjm"
GET /search.php?s=keyword
GET /lookup.php?i=id
```

Keyword default yang disarankan:

```text id="ap7c7w"
chicken
```

Konsep:

```dart id="pzj085"
class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var selectedRecipe = Rxn<Recipe>();
  var isLoading = false.obs;

  Future<void> fetchRecipes() async {}

  Future<void> searchRecipes(String keyword) async {}

  Future<void> fetchRecipeDetail(String id) async {}
}
```

Catatan:

- Gunakan package `http`.
- Gunakan `jsonDecode`.
- Gunakan try-catch.
- Jangan menggunakan Dio.
- Jika gagal, tampilkan `Get.snackbar()`.
- Jika `meals` null, tampilkan empty state dengan list kosong.

---

## 13. Database Provider

File:

```text id="jhf669"
lib/provider/database_provider.dart
```

Fungsi:

1. Membuka database SQLite.
2. Membuat database jika belum ada.
3. Membuat table `my_recipes`.

Database:

```text id="yco9rd"
recipebook.db
```

Table:

```text id="etddcg"
my_recipes
```

SQL create table:

```sql id="7t8qpy"
CREATE TABLE my_recipes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  api_id TEXT,
  name TEXT,
  category TEXT,
  area TEXT,
  image_url TEXT,
  local_image_path TEXT,
  instructions TEXT,
  ingredients TEXT,
  note TEXT,
  created_at TEXT
);
```

Catatan:

- Gunakan singleton sederhana.
- Gunakan `sqflite`.
- Gunakan `path_provider`.
- Gunakan `path`.
- Jangan membuat database logic di screen.

---

## 14. My Recipe DataAccess

File:

```text id="bk09x1"
lib/dataaccess/my_recipe_dataaccess.dart
```

Fungsi:

CRUD SQLite untuk table `my_recipes`.

Method yang dibutuhkan:

| Method                          | Fungsi                    |
| ------------------------------- | ------------------------- |
| `insertRecipe(MyRecipe recipe)` | Insert data               |
| `getAllRecipes()`               | Ambil semua data          |
| `getRecipeById(int id)`         | Ambil data berdasarkan ID |
| `updateRecipe(MyRecipe recipe)` | Update data               |
| `deleteRecipe(int id)`          | Delete data               |

Catatan:

- DataAccess hanya untuk query SQLite.
- Jangan menaruh UI logic di DataAccess.
- Jangan menaruh snackbar di DataAccess.
- Snackbar cukup dari controller.

---

## 15. Saved Recipe Controller

File:

```text id="vku19l"
lib/controller/saved_recipe_controller.dart
```

Fungsi:

1. Mengambil data Saved Recipes.
2. Insert resep.
3. Update resep.
4. Delete resep.
5. Ambil foto dari kamera.
6. Mengatur state form.

State:

```text id="2qfgab"
savedRecipes
isLoading
imagePath
```

Method yang dibutuhkan:

| Method                              | Fungsi                    |
| ----------------------------------- | ------------------------- |
| `loadRecipes()`                     | Ambil data SQLite         |
| `addRecipe(MyRecipe recipe)`        | Insert resep              |
| `updateRecipe(MyRecipe recipe)`     | Update resep              |
| `deleteRecipe(int id)`              | Delete resep              |
| `pickImageFromCamera()`             | Ambil foto dari kamera    |
| `clearImage()`                      | Reset image path          |
| `setImagePath(String path)`         | Set image path untuk edit |
| `showDeleteDialog(MyRecipe recipe)` | Konfirmasi hapus          |

Catatan:

- Gunakan `ImagePicker`.
- Simpan path gambar ke `imagePath`.
- Setelah insert/update/delete, panggil ulang `loadRecipes()`.
- Gunakan `Get.snackbar()` untuk pesan.

---

## 16. Screen Implementation Order

Implementasi screen sebaiknya dilakukan urut seperti ini:

```text id="z7x8pp"
1. splash_screen.dart
2. login_screen.dart
3. home_screen.dart
4. detail_screen.dart
5. saved_recipes_screen.dart
6. recipe_form_screen.dart
7. profile_screen.dart
```

Alasan:

1. Splash dan login menentukan alur awal.
2. Home dan detail menguji REST API.
3. Saved Recipes dan form menguji SQLite CRUD.
4. Profile menyelesaikan logout.

---

## 17. Splash Screen Implementation

File:

```text id="ib4wyk"
lib/screen/splash_screen.dart
```

Tugas:

1. Tampilkan ikon recipe book atau restaurant.
2. Tampilkan nama RecipeBook.
3. Tampilkan loading.
4. Panggil `AuthController.checkLoginStatus()`.
5. Arahkan ke Login atau Home.

Catatan:

- Gunakan `Get.put(AuthController())`.
- Gunakan `Get.offAll()`.
- Tidak perlu animasi kompleks.

---

## 18. Login Screen Implementation

File:

```text id="69o543"
lib/screen/login_screen.dart
```

Tugas:

1. Buat form login.
2. Buat input username.
3. Buat input password.
4. Validasi input.
5. Panggil `AuthController.login()`.
6. Navigasi ke Home jika berhasil.

Komponen:

```text id="gldysu"
Scaffold
SingleChildScrollView
Form
TextFormField
ElevatedButton
```

Catatan:

- Password gunakan `obscureText: true`.
- Gunakan desain dari `01_login_home_recipe_detail.png`.
- Jangan buat register atau forgot password.

---

## 19. Home Screen Implementation

File:

```text id="0fq0h2"
lib/screen/home_screen.dart
```

Tugas:

1. Tampilkan AppBar RecipeBook.
2. Tampilkan search bar.
3. Tampilkan list resep.
4. Tampilkan loading.
5. Tampilkan empty state jika data kosong.
6. Navigasi ke Detail Screen saat card diklik.
7. Navigasi ke Saved Recipes.
8. Navigasi ke Profile.

Komponen:

```text id="93exb5"
Scaffold
AppBar
TextField
ListView.builder
Card
CachedNetworkImage
```

Catatan:

- Gunakan `RecipeController`.
- Gunakan `Obx()`.
- Data awal dari `fetchRecipes()`.
- Search cukup menggunakan tombol search, tidak harus real-time.
- Keyword default boleh `chicken`.

---

## 20. Detail Screen Implementation

File:

```text id="r8ismf"
lib/screen/detail_screen.dart
```

Tugas:

1. Tampilkan gambar besar resep.
2. Tampilkan nama resep.
3. Tampilkan kategori.
4. Tampilkan area.
5. Tampilkan ingredients.
6. Tampilkan instructions.
7. Buat tombol Save to Saved Recipes.
8. Simpan data ke SQLite melalui `SavedRecipeController`.

Catatan:

- Data recipe dapat diterima dari `Get.arguments`.
- Jika detail API dipakai, panggil `fetchRecipeDetail(id)`.
- Gunakan `SingleChildScrollView` karena instructions bisa panjang.
- Gunakan desain dari `01_login_home_recipe_detail.png`.

---

## 21. Saved Recipes Screen Implementation

File:

```text id="j54ayx"
lib/screen/saved_recipes_screen.dart
```

Tugas:

1. Load data SQLite.
2. Tampilkan list Saved Recipes.
3. Tampilkan empty state jika kosong.
4. Tombol add recipe.
5. Tombol edit.
6. Tombol delete.
7. Navigation ke Home/Profile.

Catatan:

- Gunakan `SavedRecipeController`.
- Gunakan `Obx()`.
- Untuk gambar:
  1. Jika `localImagePath` ada, gunakan `Image.file`.
  2. Jika tidak ada tetapi `imageUrl` ada, gunakan `CachedNetworkImage`.
  3. Jika kosong, tampilkan placeholder.

---

## 22. Recipe Form Screen Implementation

File:

```text id="5gw0lh"
lib/screen/recipe_form_screen.dart
```

Tugas:

1. Bisa digunakan untuk Add dan Edit.
2. Jika mode Add, form kosong.
3. Jika mode Edit, form terisi data lama.
4. User bisa ambil foto.
5. Save insert data ke SQLite.
6. Update mengubah data SQLite.

Parameter yang dapat dikirim lewat `Get.arguments`:

```text id="n6vjsy"
mode: add / edit
recipe: MyRecipe
```

Field form:

```text id="p3g4uh"
Recipe Name
Category
Area / Origin
Ingredients
Instructions
Note
Photo
```

Validasi:

1. Recipe Name wajib.
2. Category wajib.
3. Ingredients wajib.
4. Instructions wajib.

Catatan:

- Gunakan `GlobalKey<FormState>`.
- Gunakan `TextEditingController`.
- Gunakan `SingleChildScrollView`.
- Gunakan multiline TextFormField untuk ingredients dan instructions.
- Gunakan desain dari `02_saved_recipes_form_crud.png`.

---

## 23. Profile Screen Implementation

File:

```text id="ss0gku"
lib/screen/profile_screen.dart
```

Tugas:

1. Tampilkan username `admin`.
2. Tampilkan subtitle `RecipeBook User`.
3. Tampilkan jumlah resep tersimpan.
4. Tampilkan app version `1.0.0`.
5. Tampilkan tombol logout.
6. Logout menggunakan dialog konfirmasi.

Catatan:

- Tidak perlu edit profile.
- Tidak perlu upload avatar.
- Gunakan desain dari `03_splash_profile_empty_error_states.png`.

---

## 24. Empty State dan Error State

Empty state dan error state bisa dibuat langsung di screen masing-masing atau dibuat sebagai widget kecil jika ingin rapi.

Jika ingin membuat widget kecil, tetap jangan menambah arsitektur berlebihan.

Empty state digunakan saat:

1. Saved Recipes kosong.
2. Search tidak menemukan hasil.

Error state digunakan saat:

1. API gagal.
2. SQLite gagal.
3. Data detail gagal dimuat.

Contoh teks empty state:

```text id="nxt4yq"
No recipes saved yet
Save your favorite recipe or add your own recipe.
```

Contoh teks error state:

```text id="lvb1tn"
Something went wrong
Failed to load recipe data. Please check your connection and try again.
```

---

## 25. Navigation Guide

Gunakan GetX navigation.

Contoh:

```dart id="1qnofw"
Get.to(() => const SavedRecipesScreen());
Get.to(() => DetailScreen(), arguments: recipe);
Get.back();
Get.offAll(() => const LoginScreen());
```

Aturan:

1. `Get.to()` untuk pindah halaman biasa.
2. `Get.back()` untuk kembali.
3. `Get.offAll()` untuk login/logout agar stack halaman dibersihkan.
4. Jangan membuat route management kompleks dulu.

---

## 26. Snackbar dan Dialog

Gunakan `Get.snackbar()` untuk pesan.

Contoh pesan sukses:

```text id="2h24rb"
Berhasil
Resep berhasil disimpan
```

Contoh pesan error:

```text id="3sdj3b"
Gagal
Gagal mengambil data resep
```

Gunakan `Get.dialog()` untuk:

1. Konfirmasi hapus resep.
2. Konfirmasi logout.

Dialog delete:

```text id="9fvyhp"
Title: Hapus Resep
Message: Apakah kamu yakin ingin menghapus resep ini?
Button: Batal, Hapus
```

Dialog logout:

```text id="459s88"
Title: Logout
Message: Apakah kamu yakin ingin keluar?
Button: Batal, Logout
```

---

## 27. REST API Implementation Notes

Endpoint yang digunakan:

```text id="kt3nu4"
GET /search.php?s=keyword
GET /lookup.php?i=id
```

Base URL:

```text id="pg67rh"
https://www.themealdb.com/api/json/v1/1
```

Hal yang perlu diperhatikan:

1. Response berada pada field `meals`.
2. `meals` bisa bernilai null jika data tidak ditemukan.
3. Ingredients tersebar dari `strIngredient1` sampai `strIngredient20`.
4. Measures tersebar dari `strMeasure1` sampai `strMeasure20`.
5. `strMealThumb` bisa kosong.
6. `strInstructions` bisa panjang.
7. Gunakan default text jika data kosong.

Jangan langsung percaya semua field API selalu ada.

---

## 28. SQLite Implementation Notes

Database:

```text id="3i5glt"
recipebook.db
```

Table:

```text id="w0zi4q"
my_recipes
```

Saat insert data baru:

1. `id` boleh null.
2. `api_id` boleh kosong.
3. `local_image_path` boleh kosong.
4. `image_url` boleh kosong.

Setelah insert/update/delete:

1. Panggil ulang `loadRecipes()`.
2. Tampilkan snackbar.
3. Kembali ke Saved Recipes jika dari form.

---

## 29. Camera Implementation Notes

Gunakan package:

```text id="k7xb3y"
image_picker
```

Flow:

```text id="y38kc9"
User klik tombol kamera
    ↓
ImagePicker membuka kamera
    ↓
User mengambil foto
    ↓
Path foto disimpan ke imagePath
    ↓
Preview foto ditampilkan
    ↓
Saat save, path disimpan ke SQLite
```

Catatan:

- Tidak perlu upload gambar ke server.
- Tidak perlu crop image.
- Tidak perlu compress image.
- Simpan path saja di SQLite.
- Jika user batal mengambil foto, jangan tampilkan error berlebihan.

---

## 30. UI Implementation Notes

Gunakan referensi desain dari folder:

```text id="2q5zpk"
docs/ui-reference/
```

Prinsip UI:

1. Light mode only.
2. Primary color orange hangat.
3. Background terang.
4. Card putih.
5. Rounded corner.
6. Soft shadow sederhana.
7. Jarak antar elemen cukup.
8. Tidak perlu animasi kompleks.
9. Gunakan Material Design sederhana.

Warna utama:

```text id="rq85zi"
Primary: #E65100
Secondary: #FF9800
Background: #FFF8F0
Text: #263238
Subtext: #757575
```

---

## 31. Manual Testing Checklist

Gunakan checklist ini setelah implementasi.

| No  | Test Case                                     | Status |
| --- | --------------------------------------------- | ------ |
| 1   | Aplikasi dapat dibuka                         | Belum  |
| 2   | Splash Screen tampil                          | Belum  |
| 3   | User belum login diarahkan ke Login           | Belum  |
| 4   | Login dengan username/password benar berhasil | Belum  |
| 5   | Login dengan username/password salah gagal    | Belum  |
| 6   | Home menampilkan list resep dari API          | Belum  |
| 7   | Search resep berjalan                         | Belum  |
| 8   | Detail resep tampil                           | Belum  |
| 9   | Save to Saved Recipes berhasil                | Belum  |
| 10  | Saved Recipes menampilkan data SQLite         | Belum  |
| 11  | Add Recipe berhasil                           | Belum  |
| 12  | Edit Recipe berhasil                          | Belum  |
| 13  | Delete Recipe berhasil                        | Belum  |
| 14  | Dialog delete muncul                          | Belum  |
| 15  | Kamera dapat mengambil foto                   | Belum  |
| 16  | Foto tampil di form                           | Belum  |
| 17  | Foto tersimpan sebagai path lokal             | Belum  |
| 18  | Profile tampil                                | Belum  |
| 19  | Logout berhasil                               | Belum  |
| 20  | Aplikasi tidak crash saat API gagal           | Belum  |

---

## 32. Hal yang Tidak Perlu Dikerjakan

Agar project tetap sederhana, jangan mengerjakan:

1. Register user.
2. Login backend asli.
3. Firebase.
4. Push notification.
5. AI recipe recommendation.
6. Upload foto ke server.
7. Maps.
8. Dark mode.
9. Multi-language.
10. Role admin dan user.
11. Clean Architecture.
12. Repository pattern.
13. Unit test.
14. Widget test.
15. Code generation.
16. Complex animation.
17. Advanced dependency injection.
18. Barcode scanner.
19. Meal planner kompleks.

---

## 33. Target Akhir Implementasi

Project dianggap selesai jika:

1. Aplikasi dapat dijalankan.
2. Splash mengecek status login.
3. Login dan logout berjalan.
4. Home menampilkan data resep dari API.
5. Search resep berjalan.
6. Detail resep tampil.
7. Resep dapat disimpan ke Saved Recipes.
8. Saved Recipes menggunakan SQLite.
9. CRUD SQLite berjalan.
10. Form tambah dan edit berjalan.
11. Kamera berjalan.
12. Foto tersimpan sebagai path lokal.
13. UI mengikuti referensi desain.
14. GetX digunakan untuk state dan navigation.
15. Project tetap sederhana dan sesuai `AGENTS.md`.

---

## 34. Kesimpulan

Implementation Guide ini menjadi panduan teknis untuk membangun RecipeBook App secara bertahap.

Ikuti dokumen ini bersama `AGENTS.md` agar project tetap sederhana, mudah dipahami, dan sesuai dengan materi perkuliahan Flutter.
