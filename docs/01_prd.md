# PRD - RecipeBook App

## 1. Ringkasan Project

**RecipeBook App** adalah aplikasi mobile berbasis Flutter yang membantu pengguna mencari resep makanan, melihat detail resep, menyimpan resep favorit, dan mengelola resep pribadi.

Aplikasi ini dibuat sebagai project mata kuliah pengembangan aplikasi mobile menggunakan Flutter. Project disusun agar sesuai dengan materi perkuliahan, mulai dari widget, layout, navigation, ListView, form, SQLite, REST API, CRUD, akses kamera, sampai security REST API sederhana.

Project ini menggunakan pendekatan sederhana dengan arsitektur **MVC sederhana** dan **GetX**.

---

## 2. Nama Aplikasi

**RecipeBook App**

Nama folder Flutter yang direkomendasikan:

```text
recipebook_app
```

---

## 3. Latar Belakang

Banyak orang ingin memasak tetapi sering kesulitan mencari inspirasi resep, mencatat resep favorit, atau menyimpan resep pribadi. Resep yang ditemukan di internet juga sering tercecer dan tidak tersimpan dalam satu tempat.

RecipeBook App dibuat untuk membantu pengguna mencari resep dari public API, melihat detail resep, menyimpan resep ke daftar favorit, dan menambahkan resep pribadi secara manual.

Aplikasi ini juga dapat membantu pengguna membuat catatan resep sederhana lengkap dengan foto makanan.

---

## 4. Masalah yang Diselesaikan

RecipeBook App dibuat untuk menyelesaikan beberapa masalah berikut:

1. Pengguna kesulitan mencari inspirasi resep makanan.
2. Pengguna ingin menyimpan resep favorit dalam satu aplikasi.
3. Pengguna ingin mencatat resep pribadi.
4. Pengguna ingin melihat bahan dan instruksi memasak secara rapi.
5. Pengguna ingin menyimpan foto masakan pribadi.
6. Pengguna membutuhkan aplikasi sederhana yang bisa digunakan secara offline untuk resep tersimpan.

---

## 5. Solusi yang Ditawarkan

Aplikasi menyediakan beberapa solusi:

1. Menampilkan daftar resep dari public API.
2. Menyediakan fitur search resep berdasarkan nama makanan.
3. Menampilkan detail resep.
4. Menyimpan resep ke SQLite.
5. Menampilkan daftar resep tersimpan.
6. Menyediakan fitur tambah resep pribadi.
7. Menyediakan fitur edit dan hapus resep.
8. Mengambil foto masakan menggunakan kamera.
9. Menyimpan status login sederhana menggunakan SharedPreferences.
10. Mengelola request API dengan try-catch sederhana.

---

## 6. Tujuan Project

Tujuan dari project ini adalah:

1. Membuat aplikasi mobile Flutter yang menerapkan materi perkuliahan.
2. Menggunakan GetX untuk navigation dan state management sederhana.
3. Menggunakan public API untuk menampilkan data resep.
4. Menggunakan SQLite untuk menyimpan resep secara lokal.
5. Membuat fitur CRUD sederhana untuk resep pribadi.
6. Menggunakan kamera untuk mengambil foto makanan.
7. Menggunakan form dengan validasi sederhana.
8. Menerapkan security REST API sederhana.
9. Membuat aplikasi yang mudah dipahami dan mudah dipresentasikan.

---

## 7. Target Pengguna

Target pengguna aplikasi ini adalah:

1. Mahasiswa yang sedang belajar Flutter.
2. Pengguna yang ingin mencari inspirasi resep makanan.
3. Pengguna yang ingin menyimpan resep favorit.
4. Pengguna yang ingin mencatat resep pribadi.
5. Pengguna pemula yang ingin belajar memasak.

---

## 8. Platform

Aplikasi dibuat untuk platform:

```text
Android
```

---

## 9. Teknologi yang Digunakan

| Kebutuhan        | Teknologi / Package  |
| ---------------- | -------------------- |
| Framework        | Flutter              |
| Bahasa           | Dart                 |
| State Management | GetX                 |
| Navigation       | GetX                 |
| REST API         | http                 |
| Local Database   | sqflite              |
| Database Path    | path_provider, path  |
| Camera / Image   | image_picker         |
| Local Storage    | shared_preferences   |
| Date Formatting  | intl                 |
| Network Image    | cached_network_image |
| Public API       | TheMealDB API        |

---

## 10. Public API

Public API yang digunakan:

```text
TheMealDB API
```

Base URL:

```text
https://www.themealdb.com/api/json/v1/1
```

Endpoint utama:

| Fitur              | Endpoint                 |
| ------------------ | ------------------------ |
| Search recipe      | `/search.php?s=keyword`  |
| Recipe detail      | `/lookup.php?i=id`       |
| Category list      | `/categories.php`        |
| Filter by category | `/filter.php?c=category` |

Data yang digunakan:

1. Recipe ID
2. Recipe name
3. Category
4. Area / origin
5. Recipe image
6. Instructions
7. Ingredients
8. YouTube link jika tersedia

---

## 11. Arsitektur Project

Project menggunakan arsitektur **MVC sederhana**.

Struktur folder utama:

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

Penjelasan folder:

| Folder        | Fungsi                                                     |
| ------------- | ---------------------------------------------------------- |
| `model/`      | Berisi class data seperti `Recipe` dan `MyRecipe`          |
| `controller/` | Berisi logic aplikasi menggunakan `GetxController`         |
| `screen/`     | Berisi tampilan halaman aplikasi                           |
| `dataaccess/` | Berisi fungsi CRUD SQLite                                  |
| `provider/`   | Berisi konfigurasi database SQLite                         |
| `utils/`      | Berisi constants warna, API URL, dan konfigurasi sederhana |
| `main.dart`   | Entry point aplikasi                                       |

---

## 12. Batasan Project

Agar project tetap sederhana dan sesuai materi kuliah, aplikasi ini tidak menggunakan:

1. BLoC
2. Riverpod
3. Provider sebagai state management
4. Clean Architecture
5. Repository pattern
6. Firebase
7. Machine learning
8. Push notification
9. Upload gambar ke server
10. Payment gateway
11. Multi-role user
12. Code generation
13. Unit test atau widget test
14. Dark mode
15. Complex animation

Semua logic dibuat dengan pendekatan sederhana menggunakan GetX, SQLite, dan REST API.

---

## 13. Fitur Utama

### 13.1 Splash Screen

Splash Screen digunakan untuk mengecek status login pengguna.

Alur:

```text
Aplikasi dibuka
  ↓
Splash Screen
  ↓
Cek status login dari SharedPreferences
  ↓
Jika sudah login → Home Screen
Jika belum login → Login Screen
```

---

### 13.2 Login Sederhana

Pengguna dapat masuk ke aplikasi menggunakan form login sederhana.

Login tidak menggunakan backend asli.

Data login default:

```text
Username: admin
Password: admin123
```

Fitur login digunakan untuk menerapkan:

1. Form
2. Validator
3. SharedPreferences
4. Navigation menggunakan GetX

---

### 13.3 Home / Recipe List

Home Screen menampilkan daftar resep dari public API.

Fitur:

1. Menampilkan list resep.
2. Menggunakan ListView.
3. Menampilkan gambar resep.
4. Menampilkan nama resep.
5. Menampilkan kategori dan area jika tersedia.
6. Menampilkan loading ketika data sedang diambil.
7. Menampilkan pesan error sederhana jika API gagal.
8. Search resep berdasarkan keyword.

---

### 13.4 Recipe Detail

Recipe Detail menampilkan informasi resep yang dipilih.

Data yang ditampilkan:

1. Gambar makanan.
2. Nama resep.
3. Kategori.
4. Area / origin.
5. Bahan-bahan.
6. Instruksi memasak.
7. Tombol simpan ke Saved Recipes.

---

### 13.5 Saved Recipes

Saved Recipes adalah halaman untuk menampilkan resep yang disimpan oleh pengguna.

Data Saved Recipes disimpan menggunakan SQLite.

Fitur:

1. Menampilkan daftar resep tersimpan.
2. Menambahkan resep dari API ke SQLite.
3. Menambahkan resep pribadi secara manual.
4. Mengedit resep pribadi atau resep tersimpan.
5. Menghapus resep dari SQLite.
6. Menampilkan foto lokal jika tersedia.

---

### 13.6 Add Personal Recipe

Pengguna dapat menambahkan resep pribadi melalui form.

Input form:

1. Recipe name
2. Category
3. Area / origin
4. Ingredients
5. Instructions
6. Note
7. Photo

---

### 13.7 Edit Recipe

Pengguna dapat mengedit resep yang sudah tersimpan di SQLite.

Data yang dapat diedit:

1. Recipe name
2. Category
3. Area / origin
4. Ingredients
5. Instructions
6. Note
7. Photo

---

### 13.8 Delete Recipe

Pengguna dapat menghapus resep dari Saved Recipes.

Sebelum data dihapus, aplikasi menampilkan dialog konfirmasi sederhana menggunakan `Get.dialog()`.

---

### 13.9 Camera

Aplikasi menyediakan fitur mengambil foto makanan menggunakan kamera.

Foto digunakan untuk resep pribadi atau resep tersimpan.

Package yang digunakan:

```text
image_picker
```

Data foto yang disimpan ke SQLite adalah path file lokal, bukan file gambar secara langsung.

---

### 13.10 Profile dan Logout

Profile Screen menampilkan informasi sederhana:

1. Username
2. Jumlah resep tersimpan
3. App version
4. Tombol logout

Logout menghapus status login dari SharedPreferences dan mengarahkan user kembali ke Login Screen.

---

### 13.11 Security REST API

Security REST API pada project ini dibuat sederhana dan sesuai kebutuhan pembelajaran.

Implementasi security:

1. Base URL disimpan di file constants.
2. Request API dilakukan dari controller.
3. Tidak menulis endpoint berulang di banyak screen.
4. Tidak menampilkan konfigurasi API di UI.
5. Error API ditangani menggunakan try-catch sederhana.
6. Status login disimpan menggunakan SharedPreferences.

Catatan:

TheMealDB API versi dasar tidak membutuhkan API key. Jika nanti menggunakan API yang membutuhkan key, key harus disimpan di satu file constants.

---

## 14. Kebutuhan Fungsional

| Kode   | Kebutuhan                                                          |
| ------ | ------------------------------------------------------------------ |
| FR-001 | Pengguna dapat login ke aplikasi                                   |
| FR-002 | Pengguna dapat logout dari aplikasi                                |
| FR-003 | Aplikasi dapat menampilkan daftar resep dari API                   |
| FR-004 | Pengguna dapat mencari resep                                       |
| FR-005 | Pengguna dapat melihat detail resep                                |
| FR-006 | Pengguna dapat menyimpan resep ke Saved Recipes                    |
| FR-007 | Aplikasi dapat menampilkan data Saved Recipes dari SQLite          |
| FR-008 | Pengguna dapat menambah resep pribadi                              |
| FR-009 | Pengguna dapat mengedit resep tersimpan                            |
| FR-010 | Pengguna dapat menghapus resep tersimpan                           |
| FR-011 | Pengguna dapat mengambil foto makanan menggunakan kamera           |
| FR-012 | Aplikasi dapat menyimpan path foto makanan ke SQLite               |
| FR-013 | Aplikasi dapat menyimpan status login secara lokal                 |
| FR-014 | Aplikasi dapat menangani loading, empty, dan error state sederhana |

---

## 15. Kebutuhan Non-Fungsional

| Kode    | Kebutuhan                                                          |
| ------- | ------------------------------------------------------------------ |
| NFR-001 | Aplikasi mudah digunakan                                           |
| NFR-002 | UI sederhana, clean, dan rapi                                      |
| NFR-003 | Project mudah dipahami oleh mahasiswa                              |
| NFR-004 | Tidak menggunakan arsitektur yang terlalu kompleks                 |
| NFR-005 | Data Saved Recipes tetap tersedia walaupun aplikasi ditutup        |
| NFR-006 | Aplikasi dapat berjalan di Android emulator atau perangkat Android |
| NFR-007 | Struktur folder mengikuti MVC sederhana                            |
| NFR-008 | Code menggunakan GetX sesuai materi kuliah                         |
| NFR-009 | Aplikasi hanya menggunakan light mode                              |
| NFR-010 | Aplikasi dapat tetap berjalan walaupun API gagal diakses           |

---

## 16. User Flow Utama

```text
Splash Screen
    ↓
Login Screen
    ↓
Home Screen
    ↓
Recipe Detail Screen
    ↓
Save to Saved Recipes
    ↓
Saved Recipes Screen
    ↓
Add / Edit / Delete Recipe
```

---

## 17. Daftar Screen

| Screen               | Fungsi                                  |
| -------------------- | --------------------------------------- |
| Splash Screen        | Mengecek status login                   |
| Login Screen         | Form login pengguna                     |
| Home Screen          | Menampilkan daftar resep dari API       |
| Detail Screen        | Menampilkan detail resep                |
| Saved Recipes Screen | Menampilkan resep yang disimpan         |
| Recipe Form Screen   | Menambah atau mengedit resep            |
| Profile Screen       | Menampilkan info user dan tombol logout |

---

## 18. Ruang Lingkup Project

### Termasuk dalam project:

1. Flutter UI.
2. Navigation menggunakan GetX.
3. ListView resep.
4. Form tambah dan edit resep.
5. REST API untuk mengambil data resep.
6. SQLite untuk menyimpan Saved Recipes.
7. CRUD SQLite.
8. Akses kamera.
9. Login sederhana.
10. Security REST API sederhana.
11. Empty state dan error state sederhana.

### Tidak termasuk dalam project:

1. Push notification.
2. Reminder masak.
3. Firebase.
4. Upload gambar ke server.
5. Multi-user dengan backend asli.
6. Role admin dan user.
7. Payment.
8. Maps.
9. Chatbot.
10. AI recipe recommendation.
11. Barcode scanner.
12. Meal planner kompleks.

---

## 19. Kriteria Keberhasilan

Project dianggap berhasil jika:

1. Aplikasi dapat dijalankan di Android.
2. Pengguna dapat login dan logout.
3. Aplikasi dapat mengambil data resep dari API.
4. Aplikasi dapat menampilkan list resep.
5. Aplikasi dapat mencari resep.
6. Aplikasi dapat menampilkan detail resep.
7. Pengguna dapat menyimpan resep ke SQLite.
8. Saved Recipes menampilkan data dari SQLite.
9. Pengguna dapat melakukan tambah, edit, dan hapus resep.
10. Pengguna dapat mengambil foto makanan.
11. Project menggunakan GetX.
12. Struktur folder tetap sederhana.
13. Aplikasi sesuai dengan materi perkuliahan.
14. Aplikasi dapat dijelaskan dengan mudah saat presentasi.

---

## 20. Risiko dan Solusi

| Risiko                          | Solusi                              |
| ------------------------------- | ----------------------------------- |
| API tidak mengembalikan data    | Tampilkan empty state               |
| API gagal diakses               | Tampilkan snackbar atau error state |
| Gambar dari API kosong          | Tampilkan placeholder image         |
| SQLite error                    | Gunakan try-catch sederhana         |
| Kamera tidak bisa dibuka        | Tampilkan snackbar error            |
| Login belum memakai backend     | Gunakan login lokal untuk MVP       |
| Project terlalu kompleks        | Tetap ikuti MVP dan AGENTS.md       |
| Instruksi resep terlalu panjang | Tampilkan dalam scroll view         |
| Form resep terlalu banyak field | Batasi hanya field penting          |

---

## 21. Kesimpulan

RecipeBook App adalah project Flutter yang sesuai untuk mata kuliah pengembangan aplikasi mobile. Project ini mencakup materi widget, layout, navigation, ListView, form, SQLite, REST API, CRUD, kamera, dan security REST API sederhana.

Aplikasi dibuat dengan pendekatan sederhana menggunakan GetX dan MVC sederhana agar mudah dipahami, mudah dikembangkan, dan sesuai dengan pembelajaran di kelas.
