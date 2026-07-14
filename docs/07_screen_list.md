# Screen List - RecipeBook App

## 1. Ringkasan

Dokumen ini berisi daftar screen yang dibutuhkan dalam project **RecipeBook App**.

Setiap screen dijelaskan berdasarkan:

1. Nama screen.
2. Fungsi screen.
3. Komponen UI.
4. Controller yang digunakan.
5. State yang dibutuhkan.
6. Aksi user.
7. Navigasi.

Dokumen ini dibuat agar implementasi UI dan logic aplikasi lebih mudah dipahami.

Project menggunakan:

- Flutter
- GetX
- REST API
- SQLite
- SharedPreferences
- Image Picker

Struktur project mengikuti MVC sederhana:

```text id="rixtfw"
lib/
  main.dart
  model/
  controller/
  screen/
  dataaccess/
  provider/
  utils/
```

---

## 2. Daftar Screen Utama

| No  | Screen               | File                        | Fungsi                          |
| --- | -------------------- | --------------------------- | ------------------------------- |
| 1   | Splash Screen        | `splash_screen.dart`        | Mengecek status login           |
| 2   | Login Screen         | `login_screen.dart`         | Form login sederhana            |
| 3   | Home Screen          | `home_screen.dart`          | Menampilkan list resep dari API |
| 4   | Recipe Detail Screen | `detail_screen.dart`        | Menampilkan detail resep        |
| 5   | Saved Recipes Screen | `saved_recipes_screen.dart` | Menampilkan resep dari SQLite   |
| 6   | Recipe Form Screen   | `recipe_form_screen.dart`   | Form tambah dan edit resep      |
| 7   | Profile Screen       | `profile_screen.dart`       | Profil sederhana dan logout     |
| 8   | State Components     | Komponen di screen terkait  | Empty state dan error state     |

---

## 3. Splash Screen

## 3.1 File

```text id="izctye"
lib/screen/splash_screen.dart
```

## 3.2 Fungsi

Splash Screen adalah halaman pertama yang muncul saat aplikasi dibuka. Screen ini digunakan untuk mengecek apakah pengguna sudah login atau belum.

## 3.3 Komponen UI

| Komponen                  | Keterangan                 |
| ------------------------- | -------------------------- |
| Scaffold                  | Struktur utama halaman     |
| Container                 | Background                 |
| Column                    | Menyusun logo dan teks     |
| Icon                      | Ikon makanan / recipe book |
| Text                      | Nama aplikasi dan tagline  |
| CircularProgressIndicator | Loading sederhana          |

## 3.4 Controller

| Controller       | Fungsi                |
| ---------------- | --------------------- |
| `AuthController` | Mengecek status login |

## 3.5 State

| State        | Keterangan                          |
| ------------ | ----------------------------------- |
| `isLoggedIn` | Status login dari SharedPreferences |

## 3.6 Aksi

Tidak ada aksi user langsung.

## 3.7 Navigasi

| Kondisi          | Navigasi     |
| ---------------- | ------------ |
| User sudah login | Home Screen  |
| User belum login | Login Screen |

## 3.8 Catatan Implementasi

1. Gunakan `Future.delayed()` singkat jika ingin splash terasa natural.
2. Gunakan `Get.offAll()` agar user tidak kembali ke splash.
3. Jangan membuat animasi kompleks.

---

## 4. Login Screen

## 4.1 File

```text id="zm90yn"
lib/screen/login_screen.dart
```

## 4.2 Fungsi

Login Screen digunakan agar pengguna dapat masuk ke aplikasi.

Login pada versi MVP bersifat sederhana dan tidak menggunakan backend.

## 4.3 Komponen UI

| Komponen              | Keterangan                     |
| --------------------- | ------------------------------ |
| Scaffold              | Struktur utama                 |
| SingleChildScrollView | Agar aman saat keyboard muncul |
| Form                  | Form login                     |
| TextFormField         | Input username dan password    |
| ElevatedButton        | Tombol login                   |
| Icon                  | Ikon recipe book / makanan     |
| Text                  | App name dan tagline           |

## 4.4 Controller

| Controller       | Fungsi                     |
| ---------------- | -------------------------- |
| `AuthController` | Login, simpan status login |

## 4.5 State

| State                | Keterangan                                |
| -------------------- | ----------------------------------------- |
| `usernameController` | Text editing controller username          |
| `passwordController` | Text editing controller password          |
| `isLoading`          | Loading saat proses login jika dibutuhkan |

## 4.6 Validasi

| Field    | Validasi    |
| -------- | ----------- |
| Username | Wajib diisi |
| Password | Wajib diisi |

## 4.7 Data Login Default

```text id="yeqrqh"
Username: admin
Password: admin123
```

## 4.8 Aksi User

| Aksi             | Hasil                     |
| ---------------- | ------------------------- |
| Mengisi username | Input username berubah    |
| Mengisi password | Input password berubah    |
| Klik Login       | Validasi dan proses login |

## 4.9 Navigasi

| Kondisi        | Navigasi              |
| -------------- | --------------------- |
| Login berhasil | Home Screen           |
| Login gagal    | Tetap di Login Screen |

## 4.10 Catatan Implementasi

1. Gunakan `GlobalKey<FormState>`.
2. Gunakan `TextFormField` dengan validator.
3. Gunakan `Get.snackbar()` untuk pesan error atau sukses.
4. Gunakan `Get.offAll()` setelah login berhasil.

---

## 5. Home Screen

## 5.1 File

```text id="h3upvk"
lib/screen/home_screen.dart
```

## 5.2 Fungsi

Home Screen adalah halaman utama aplikasi. Screen ini menampilkan daftar resep dari public API.

## 5.3 Komponen UI

| Komponen                  | Keterangan                              |
| ------------------------- | --------------------------------------- |
| Scaffold                  | Struktur utama                          |
| AppBar                    | Judul RecipeBook dan aksi Saved/Profile |
| TextField                 | Search resep                            |
| ListView                  | Menampilkan daftar resep                |
| Card                      | Item resep                              |
| CachedNetworkImage        | Gambar resep dari URL                   |
| CircularProgressIndicator | Loading state                           |
| IconButton                | Search, saved recipes, profile          |

## 5.4 Controller

| Controller              | Fungsi                              |
| ----------------------- | ----------------------------------- |
| `RecipeController`      | Mengambil data resep dari API       |
| `AuthController`        | Opsional jika ada logout cepat      |
| `SavedRecipeController` | Opsional untuk jumlah saved recipes |

## 5.5 State

| State            | Keterangan          |
| ---------------- | ------------------- |
| `recipes`        | List resep dari API |
| `isLoading`      | Loading data API    |
| `keyword`        | Keyword pencarian   |
| `selectedRecipe` | Resep yang dipilih  |

## 5.6 Aksi User

| Aksi               | Hasil                         |
| ------------------ | ----------------------------- |
| Membuka Home       | API search default dipanggil  |
| Klik recipe card   | Masuk ke Detail Screen        |
| Mengetik search    | Mengubah keyword              |
| Klik tombol search | Memanggil search API          |
| Klik Saved Recipes | Masuk ke Saved Recipes Screen |
| Klik Profile       | Masuk ke Profile Screen       |

## 5.7 Navigasi

| Aksi               | Navigasi             |
| ------------------ | -------------------- |
| Klik recipe card   | Detail Screen        |
| Klik Saved Recipes | Saved Recipes Screen |
| Klik Profile       | Profile Screen       |

## 5.8 Kondisi UI

| Kondisi       | Tampilan                  |
| ------------- | ------------------------- |
| Loading       | CircularProgressIndicator |
| Data tersedia | ListView Recipe Card      |
| Data kosong   | Empty State               |
| Error API     | Error State atau snackbar |

## 5.9 Catatan Implementasi

1. Gunakan `Obx()` untuk membaca `recipes` dan `isLoading`.
2. Search tidak harus real-time.
3. Gunakan `ListView.builder`.
4. Jika gambar kosong, tampilkan placeholder.
5. Jangan membuat filter kategori dulu jika belum dibutuhkan.

---

## 6. Recipe Detail Screen

## 6.1 File

```text id="q1nsoh"
lib/screen/detail_screen.dart
```

## 6.2 Fungsi

Recipe Detail Screen digunakan untuk menampilkan informasi detail resep yang dipilih dari Home Screen.

## 6.3 Komponen UI

| Komponen                   | Keterangan                               |
| -------------------------- | ---------------------------------------- |
| Scaffold                   | Struktur utama                           |
| AppBar                     | Tombol back dan judul detail             |
| Image / CachedNetworkImage | Gambar resep                             |
| Text                       | Nama resep, kategori, area, instructions |
| Card / Container           | Info category dan area                   |
| Text                       | Ingredients                              |
| ElevatedButton             | Save to Saved Recipes                    |
| Icon                       | Ikon kategori / area / bahan             |
| CircularProgressIndicator  | Loading detail                           |

## 6.4 Controller

| Controller              | Fungsi                    |
| ----------------------- | ------------------------- |
| `RecipeController`      | Mengambil detail resep    |
| `SavedRecipeController` | Menyimpan resep ke SQLite |

## 6.5 State

| State            | Keterangan                           |
| ---------------- | ------------------------------------ |
| `selectedRecipe` | Data detail resep                    |
| `isLoading`      | Loading detail                       |
| `savedRecipes`   | Data resep tersimpan jika diperlukan |

## 6.6 Aksi User

| Aksi                       | Hasil                  |
| -------------------------- | ---------------------- |
| Membuka detail             | Load detail resep      |
| Klik Save to Saved Recipes | Simpan resep ke SQLite |
| Klik Back                  | Kembali ke Home        |

## 6.7 Navigasi

| Aksi          | Navigasi                                  |
| ------------- | ----------------------------------------- |
| Back          | Home Screen                               |
| Save berhasil | Tetap di Detail atau menuju Saved Recipes |

## 6.8 Kondisi UI

| Kondisi         | Tampilan                  |
| --------------- | ------------------------- |
| Loading         | CircularProgressIndicator |
| Detail tersedia | Detail resep tampil       |
| Gambar kosong   | Placeholder image         |
| Error           | Snackbar error            |

## 6.9 Catatan Implementasi

1. Data dapat dikirim dari Home ke Detail menggunakan argument GetX.
2. Jika API detail digunakan, panggil detail berdasarkan ID.
3. Tombol Save memanggil `SavedRecipeController`.
4. Gunakan `Get.snackbar()` setelah berhasil menyimpan.
5. Karena instructions bisa panjang, gunakan `SingleChildScrollView`.

---

## 7. Saved Recipes Screen

## 7.1 File

```text id="3q4090"
lib/screen/saved_recipes_screen.dart
```

## 7.2 Fungsi

Saved Recipes Screen digunakan untuk menampilkan data resep yang disimpan pengguna di SQLite.

## 7.3 Komponen UI

| Komponen             | Keterangan             |
| -------------------- | ---------------------- |
| Scaffold             | Struktur utama         |
| AppBar               | Judul Saved Recipes    |
| ListView             | List resep dari SQLite |
| Card                 | Item resep             |
| Image.file           | Foto lokal             |
| CachedNetworkImage   | Gambar dari URL API    |
| FloatingActionButton | Tambah resep           |
| IconButton           | Edit dan delete        |

## 7.4 Controller

| Controller              | Fungsi                        |
| ----------------------- | ----------------------------- |
| `SavedRecipeController` | CRUD SQLite                   |
| `AuthController`        | Opsional untuk logout/profile |

## 7.5 State

| State          | Keterangan                     |
| -------------- | ------------------------------ |
| `savedRecipes` | List resep dari SQLite         |
| `isLoading`    | Loading data SQLite            |
| `imagePath`    | Path foto lokal jika digunakan |

## 7.6 Aksi User

| Aksi                  | Hasil                          |
| --------------------- | ------------------------------ |
| Membuka Saved Recipes | Data SQLite dimuat             |
| Klik Add              | Masuk ke Recipe Form mode add  |
| Klik Edit             | Masuk ke Recipe Form mode edit |
| Klik Delete           | Dialog konfirmasi hapus        |
| Klik Home             | Kembali ke Home                |
| Klik Profile          | Masuk ke Profile               |

## 7.7 Navigasi

| Aksi        | Navigasi                     |
| ----------- | ---------------------------- |
| Add Recipe  | Recipe Form Screen mode add  |
| Edit Recipe | Recipe Form Screen mode edit |
| Home        | Home Screen                  |
| Profile     | Profile Screen               |

## 7.8 Kondisi UI

| Kondisi         | Tampilan                  |
| --------------- | ------------------------- |
| Loading         | CircularProgressIndicator |
| Data tersedia   | ListView Saved Recipes    |
| Data kosong     | Empty State               |
| Delete berhasil | Snackbar dan refresh list |

## 7.9 Catatan Implementasi

1. Gunakan `Obx()` untuk list `savedRecipes`.
2. Panggil `getAllRecipes()` atau `loadRecipes()` saat screen dibuka.
3. Untuk gambar, prioritaskan `localImagePath`, lalu `imageUrl`.
4. Delete harus menggunakan dialog konfirmasi.

---

## 8. Recipe Form Screen

## 8.1 File

```text id="clu5xt"
lib/screen/recipe_form_screen.dart
```

## 8.2 Fungsi

Recipe Form Screen digunakan untuk dua mode:

1. Add Recipe
2. Edit Recipe

Agar project sederhana, add dan edit menggunakan satu file screen yang sama.

## 8.3 Mode Screen

| Mode | Keterangan                   |
| ---- | ---------------------------- |
| Add  | Form kosong untuk resep baru |
| Edit | Form terisi data lama        |

## 8.4 Komponen UI

| Komponen              | Keterangan                          |
| --------------------- | ----------------------------------- |
| Scaffold              | Struktur utama                      |
| AppBar                | Judul Add Recipe atau Edit Recipe   |
| SingleChildScrollView | Agar form aman saat keyboard muncul |
| Form                  | Form input                          |
| TextFormField         | Input data resep                    |
| Image.file            | Preview foto lokal                  |
| CachedNetworkImage    | Preview gambar dari API jika ada    |
| Container             | Placeholder foto                    |
| IconButton            | Tombol kamera                       |
| ElevatedButton        | Save atau Update                    |
| OutlinedButton        | Delete opsional pada mode edit      |

## 8.5 Controller

| Controller              | Fungsi                 |
| ----------------------- | ---------------------- |
| `SavedRecipeController` | Insert, update, kamera |

## 8.6 State

| State                    | Keterangan                 |
| ------------------------ | -------------------------- |
| `nameController`         | Input nama resep           |
| `categoryController`     | Input kategori             |
| `areaController`         | Input area/origin          |
| `ingredientsController`  | Input ingredients          |
| `instructionsController` | Input instructions         |
| `noteController`         | Input catatan              |
| `imagePath`              | Path foto                  |
| `isLoading`              | Loading saat simpan/update |

## 8.7 Form Field

| Field         | Wajib | Keterangan        |
| ------------- | ----- | ----------------- |
| Recipe Name   | Ya    | Nama resep        |
| Category      | Ya    | Kategori          |
| Area / Origin | Tidak | Asal/area makanan |
| Ingredients   | Ya    | Bahan-bahan       |
| Instructions  | Ya    | Langkah memasak   |
| Note          | Tidak | Catatan           |
| Photo         | Tidak | Foto makanan      |

## 8.8 Aksi User

| Aksi               | Hasil                                    |
| ------------------ | ---------------------------------------- |
| Isi form           | Data masuk ke controller/text controller |
| Klik kamera        | Buka kamera dengan image_picker          |
| Klik Save Recipe   | Insert data ke SQLite                    |
| Klik Update Recipe | Update data SQLite                       |
| Klik Back          | Kembali ke Saved Recipes                 |

## 8.9 Navigasi

| Kondisi         | Navigasi             |
| --------------- | -------------------- |
| Save berhasil   | Saved Recipes Screen |
| Update berhasil | Saved Recipes Screen |
| Back            | Saved Recipes Screen |

## 8.10 Catatan Implementasi

1. Gunakan `GlobalKey<FormState>`.
2. Gunakan validator pada field wajib.
3. Gunakan satu screen untuk add dan edit.
4. Judul AppBar berubah sesuai mode.
5. Tombol utama berubah sesuai mode.
6. Gunakan multiline TextFormField untuk ingredients dan instructions.
7. Jangan membuat form terlalu kompleks.

---

## 9. Profile Screen

## 9.1 File

```text id="g6sdzl"
lib/screen/profile_screen.dart
```

## 9.2 Fungsi

Profile Screen digunakan untuk menampilkan informasi user sederhana dan tombol logout.

## 9.3 Komponen UI

| Komponen                        | Keterangan                              |
| ------------------------------- | --------------------------------------- |
| Scaffold                        | Struktur utama                          |
| AppBar                          | Judul Profile                           |
| Icon / CircleAvatar             | Avatar user                             |
| Text                            | Username dan subtitle                   |
| Card                            | Informasi saved recipes dan app version |
| ElevatedButton / OutlinedButton | Logout                                  |

## 9.4 Controller

| Controller              | Fungsi                           |
| ----------------------- | -------------------------------- |
| `AuthController`        | Logout                           |
| `SavedRecipeController` | Mengambil jumlah resep tersimpan |

## 9.5 State

| State          | Keterangan                            |
| -------------- | ------------------------------------- |
| `isLoggedIn`   | Status login                          |
| `savedRecipes` | Untuk menghitung jumlah saved recipes |

## 9.6 Aksi User

| Aksi               | Hasil                    |
| ------------------ | ------------------------ |
| Klik Logout        | Dialog konfirmasi logout |
| Klik Home          | Home Screen              |
| Klik Saved Recipes | Saved Recipes Screen     |

## 9.7 Navigasi

| Aksi            | Navigasi             |
| --------------- | -------------------- |
| Home            | Home Screen          |
| Saved Recipes   | Saved Recipes Screen |
| Logout berhasil | Login Screen         |

## 9.8 Catatan Implementasi

1. Profile tidak perlu fitur edit.
2. Username dapat dibuat statis: `admin`.
3. App version dapat dibuat statis: `1.0.0`.
4. Logout menggunakan `Get.offAll()` ke Login Screen.

---

## 10. Empty State Component

## 10.1 Fungsi

Empty State digunakan ketika data kosong.

## 10.2 Lokasi Penggunaan

| Screen               | Kondisi                     |
| -------------------- | --------------------------- |
| Home Screen          | Search tidak menemukan data |
| Saved Recipes Screen | Belum ada resep tersimpan   |

## 10.3 Komponen UI

| Komponen       | Keterangan                |
| -------------- | ------------------------- |
| Icon           | Recipe book / empty plate |
| Text           | Judul empty state         |
| Text           | Pesan penjelasan          |
| ElevatedButton | Aksi seperti Add Recipe   |

## 10.4 Contoh Teks

```text id="hm2qcp"
No recipes saved yet
Save your favorite recipe or add your own recipe.
```

Untuk search kosong:

```text id="j1vkrs"
No recipes found
Try searching with another keyword.
```

---

## 11. Error State Component

## 11.1 Fungsi

Error State digunakan ketika data gagal dimuat.

## 11.2 Lokasi Penggunaan

| Screen               | Kondisi             |
| -------------------- | ------------------- |
| Home Screen          | API gagal           |
| Detail Screen        | Detail gagal dimuat |
| Saved Recipes Screen | SQLite error        |

## 11.3 Komponen UI

| Komponen       | Keterangan         |
| -------------- | ------------------ |
| Icon           | Warning / wifi off |
| Text           | Judul error        |
| Text           | Pesan error        |
| ElevatedButton | Try Again          |

## 11.4 Contoh Teks

```text id="q9tngx"
Something went wrong
Failed to load recipe data. Please check your connection and try again.
```

---

## 12. Main Navigation

## 12.1 Menu

| Menu          | Screen               |
| ------------- | -------------------- |
| Home          | Home Screen          |
| Saved Recipes | Saved Recipes Screen |
| Profile       | Profile Screen       |

## 12.2 Catatan

Navigasi utama boleh menggunakan AppBar actions agar tetap sederhana.

Rekomendasi:

1. Home Screen memiliki icon menuju Saved Recipes dan Profile.
2. Saved Recipes Screen memiliki icon menuju Home dan Profile.
3. Profile Screen memiliki icon menuju Home dan Saved Recipes.

Jika ingin menggunakan BottomNavigationBar juga boleh, tetapi jangan dibuat terlalu kompleks.

---

## 13. UI Reference Images

Referensi desain UI berada di folder:

```text id="6dpxqq"
docs/ui-reference/
```

Daftar file:

```text id="yyf52v"
01_login_home_recipe_detail.png
02_saved_recipes_form_crud.png
03_splash_profile_empty_error_states.png
```

Isi file:

| File                                       | Isi                                       |
| ------------------------------------------ | ----------------------------------------- |
| `01_login_home_recipe_detail.png`          | Login, Home, Recipe Detail                |
| `02_saved_recipes_form_crud.png`           | Saved Recipes, Add Recipe, Edit Recipe    |
| `03_splash_profile_empty_error_states.png` | Splash, Profile, Empty State, Error State |

---

## 14. Ringkasan Controller per Screen

| Screen               | Controller                                  |
| -------------------- | ------------------------------------------- |
| Splash Screen        | `AuthController`                            |
| Login Screen         | `AuthController`                            |
| Home Screen          | `RecipeController`, `AuthController`        |
| Recipe Detail Screen | `RecipeController`, `SavedRecipeController` |
| Saved Recipes Screen | `SavedRecipeController`                     |
| Recipe Form Screen   | `SavedRecipeController`                     |
| Profile Screen       | `AuthController`, `SavedRecipeController`   |

---

## 15. Ringkasan Navigation

```text id="2fq9z6"
Splash Screen
  ├── Login Screen
  └── Home Screen

Login Screen
  └── Home Screen

Home Screen
  ├── Recipe Detail Screen
  ├── Saved Recipes Screen
  └── Profile Screen

Recipe Detail Screen
  └── Saved Recipes Screen atau Home Screen

Saved Recipes Screen
  ├── Recipe Form Screen mode add
  ├── Recipe Form Screen mode edit
  ├── Home Screen
  └── Profile Screen

Profile Screen
  ├── Home Screen
  ├── Saved Recipes Screen
  └── Login Screen setelah logout
```

---

## 16. Kesimpulan

Screen List ini menjadi panduan implementasi tampilan RecipeBook App. Setiap screen dibuat sederhana, sesuai dengan materi perkuliahan, dan dapat diimplementasikan menggunakan Flutter widget standar serta GetX.

Dengan dokumen ini, proses generate kode atau pengembangan manual akan lebih terarah karena setiap screen sudah memiliki fungsi, controller, state, dan alur navigasi yang jelas.
