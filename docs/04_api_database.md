# API & Database - RecipeBook App

## 1. Ringkasan

Dokumen ini menjelaskan rancangan penggunaan REST API dan database lokal SQLite pada **RecipeBook App**.

Aplikasi menggunakan dua sumber data utama:

1. **Public API**
   Digunakan untuk mengambil daftar resep dan detail resep.

2. **SQLite Local Database**
   Digunakan untuk menyimpan resep favorit dan resep pribadi pengguna pada fitur Saved Recipes.

Project ini dibuat sederhana sesuai kebutuhan mata kuliah Flutter. Struktur project mengikuti MVC sederhana:

```text
lib/
  model/
  controller/
  screen/
  dataaccess/
  provider/
  utils/
```

---

## 2. Public API

## 2.1 API yang Digunakan

Public API utama yang digunakan:

```text
TheMealDB API
```

Base URL:

```text
https://www.themealdb.com/api/json/v1/1
```

API ini digunakan untuk mengambil data resep seperti nama makanan, kategori, area, gambar, bahan-bahan, dan instruksi memasak.

---

## 2.2 API Key

TheMealDB API versi dasar dapat digunakan tanpa API key khusus.

Base URL public yang digunakan:

```text
https://www.themealdb.com/api/json/v1/1
```

Catatan:

1. Tidak perlu membuat akun API untuk MVP.
2. Tidak perlu menyimpan API key.
3. Base URL tetap disimpan di `constants.dart`.
4. Jika nanti API berubah atau menggunakan API berbayar, konfigurasi API key harus diletakkan di `constants.dart`.

Rekomendasi file konfigurasi:

```text
lib/utils/constants.dart
```

Contoh isi:

```dart
const String baseUrl = "https://www.themealdb.com/api/json/v1/1";
```

---

## 3. Endpoint API

## 3.1 Search Recipe

Endpoint ini digunakan untuk mencari resep berdasarkan keyword.

### Request

```text
GET /search.php?s=KEYWORD
```

### Full URL Contoh

```text
https://www.themealdb.com/api/json/v1/1/search.php?s=chicken
```

### Fungsi di Aplikasi

Digunakan pada:

```text
Home Screen
Search Recipe
```

### Data yang Diambil

1. ID resep.
2. Nama resep.
3. Kategori.
4. Area.
5. Gambar resep.
6. Instruksi.
7. Ingredients.
8. Measures.

### Catatan

Jika keyword kosong, endpoint dapat tetap digunakan:

```text
/search.php?s=
```

Namun untuk UI yang lebih rapi, aplikasi bisa menggunakan keyword default seperti:

```text
chicken
```

atau

```text
beef
```

---

## 3.2 Get Recipe Detail

Endpoint ini digunakan untuk mengambil detail resep berdasarkan ID.

### Request

```text
GET /lookup.php?i=ID_RECIPE
```

### Full URL Contoh

```text
https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772
```

### Fungsi di Aplikasi

Digunakan pada:

```text
Detail Screen
```

### Data yang Diambil

1. ID resep.
2. Nama resep.
3. Kategori.
4. Area.
5. Gambar resep.
6. Instruksi.
7. Ingredients.
8. Measures.
9. YouTube URL jika tersedia.

---

## 3.3 Get Categories

Endpoint ini digunakan untuk mengambil daftar kategori resep.

### Request

```text
GET /categories.php
```

### Full URL Contoh

```text
https://www.themealdb.com/api/json/v1/1/categories.php
```

### Fungsi di Aplikasi

Digunakan jika ingin menambahkan fitur kategori.

### Catatan

Endpoint kategori bersifat opsional untuk MVP. Jika ingin tetap sederhana, fitur kategori tidak wajib dibuat.

---

## 3.4 Filter by Category

Endpoint ini digunakan untuk mengambil resep berdasarkan kategori.

### Request

```text
GET /filter.php?c=CATEGORY
```

### Full URL Contoh

```text
https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
```

### Fungsi di Aplikasi

Digunakan jika ingin menambahkan filter kategori.

### Catatan

Endpoint filter kategori bersifat opsional untuk MVP.

---

## 4. Struktur Response API

## 4.1 Response Search Recipe

Contoh response sederhana:

```json
{
  "meals": [
    {
      "idMeal": "52772",
      "strMeal": "Teriyaki Chicken Casserole",
      "strCategory": "Chicken",
      "strArea": "Japanese",
      "strInstructions": "Preheat oven to 350 degrees...",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
      "strIngredient1": "soy sauce",
      "strIngredient2": "water",
      "strMeasure1": "3/4 cup",
      "strMeasure2": "1/2 cup"
    }
  ]
}
```

### Field yang Digunakan

| Field API           | Digunakan Sebagai | Keterangan        |
| ------------------- | ----------------- | ----------------- |
| `idMeal`            | `apiId`           | ID resep dari API |
| `strMeal`           | `name`            | Nama resep        |
| `strCategory`       | `category`        | Kategori resep    |
| `strArea`           | `area`            | Asal/area makanan |
| `strMealThumb`      | `imageUrl`        | Gambar resep      |
| `strInstructions`   | `instructions`    | Instruksi memasak |
| `strIngredient1-20` | `ingredients`     | Bahan-bahan       |
| `strMeasure1-20`    | `ingredients`     | Takaran bahan     |

---

## 4.2 Response Recipe Detail

Response detail resep memiliki struktur yang mirip dengan response search.

Contoh response sederhana:

```json
{
  "meals": [
    {
      "idMeal": "52772",
      "strMeal": "Teriyaki Chicken Casserole",
      "strCategory": "Chicken",
      "strArea": "Japanese",
      "strInstructions": "Preheat oven to 350 degrees...",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
      "strYoutube": "https://www.youtube.com/watch?v=4aZr5hZXP_s",
      "strIngredient1": "soy sauce",
      "strIngredient2": "water",
      "strIngredient3": "brown sugar",
      "strMeasure1": "3/4 cup",
      "strMeasure2": "1/2 cup",
      "strMeasure3": "4 tablespoons"
    }
  ]
}
```

### Field yang Digunakan

| Field API           | Digunakan Sebagai | Keterangan           |
| ------------------- | ----------------- | -------------------- |
| `idMeal`            | `apiId`           | ID resep dari API    |
| `strMeal`           | `name`            | Nama resep           |
| `strCategory`       | `category`        | Kategori             |
| `strArea`           | `area`            | Asal/area makanan    |
| `strMealThumb`      | `imageUrl`        | Gambar resep         |
| `strInstructions`   | `instructions`    | Instruksi memasak    |
| `strYoutube`        | `youtubeUrl`      | Link video, opsional |
| `strIngredient1-20` | `ingredients`     | Bahan-bahan          |
| `strMeasure1-20`    | `ingredients`     | Takaran bahan        |

---

## 5. Model Data

Project menggunakan model sederhana dengan `fromMap()` dan `toMap()` manual.

Tidak menggunakan:

1. Freezed.
2. Json Serializable.
3. Build Runner.
4. Immutable pattern.
5. CopyWith.

---

## 5.1 Model Recipe

Model `Recipe` digunakan untuk data resep dari API.

File:

```text
lib/model/recipe.dart
```

Field:

| Field          | Tipe   | Keterangan                    |
| -------------- | ------ | ----------------------------- |
| `apiId`        | String | ID resep dari API             |
| `name`         | String | Nama resep                    |
| `category`     | String | Kategori resep                |
| `area`         | String | Asal/area makanan             |
| `imageUrl`     | String | URL gambar resep              |
| `instructions` | String | Instruksi memasak             |
| `ingredients`  | String | Bahan-bahan dalam bentuk teks |
| `youtubeUrl`   | String | Link YouTube jika tersedia    |

Catatan:

1. Field dibuat public.
2. Field tidak perlu final.
3. Jika data dari API kosong, gunakan string kosong atau `Data tidak tersedia`.
4. Ingredients dari API tersebar di `strIngredient1` sampai `strIngredient20`.
5. Measures dari API tersebar di `strMeasure1` sampai `strMeasure20`.
6. Gabungkan ingredients dan measures menjadi satu string sederhana.

Contoh format ingredients:

```text
soy sauce - 3/4 cup
water - 1/2 cup
brown sugar - 4 tablespoons
```

---

## 5.2 Model MyRecipe

Model `MyRecipe` digunakan untuk data resep yang disimpan di SQLite.

File:

```text
lib/model/my_recipe.dart
```

Field:

| Field            | Tipe   | Keterangan                                   |
| ---------------- | ------ | -------------------------------------------- |
| `id`             | int?   | ID lokal SQLite                              |
| `apiId`          | String | ID dari API, boleh kosong untuk resep manual |
| `name`           | String | Nama resep                                   |
| `category`       | String | Kategori                                     |
| `area`           | String | Asal/area makanan                            |
| `imageUrl`       | String | URL gambar dari API                          |
| `localImagePath` | String | Path foto dari kamera                        |
| `instructions`   | String | Instruksi memasak                            |
| `ingredients`    | String | Bahan-bahan                                  |
| `note`           | String | Catatan pengguna                             |
| `createdAt`      | String | Tanggal dibuat                               |

Catatan:

1. `id` boleh null saat data belum masuk ke SQLite.
2. `apiId` boleh kosong untuk resep manual.
3. `localImagePath` boleh kosong.
4. `imageUrl` boleh kosong.
5. Ingredients disimpan sebagai teks biasa, bukan table terpisah.

---

## 6. SQLite Database

## 6.1 Nama Database

Nama database:

```text
recipebook.db
```

---

## 6.2 Versi Database

Versi awal database:

```text
1
```

---

## 6.3 Table

Nama table:

```text
my_recipes
```

Table ini menyimpan data resep yang disimpan oleh pengguna.

---

## 6.4 Struktur Table `my_recipes`

| Kolom              | Tipe SQLite                       | Keterangan                  |
| ------------------ | --------------------------------- | --------------------------- |
| `id`               | INTEGER PRIMARY KEY AUTOINCREMENT | ID lokal                    |
| `api_id`           | TEXT                              | ID dari API                 |
| `name`             | TEXT                              | Nama resep                  |
| `category`         | TEXT                              | Kategori                    |
| `area`             | TEXT                              | Asal/area makanan           |
| `image_url`        | TEXT                              | URL gambar dari API         |
| `local_image_path` | TEXT                              | Path foto lokal dari kamera |
| `instructions`     | TEXT                              | Instruksi memasak           |
| `ingredients`      | TEXT                              | Bahan-bahan                 |
| `note`             | TEXT                              | Catatan pengguna            |
| `created_at`       | TEXT                              | Tanggal dibuat              |

---

## 6.5 SQL Create Table

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

---

## 7. Provider Database

Database provider digunakan untuk membuka database SQLite.

File:

```text
lib/provider/database_provider.dart
```

Tanggung jawab:

1. Membuat koneksi database.
2. Membuat database jika belum ada.
3. Membuat table `my_recipes`.
4. Menyediakan object database untuk dataaccess.

Catatan:

Database provider dibuat sebagai singleton sederhana agar koneksi database tidak dibuat berulang-ulang.

Gunakan:

1. `sqflite`
2. `path_provider`
3. `path`

Path database dibuat menggunakan:

```text
getApplicationDocumentsDirectory()
```

---

## 8. DataAccess

DataAccess digunakan untuk fungsi CRUD SQLite.

File:

```text
lib/dataaccess/my_recipe_dataaccess.dart
```

Fungsi yang dibutuhkan:

| Fungsi               | Keterangan                        |
| -------------------- | --------------------------------- |
| `insertRecipe()`     | Menambah resep ke SQLite          |
| `getAllRecipes()`    | Mengambil semua resep dari SQLite |
| `getRecipeById()`    | Mengambil resep berdasarkan ID    |
| `updateRecipe()`     | Mengubah data resep               |
| `deleteRecipe()`     | Menghapus resep                   |
| `deleteAllRecipes()` | Opsional, untuk reset data        |

---

## 9. CRUD SQLite

## 9.1 Insert Recipe

Digunakan ketika:

1. Pengguna menyimpan resep dari API ke Saved Recipes.
2. Pengguna menambahkan resep pribadi melalui form.

Data masuk ke table:

```text
my_recipes
```

---

## 9.2 Read Recipes

Digunakan pada:

```text
Saved Recipes Screen
```

Aplikasi mengambil semua data dari SQLite dan menampilkannya menggunakan ListView.

---

## 9.3 Update Recipe

Digunakan pada:

```text
Edit Recipe Screen
```

Data yang diperbarui:

1. Nama resep.
2. Kategori.
3. Area.
4. Ingredients.
5. Instructions.
6. Catatan.
7. Path foto lokal.

---

## 9.4 Delete Recipe

Digunakan pada:

```text
Saved Recipes Screen
```

Sebelum delete, tampilkan dialog konfirmasi.

---

## 10. Relasi API dan SQLite

Data dari API dapat disimpan ke SQLite.

Alur:

```text
Home Screen
    ↓
Pilih resep
    ↓
Detail Screen
    ↓
Klik Save to Saved Recipes
    ↓
Data disimpan ke SQLite
    ↓
Saved Recipes Screen menampilkan data
```

Mapping data API ke SQLite:

| Data API                   | Kolom SQLite       |
| -------------------------- | ------------------ |
| `idMeal`                   | `api_id`           |
| `strMeal`                  | `name`             |
| `strCategory`              | `category`         |
| `strArea`                  | `area`             |
| `strMealThumb`             | `image_url`        |
| `strInstructions`          | `instructions`     |
| Ingredients + Measures     | `ingredients`      |
| Empty string               | `local_image_path` |
| Empty string / description | `note`             |

---

## 11. Data Resep Manual

Pengguna juga dapat menambahkan resep secara manual tanpa data dari API.

Untuk resep manual:

| Kolom              | Nilai                    |
| ------------------ | ------------------------ |
| `api_id`           | kosong                   |
| `name`             | Diisi user               |
| `category`         | Diisi user               |
| `area`             | Diisi user atau kosong   |
| `image_url`        | kosong                   |
| `local_image_path` | Path foto lokal jika ada |
| `instructions`     | Diisi user               |
| `ingredients`      | Diisi user               |
| `note`             | Diisi user               |
| `created_at`       | Tanggal saat data dibuat |

---

## 12. Controller yang Menggunakan API dan Database

## 12.1 RecipeController

File:

```text
lib/controller/recipe_controller.dart
```

Tanggung jawab:

1. Mengambil daftar resep dari API.
2. Search resep.
3. Mengambil detail resep.
4. Menyimpan state loading.
5. Menyimpan list resep.
6. Menyimpan selected recipe.
7. Menampilkan error menggunakan snackbar.

State yang dibutuhkan:

```text
recipes
selectedRecipe
isLoading
keyword
```

---

## 12.2 SavedRecipeController

File:

```text
lib/controller/saved_recipe_controller.dart
```

Tanggung jawab:

1. Mengambil data Saved Recipes dari SQLite.
2. Menambah resep ke SQLite.
3. Mengedit resep.
4. Menghapus resep.
5. Mengambil foto dari kamera.
6. Menyimpan state form sederhana.

State yang dibutuhkan:

```text
savedRecipes
isLoading
imagePath
```

---

## 13. Format Tanggal

Package:

```text
intl
```

Format tanggal yang digunakan:

```text
yyyy-MM-dd HH:mm:ss
```

Contoh:

```text
2026-07-11 14:30:00
```

Tanggal disimpan pada kolom:

```text
created_at
```

---

## 14. Penanganan Data Kosong

## 14.1 Data API Kosong

Jika API tidak mengembalikan gambar:

```text
Gunakan placeholder image
```

Jika nama resep kosong:

```text
Resep tanpa nama
```

Jika kategori kosong:

```text
Kategori tidak tersedia
```

Jika area kosong:

```text
Area tidak tersedia
```

Jika ingredients kosong:

```text
Ingredients tidak tersedia
```

Jika instructions kosong:

```text
Instructions tidak tersedia
```

---

## 14.2 Data SQLite Kosong

Jika Saved Recipes kosong:

```text
Belum ada resep tersimpan.
```

Atau versi UI:

```text
No recipes saved yet.
Save your favorite recipe or add your own recipe.
```

---

## 15. Error Handling

Error handling dibuat sederhana menggunakan try-catch.

## 15.1 Error API

Jika API gagal:

1. Set `isLoading` menjadi false.
2. Tampilkan snackbar.
3. Jangan crash aplikasi.

Pesan:

```text
Gagal mengambil data resep
```

---

## 15.2 Error SQLite

Jika SQLite gagal:

1. Tampilkan snackbar.
2. Jangan crash aplikasi.

Pesan:

```text
Terjadi kesalahan database
```

---

## 15.3 Error Camera

Jika kamera gagal:

1. Tampilkan snackbar.
2. Jangan simpan path kosong sebagai error.

Pesan:

```text
Gagal mengambil foto
```

---

## 16. Security API

Untuk project ini, security API dibuat sederhana.

Aturan:

1. Base URL disimpan di satu file constants.
2. Endpoint tidak ditulis langsung berulang di screen.
3. API request dilakukan dari controller.
4. Jangan print data sensitif ke console.
5. Jangan tampilkan konfigurasi API di UI.
6. Gunakan try-catch saat request API.

File yang disarankan:

```text
lib/utils/constants.dart
```

Isi minimal:

```dart
const String baseUrl = "https://www.themealdb.com/api/json/v1/1";
```

---

## 17. Contoh Struktur File Terkait API dan Database

```text
lib/
  model/
    recipe.dart
    my_recipe.dart

  controller/
    recipe_controller.dart
    saved_recipe_controller.dart

  provider/
    database_provider.dart

  dataaccess/
    my_recipe_dataaccess.dart

  utils/
    constants.dart
```

---

## 18. Urutan Implementasi

Urutan pengerjaan yang disarankan:

1. Buat `utils/constants.dart`.
2. Buat model `recipe.dart`.
3. Buat model `my_recipe.dart`.
4. Buat `recipe_controller.dart`.
5. Tampilkan data API di Home Screen.
6. Buat `database_provider.dart`.
7. Buat `my_recipe_dataaccess.dart`.
8. Buat `saved_recipe_controller.dart`.
9. Tampilkan data SQLite di Saved Recipes Screen.
10. Tambahkan fungsi insert.
11. Tambahkan fungsi update.
12. Tambahkan fungsi delete.
13. Tambahkan kamera.
14. Tambahkan error handling sederhana.

---

## 19. Catatan Penting untuk Coding

1. Jangan membuat folder `repository/`.
2. Jangan membuat folder `usecase/`.
3. Jangan membuat folder `services/`.
4. Jangan menggunakan Dio.
5. Jangan menggunakan Firebase.
6. Jangan menggunakan code generator.
7. Jangan menggunakan immutable model.
8. Gunakan `fromMap()` dan `toMap()` manual.
9. Gunakan `GetxController`.
10. Gunakan `Obx()` untuk update UI.
11. Gunakan `Get.snackbar()` untuk pesan berhasil atau gagal.
12. Gunakan `Get.dialog()` untuk konfirmasi.
13. Gunakan `path_provider` untuk lokasi database.
14. Simpan ingredients sebagai teks sederhana.

---

## 20. Kesimpulan

Rancangan API dan database pada RecipeBook App dibuat sederhana agar sesuai dengan materi perkuliahan. Public API digunakan untuk mengambil data resep, sedangkan SQLite digunakan untuk menyimpan Saved Recipes.

Dengan rancangan ini, aplikasi sudah dapat menerapkan REST API, SQLite, CRUD, form, ListView, kamera, dan security API secara sederhana tanpa menggunakan arsitektur yang terlalu kompleks.
