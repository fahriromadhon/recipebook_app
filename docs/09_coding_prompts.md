# Coding Prompts - RecipeBook App

## 1. Ringkasan

Dokumen ini berisi prompt bertahap untuk membantu agent/model membuat kode **RecipeBook App** secara aman dan terarah.

Gunakan prompt ini **satu per satu**, jangan langsung semua tahap sekaligus.

Urutan tahap:

1. Tahap 1 — Setup, Constants, Auth, Splash, Login
2. Tahap 2 — REST API, Home, Search, Detail
3. Tahap 3 — SQLite, Saved Recipes, Save from API
4. Tahap 4 — Add/Edit Recipe Form, Camera, CRUD
5. Tahap 5 — Profile, Logout, UI Cleanup, Empty/Error State
6. Tahap 6 — Final Bug Fix, README, Manual Testing

Project harus tetap mengikuti `AGENTS.md`.

---

# Tahap 1 — Setup, Constants, Auth, Splash, Login

## Prompt

Bantu saya mengerjakan **Tahap 1** untuk project Flutter **RecipeBook App**.

Project ini adalah aplikasi Flutter untuk project kuliah. Gunakan pendekatan sederhana sesuai `AGENTS.md`.

## Tujuan Tahap 1

Buat pondasi awal aplikasi:

1. Struktur folder.
2. Constants.
3. `main.dart` menggunakan `GetMaterialApp`.
4. `AuthController`.
5. `SplashScreen`.
6. `LoginScreen`.
7. Login sederhana menggunakan `SharedPreferences`.

## Tech Stack

Gunakan package berikut:

```bash
flutter pub add get http sqflite path path_provider image_picker shared_preferences intl cached_network_image
```

Untuk tahap ini yang digunakan dulu:

1. `get`
2. `shared_preferences`

## Struktur Folder

Buat struktur folder berikut:

```text
lib/
  main.dart

  model/

  controller/
    auth_controller.dart

  screen/
    splash_screen.dart
    login_screen.dart
    home_screen.dart

  dataaccess/

  provider/

  utils/
    constants.dart
```

Untuk sementara `home_screen.dart` boleh berupa placeholder sederhana.

## File yang Harus Dibuat

### 1. `lib/utils/constants.dart`

Isi dengan:

1. Nama aplikasi.
2. Versi aplikasi.
3. Base URL TheMealDB.
4. Warna utama aplikasi.
5. Username dan password default.

Gunakan warna:

```text
Primary: #E65100
Secondary: #FF9800
Background: #FFF8F0
Text: #263238
Subtext: #757575
Error: #D32F2F
```

Credential default:

```text
Username: admin
Password: admin123
```

---

### 2. `lib/main.dart`

Gunakan:

1. `GetMaterialApp`
2. `debugShowCheckedModeBanner: false`
3. `SplashScreen` sebagai halaman awal
4. Theme sederhana light mode

Jangan gunakan named routes kompleks dulu.

---

### 3. `lib/controller/auth_controller.dart`

Buat `AuthController extends GetxController`.

State minimal:

```dart
var isLoading = false.obs;
var isLoggedIn = false.obs;
```

Method yang dibutuhkan:

```dart
Future<void> checkLoginStatus()
Future<void> login(String username, String password)
Future<void> logout()
void showLogoutDialog()
```

Ketentuan:

1. Login menggunakan username `admin` dan password `admin123`.
2. Jika login berhasil, simpan status login ke SharedPreferences.
3. Jika login gagal, tampilkan `Get.snackbar()`.
4. Jika sudah login, arahkan ke `HomeScreen`.
5. Jika belum login, arahkan ke `LoginScreen`.
6. Gunakan `Get.offAll()` untuk login dan logout.

---

### 4. `lib/screen/splash_screen.dart`

Buat Splash Screen sederhana.

Isi UI:

1. Icon recipe book / restaurant / cooking.
2. Text `RecipeBook`.
3. Tagline `Find and save your favorite recipes`.
4. Loading indicator.
5. Text `Loading...`.

Saat screen dibuka:

1. Panggil `AuthController.checkLoginStatus()`.
2. Arahkan user sesuai status login.

Gunakan warna dari `constants.dart`.

---

### 5. `lib/screen/login_screen.dart`

Buat Login Screen sederhana.

Isi UI:

1. Logo/icon aplikasi.
2. App name `RecipeBook`.
3. Tagline.
4. Form username.
5. Form password.
6. Tombol login.

Gunakan:

1. `GlobalKey<FormState>`.
2. `TextEditingController`.
3. `TextFormField`.
4. Validator username dan password wajib diisi.
5. Password pakai `obscureText: true`.
6. Tombol login memanggil `AuthController.login()`.

Tidak perlu:

1. Register.
2. Forgot password.
3. Social login.

---

### 6. `lib/screen/home_screen.dart`

Untuk tahap ini cukup buat placeholder Home Screen.

Isi:

1. AppBar title `RecipeBook`.
2. Text tengah: `Home Screen`.
3. Tombol logout sementara boleh ada untuk test.

Nanti Home Screen asli dibuat di Tahap 2.

## Aturan Penting

1. Gunakan package import `package:recipebook_app/...`.
2. Jangan gunakan relative import seperti `../controller/...`.
3. Jangan gunakan Provider, Riverpod, BLoC, Firebase, Clean Architecture, atau Repository Pattern.
4. Jangan buat folder tambahan yang tidak diminta.
5. Kode harus bisa langsung dijalankan.
6. Pastikan tidak ada error import.
7. Pastikan `flutter analyze` aman dari error besar.

## Output yang Saya Mau

Berikan kode lengkap untuk semua file Tahap 1:

1. `lib/utils/constants.dart`
2. `lib/main.dart`
3. `lib/controller/auth_controller.dart`
4. `lib/screen/splash_screen.dart`
5. `lib/screen/login_screen.dart`
6. `lib/screen/home_screen.dart`

Jangan lompat ke tahap berikutnya.
Jangan membuat fitur API atau SQLite dulu.

````

---

# Tahap 2 — REST API, Home, Search, Detail

## Prompt

Bantu saya mengerjakan **Tahap 2** untuk project Flutter **RecipeBook App**.

Tahap 1 sudah selesai dengan:

1. Constants.
2. Main app.
3. AuthController.
4. SplashScreen.
5. LoginScreen.
6. Placeholder HomeScreen.

Sekarang lanjutkan ke fitur REST API, Home list resep, search, dan detail resep.

## Tujuan Tahap 2

Buat fitur:

1. Model `Recipe`.
2. `RecipeController`.
3. Home Screen asli dengan data API.
4. Search resep.
5. Detail Screen.
6. Save button placeholder, belum perlu SQLite.

## API

Gunakan TheMealDB API.

Base URL sudah ada di:

```text
lib/utils/constants.dart
````

Base URL:

```text
https://www.themealdb.com/api/json/v1/1
```

Endpoint:

```text
GET /search.php?s=keyword
GET /lookup.php?i=id
```

Keyword default:

```text
chicken
```

## File yang Harus Dibuat / Diubah

### 1. `lib/model/recipe.dart`

Buat model `Recipe`.

Field:

```dart
String apiId;
String name;
String category;
String area;
String imageUrl;
String instructions;
String ingredients;
String youtubeUrl;
```

Gunakan:

1. Constructor biasa.
2. `factory Recipe.fromMap(Map<String, dynamic> map)`.
3. `Map<String, dynamic> toMap()`.

Catatan penting:

TheMealDB menyimpan ingredients di:

```text
strIngredient1 sampai strIngredient20
```

Measures ada di:

```text
strMeasure1 sampai strMeasure20
```

Gabungkan menjadi string seperti:

```text
Chicken - 500g
Salt - 1 tsp
Garlic - 2 cloves
```

Jika data kosong, gunakan default text sederhana.

---

### 2. `lib/controller/recipe_controller.dart`

Buat `RecipeController extends GetxController`.

State:

```dart
var recipes = <Recipe>[].obs;
var selectedRecipe = Rxn<Recipe>();
var isLoading = false.obs;
var errorMessage = "".obs;
```

Method:

```dart
Future<void> fetchRecipes()
Future<void> searchRecipes(String keyword)
Future<void> fetchRecipeDetail(String id)
void clearRecipes()
```

Ketentuan:

1. Gunakan package `http`.
2. Gunakan `jsonDecode`.
3. Gunakan try-catch.
4. Jika API berhasil dan `meals` tidak null, isi list recipes.
5. Jika `meals` null, kosongkan recipes dan tampilkan empty state.
6. Jika gagal, tampilkan `Get.snackbar()`.
7. Jangan gunakan Dio.
8. Jangan buat service/repository.

---

### 3. Update `lib/screen/home_screen.dart`

Ubah placeholder Home Screen menjadi Home Screen asli.

UI harus berisi:

1. AppBar title `RecipeBook`.
2. Icon Saved Recipes di AppBar, untuk sementara boleh tampilkan snackbar `Coming soon`.
3. Icon Profile di AppBar, arahkan ke Profile nanti di Tahap 5 atau snackbar sementara.
4. Search bar.
5. Tombol search.
6. Section title `Popular Recipes`.
7. ListView resep.
8. Loading state.
9. Empty state sederhana.
10. Error state sederhana.

Recipe card berisi:

1. Gambar resep.
2. Nama resep.
3. Category.
4. Area.

Gunakan `CachedNetworkImage`.

Saat card diklik:

```dart
Get.to(() => const DetailScreen(), arguments: recipe);
```

---

### 4. `lib/screen/detail_screen.dart`

Buat Detail Screen.

Alur:

1. Ambil `Recipe` dari `Get.arguments`.
2. Panggil detail API berdasarkan `apiId`.
3. Tampilkan detail recipe.

UI berisi:

1. AppBar.
2. Gambar besar resep.
3. Nama resep.
4. Category.
5. Area.
6. Ingredients.
7. Instructions.
8. Tombol `Save to Saved Recipes`.

Untuk tahap ini tombol save belum perlu SQLite. Saat diklik tampilkan:

```text
Saved Recipes will be added in Tahap 3
```

Gunakan `Get.snackbar()`.

## Aturan Penting

1. Jangan buat SQLite dulu.
2. Jangan buat SavedRecipeController dulu.
3. Jangan buat Recipe Form dulu.
4. Jangan gunakan service/repository.
5. API logic tetap di `RecipeController`.
6. Gunakan `Obx()` untuk state.
7. Gunakan package import.
8. Kode harus tetap sederhana.

## Output yang Saya Mau

Berikan kode lengkap untuk:

1. `lib/model/recipe.dart`
2. `lib/controller/recipe_controller.dart`
3. `lib/screen/home_screen.dart`
4. `lib/screen/detail_screen.dart`

Jika perlu update import di file lain, berikan juga.

````

---

# Tahap 3 — SQLite, Saved Recipes, Save from API

## Prompt

Bantu saya mengerjakan **Tahap 3** untuk project Flutter **RecipeBook App**.

Tahap 1 dan 2 sudah selesai:

1. Login dan splash berjalan.
2. Home menampilkan resep dari API.
3. Search resep berjalan.
4. Detail resep berjalan.
5. Tombol save masih placeholder.

Sekarang buat SQLite, Saved Recipes, dan fitur menyimpan resep dari API ke SQLite.

## Tujuan Tahap 3

Buat fitur:

1. Model `MyRecipe`.
2. Database provider SQLite.
3. DataAccess untuk CRUD SQLite.
4. `SavedRecipeController`.
5. `SavedRecipesScreen`.
6. Tombol `Save to Saved Recipes` di Detail Screen benar-benar menyimpan ke SQLite.
7. Navigasi dari Home ke Saved Recipes.

## Database

Nama database:

```text
recipebook.db
````

Nama table:

```text
my_recipes
```

Kolom:

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

SQL:

```sql
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

## File yang Harus Dibuat / Diubah

### 1. `lib/model/my_recipe.dart`

Buat model `MyRecipe`.

Field:

```dart
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
```

Gunakan:

1. Constructor biasa.
2. `factory MyRecipe.fromMap(Map<String, dynamic> map)`.
3. `Map<String, dynamic> toMap()`.

Catatan:

Saat insert, jika `id == null`, pastikan tidak membuat error. Boleh buat method tambahan `toInsertMap()` yang tidak menyertakan `id`.

---

### 2. `lib/provider/database_provider.dart`

Buat database provider SQLite.

Gunakan:

1. `sqflite`
2. `path_provider`
3. `path`

Ketentuan:

1. Singleton sederhana.
2. Membuka database `recipebook.db`.
3. Membuat table `my_recipes`.
4. Version database `1`.
5. Pakai `getApplicationDocumentsDirectory()`.

---

### 3. `lib/dataaccess/my_recipe_dataaccess.dart`

Buat DataAccess untuk CRUD.

Method:

```dart
Future<int> insertRecipe(MyRecipe recipe)
Future<List<MyRecipe>> getAllRecipes()
Future<MyRecipe?> getRecipeById(int id)
Future<int> updateRecipe(MyRecipe recipe)
Future<int> deleteRecipe(int id)
```

Aturan:

1. Jangan ada UI logic di DataAccess.
2. Jangan ada snackbar di DataAccess.
3. DataAccess hanya query SQLite.

---

### 4. `lib/controller/saved_recipe_controller.dart`

Buat `SavedRecipeController extends GetxController`.

State:

```dart
var savedRecipes = <MyRecipe>[].obs;
var isLoading = false.obs;
```

Method:

```dart
Future<void> loadRecipes()
Future<void> addRecipe(MyRecipe recipe)
Future<void> updateRecipe(MyRecipe recipe)
Future<void> deleteRecipe(int id)
Future<void> saveRecipeFromApi(Recipe recipe)
void showDeleteDialog(MyRecipe recipe)
```

`saveRecipeFromApi()` harus mapping dari `Recipe` ke `MyRecipe`.

Mapping:

```text
Recipe.apiId        → MyRecipe.apiId
Recipe.name         → MyRecipe.name
Recipe.category     → MyRecipe.category
Recipe.area         → MyRecipe.area
Recipe.imageUrl     → MyRecipe.imageUrl
Recipe.instructions → MyRecipe.instructions
Recipe.ingredients  → MyRecipe.ingredients
""                  → MyRecipe.localImagePath
""                  → MyRecipe.note
current date        → MyRecipe.createdAt
```

Gunakan `intl` untuk tanggal jika perlu.

---

### 5. Buat `lib/screen/saved_recipes_screen.dart`

UI berisi:

1. AppBar title `Saved Recipes`.
2. ListView resep dari SQLite.
3. Empty state jika kosong.
4. Card resep.
5. Gambar resep:

   * jika `localImagePath` ada, gunakan `Image.file`
   * jika tidak ada, gunakan `CachedNetworkImage`
   * jika kosong semua, gunakan placeholder
6. Tombol edit untuk sementara boleh snackbar `Edit will be added in Tahap 4`.
7. Tombol delete sudah aktif.
8. FloatingActionButton add untuk sementara snackbar `Add Recipe will be added in Tahap 4`.

---

### 6. Update `lib/screen/detail_screen.dart`

Tombol `Save to Saved Recipes` harus memanggil:

```dart
SavedRecipeController.saveRecipeFromApi(recipe)
```

Setelah berhasil:

1. Tampilkan snackbar.
2. Tetap di detail screen atau boleh arahkan ke Saved Recipes.

---

### 7. Update `lib/screen/home_screen.dart`

Icon Saved Recipes di AppBar harus membuka:

```dart
Get.to(() => const SavedRecipesScreen());
```

## Aturan Penting

1. Jangan buat form tambah/edit dulu.
2. Jangan buat kamera dulu.
3. Jangan buat profile dulu.
4. Jangan gunakan repository/service.
5. SQLite logic hanya di provider dan dataaccess.
6. Controller yang mengatur snackbar.
7. Gunakan package import.
8. Kode harus bisa dijalankan.

## Output yang Saya Mau

Berikan kode lengkap untuk:

1. `lib/model/my_recipe.dart`
2. `lib/provider/database_provider.dart`
3. `lib/dataaccess/my_recipe_dataaccess.dart`
4. `lib/controller/saved_recipe_controller.dart`
5. `lib/screen/saved_recipes_screen.dart`
6. Update `lib/screen/detail_screen.dart`
7. Update `lib/screen/home_screen.dart`

````

---

# Tahap 4 — Add/Edit Recipe Form, Camera, CRUD

## Prompt

Bantu saya mengerjakan **Tahap 4** untuk project Flutter **RecipeBook App**.

Tahap 1 sampai 3 sudah selesai:

1. Login dan splash.
2. API recipe list, search, detail.
3. SQLite.
4. Saved Recipes.
5. Save recipe dari API ke SQLite.
6. Delete recipe dari SQLite.

Sekarang lanjutkan fitur form tambah/edit resep dan kamera.

## Tujuan Tahap 4

Buat fitur:

1. `RecipeFormScreen`.
2. Add personal recipe.
3. Edit saved recipe.
4. Update SQLite.
5. Ambil foto makanan menggunakan kamera.
6. Simpan path foto lokal ke SQLite.
7. Preview foto di form.
8. Update navigation dari Saved Recipes.

## File yang Harus Dibuat / Diubah

### 1. Update `lib/controller/saved_recipe_controller.dart`

Tambahkan state:

```dart
var imagePath = "".obs;
````

Tambahkan method:

```dart
Future<void> pickImageFromCamera()
void setImagePath(String path)
void clearImage()
```

Gunakan:

```dart
ImagePicker()
```

Ketentuan:

1. Source kamera.
2. Jika user batal, jangan crash.
3. Jika berhasil, simpan path ke `imagePath`.
4. Jangan upload foto ke server.
5. Jangan compress/crop image.

Pastikan method add/update tetap memanggil `loadRecipes()` setelah berhasil.

---

### 2. Buat `lib/screen/recipe_form_screen.dart`

Screen ini dipakai untuk dua mode:

1. Add
2. Edit

Gunakan `Get.arguments`.

Contoh argument:

```dart
{
  "mode": "add"
}
```

atau:

```dart
{
  "mode": "edit",
  "recipe": recipe
}
```

Form field:

```text
Recipe Name
Category
Area / Origin
Ingredients
Instructions
Note
Photo
```

Validasi wajib:

1. Recipe Name.
2. Category.
3. Ingredients.
4. Instructions.

Komponen UI:

1. Scaffold.
2. AppBar.
3. SingleChildScrollView.
4. Form.
5. TextFormField.
6. Photo container.
7. Camera button.
8. Save/Update button.

Jika mode add:

1. AppBar title `Add Recipe`.
2. Form kosong.
3. Tombol `Save Recipe`.

Jika mode edit:

1. AppBar title `Edit Recipe`.
2. Form terisi data lama.
3. Tombol `Update Recipe`.
4. Foto lama tampil jika ada.

Saat save:

1. Buat object `MyRecipe`.
2. `apiId` kosong.
3. `imageUrl` kosong.
4. `localImagePath` dari `imagePath`.
5. `createdAt` tanggal sekarang.
6. Panggil `SavedRecipeController.addRecipe()`.

Saat update:

1. Gunakan `id` lama.
2. Pertahankan `apiId` lama.
3. Pertahankan `imageUrl` lama jika tidak diganti.
4. Gunakan `localImagePath` baru jika ada.
5. Panggil `SavedRecipeController.updateRecipe()`.

Setelah sukses:

```dart
Get.back();
```

atau kembali ke Saved Recipes.

---

### 3. Update `lib/screen/saved_recipes_screen.dart`

Aktifkan:

1. FloatingActionButton Add Recipe.
2. Edit button.
3. Delete button tetap jalan.

Navigasi Add:

```dart
Get.to(() => const RecipeFormScreen(), arguments: {
  "mode": "add",
});
```

Navigasi Edit:

```dart
Get.to(() => const RecipeFormScreen(), arguments: {
  "mode": "edit",
  "recipe": recipe,
});
```

Saat kembali dari form, pastikan list refresh.

## Aturan Penting

1. Gunakan satu screen saja untuk add dan edit.
2. Jangan buat screen terpisah `add_recipe_screen.dart` dan `edit_recipe_screen.dart`.
3. Jangan upload image.
4. Jangan simpan binary image di SQLite.
5. Simpan path saja.
6. Jangan gunakan package tambahan.
7. Jangan gunakan repository/service.
8. Gunakan `Get.snackbar()` untuk pesan.
9. Gunakan `Get.dialog()` untuk delete confirmation.
10. Gunakan package import.

## Output yang Saya Mau

Berikan kode lengkap untuk:

1. Update `lib/controller/saved_recipe_controller.dart`
2. `lib/screen/recipe_form_screen.dart`
3. Update `lib/screen/saved_recipes_screen.dart`

Jika ada import lain yang perlu diubah, sertakan juga.

````

---

# Tahap 5 — Profile, Logout, UI Cleanup, Empty/Error State

## Prompt

Bantu saya mengerjakan **Tahap 5** untuk project Flutter **RecipeBook App**.

Tahap 1 sampai 4 sudah selesai:

1. Login.
2. Splash.
3. Home API.
4. Search.
5. Detail.
6. SQLite.
7. Saved Recipes.
8. Add/Edit/Delete recipe.
9. Camera.

Sekarang lanjutkan Profile Screen, logout, UI cleanup, empty state, dan error state.

## Tujuan Tahap 5

Buat dan rapikan:

1. `ProfileScreen`.
2. Logout confirmation.
3. Total saved recipes di Profile.
4. Navigation Home ↔ Saved Recipes ↔ Profile.
5. Empty state yang lebih rapi.
6. Error state sederhana.
7. UI cleanup agar konsisten dengan tema RecipeBook.

## File yang Harus Dibuat / Diubah

### 1. Buat `lib/screen/profile_screen.dart`

UI berisi:

1. AppBar title `Profile`.
2. Avatar icon/user icon.
3. Username `admin`.
4. Subtitle `RecipeBook User`.
5. Card total saved recipes.
6. Card app version `1.0.0`.
7. Tombol logout.
8. Navigation ke Home dan Saved Recipes jika dibutuhkan.

Gunakan:

1. `AuthController`.
2. `SavedRecipeController`.

Logout:

1. Gunakan `AuthController.showLogoutDialog()`.
2. Dialog konfirmasi:
   - Title: `Logout`
   - Message: `Apakah kamu yakin ingin keluar?`
   - Button: `Batal`
   - Button: `Logout`
3. Jika logout, hapus status login dan arahkan ke Login Screen.

---

### 2. Update `lib/screen/home_screen.dart`

Rapikan:

1. AppBar punya icon Saved Recipes.
2. AppBar punya icon Profile.
3. Search bar lebih rapi.
4. Recipe card konsisten.
5. Empty state jika search tidak ada hasil.
6. Error snackbar tetap ada.

Navigasi:

```dart
Get.to(() => const SavedRecipesScreen());
Get.to(() => const ProfileScreen());
````

---

### 3. Update `lib/screen/saved_recipes_screen.dart`

Rapikan:

1. AppBar punya icon Home atau Profile.
2. Empty state lebih rapi.
3. Recipe card lebih konsisten.
4. Delete button tetap jelas.
5. Add button tetap jelas.

Empty state teks:

```text
No recipes saved yet
Save your favorite recipe or add your own recipe.
```

Button:

```text
Add Recipe
```

---

### 4. Update `lib/screen/detail_screen.dart`

Rapikan:

1. Gambar header.
2. Category dan area chip/card.
3. Ingredients section.
4. Instructions section.
5. Save button.
6. Placeholder jika gambar kosong.

---

### 5. Update `lib/screen/recipe_form_screen.dart`

Rapikan:

1. Photo area.
2. Form spacing.
3. Multiline input untuk ingredients dan instructions.
4. Button full-width.
5. Warna sesuai constants.

---

## UI Style

Gunakan style:

```text
Primary: #E65100
Secondary: #FF9800
Background: #FFF8F0
Card: #FFFFFF
Text: #263238
Subtext: #757575
Error: #D32F2F
```

Prinsip UI:

1. Light mode only.
2. Rounded card.
3. Spacing nyaman.
4. Tidak terlalu ramai.
5. Mudah dibuat dengan widget standar Flutter.
6. Tidak pakai animasi kompleks.
7. Tidak pakai dark mode.

## Aturan Penting

1. Jangan ubah arsitektur.
2. Jangan buat repository/service.
3. Jangan tambah package baru.
4. Jangan buat fitur baru di luar scope.
5. Jangan buat register.
6. Jangan buat upload foto.
7. Jangan pakai Firebase.
8. Jangan pakai bottom navigation kompleks jika tidak perlu.
9. Gunakan GetX navigation.

## Output yang Saya Mau

Berikan kode lengkap untuk:

1. `lib/screen/profile_screen.dart`
2. Update `lib/screen/home_screen.dart`
3. Update `lib/screen/saved_recipes_screen.dart`
4. Update `lib/screen/detail_screen.dart`
5. Update `lib/screen/recipe_form_screen.dart`
6. Update controller jika diperlukan

Pastikan aplikasi tetap bisa dijalankan.

````

---

# Tahap 6 — Final Bug Fix, README, Manual Testing

## Prompt

Bantu saya mengerjakan **Tahap 6 / Finalisasi** untuk project Flutter **RecipeBook App**.

Tahap 1 sampai 5 sudah selesai. Sekarang lakukan final bug fix, perapian akhir, README, dan manual testing checklist.

## Tujuan Tahap 6

Finalisasi project agar siap dikumpulkan dan dipresentasikan.

Fokus pada:

1. Bug fix.
2. Import check.
3. Navigation check.
4. SQLite check.
5. API check.
6. Camera check.
7. UI consistency.
8. README.
9. Manual testing checklist.
10. Tidak menambah fitur besar baru.

## Hal yang Harus Dicek

### 1. Struktur Folder

Pastikan struktur folder seperti ini:

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
````

Jangan ada folder:

```text
repository/
usecase/
services/
bloc/
domain/
infrastructure/
```

---

### 2. Check Package

Pastikan package yang digunakan hanya:

```text
get
http
sqflite
path
path_provider
image_picker
shared_preferences
intl
cached_network_image
cupertino_icons
flutter_lints
```

Jangan tambah package baru.

---

### 3. Check Import

Pastikan import menggunakan format package:

```dart
import 'package:recipebook_app/controller/auth_controller.dart';
```

Hindari relative import:

```dart
import '../controller/auth_controller.dart';
```

---

### 4. Check Navigation

Pastikan alur berjalan:

```text
Splash
  ├── Login jika belum login
  └── Home jika sudah login

Login
  └── Home

Home
  ├── Detail
  ├── Saved Recipes
  └── Profile

Detail
  └── Save to Saved Recipes

Saved Recipes
  ├── Add Recipe
  ├── Edit Recipe
  └── Delete Recipe

Profile
  └── Logout ke Login
```

---

### 5. Check API

Pastikan:

1. Home bisa load data resep.
2. Search berjalan.
3. Detail berjalan.
4. Jika API gagal, aplikasi tidak crash.
5. Jika `meals == null`, tampilkan empty state.
6. Ingredients tidak error walaupun field kosong.

---

### 6. Check SQLite

Pastikan:

1. Database `recipebook.db` dibuat.
2. Table `my_recipes` dibuat.
3. Insert berjalan.
4. Read berjalan.
5. Update berjalan.
6. Delete berjalan.
7. Save from API ke SQLite berjalan.
8. Add manual recipe berjalan.

---

### 7. Check Camera

Pastikan:

1. Tombol kamera membuka kamera.
2. Jika user batal, aplikasi tidak crash.
3. Foto tampil sebagai preview.
4. Path foto tersimpan ke SQLite.
5. Foto tampil di Saved Recipes.

---

### 8. Check UI

Pastikan UI konsisten:

1. Light mode.
2. Primary color orange.
3. Background warm.
4. Card putih.
5. Button rapi.
6. Spacing cukup.
7. Tidak overflow.
8. Instructions panjang bisa discroll.
9. Form aman saat keyboard muncul.
10. Empty/error state jelas.

---

## README.md

Buat `README.md` untuk project.

Isi README:

1. Nama project.
2. Deskripsi singkat.
3. Fitur utama.
4. Teknologi yang digunakan.
5. Public API.
6. Struktur folder.
7. Cara menjalankan.
8. Akun login default.
9. Mapping fitur ke materi kuliah.
10. Screenshot section placeholder.
11. Manual testing checklist.
12. Catatan batasan project.

## Format README

Gunakan format markdown rapi.

Judul:

```text
# RecipeBook App
```

Credential:

```text
Username: admin
Password: admin123
```

Cara menjalankan:

```bash
flutter pub get
flutter run
```

Package install:

```bash
flutter pub add get http sqflite path path_provider image_picker shared_preferences intl cached_network_image
```

## Manual Testing Checklist

Buat checklist:

```markdown
- [ ] Aplikasi dapat dibuka
- [ ] Splash Screen tampil
- [ ] Login berhasil dengan credential benar
- [ ] Login gagal dengan credential salah
- [ ] Home menampilkan resep dari API
- [ ] Search resep berjalan
- [ ] Detail resep tampil
- [ ] Save to Saved Recipes berhasil
- [ ] Saved Recipes menampilkan data SQLite
- [ ] Add recipe berhasil
- [ ] Edit recipe berhasil
- [ ] Delete recipe berhasil
- [ ] Kamera dapat mengambil foto
- [ ] Foto tampil di form
- [ ] Foto tampil di Saved Recipes
- [ ] Profile tampil
- [ ] Logout berhasil
- [ ] Aplikasi tidak crash saat API gagal
```

## Aturan Penting

1. Jangan tambah fitur baru besar.
2. Jangan ubah arsitektur.
3. Jangan tambah package.
4. Jangan ubah GetX ke state management lain.
5. Jangan gunakan Firebase.
6. Jangan gunakan Repository Pattern.
7. Jangan gunakan Clean Architecture.
8. Fokus bug fix dan finalisasi.

## Output yang Saya Mau

Berikan:

1. Daftar bug atau potensi bug yang ditemukan.
2. Kode yang perlu diperbaiki.
3. `README.md` lengkap.
4. Manual testing checklist.
5. Catatan final apakah project sudah siap presentasi.

Jika ada banyak file yang perlu diubah, berikan satu per satu dengan nama file jelas.

```
```
