# Project Plan - RecipeBook App

## 1. Ringkasan

Dokumen ini berisi rencana pengerjaan project **RecipeBook App** berdasarkan silabus mata kuliah pengembangan aplikasi mobile Flutter.

Project ini dibuat secara bertahap mengikuti materi perkuliahan, mulai dari pengenalan Android, Flutter widget, layout, navigation, ListView, form, SQLite, REST API, CRUD, kamera, sampai security REST API.

Rencana ini dibuat agar proses pengerjaan project lebih terarah dan tidak melebar ke fitur yang terlalu kompleks.

---

## 2. Informasi Project

| Item                | Keterangan                  |
| ------------------- | --------------------------- |
| Nama Project        | RecipeBook App              |
| Nama Folder Flutter | `recipebook_app`            |
| Platform            | Android                     |
| Framework           | Flutter                     |
| Bahasa              | Dart                        |
| State Management    | GetX                        |
| Database Lokal      | SQLite                      |
| Public API          | TheMealDB API               |
| Arsitektur          | MVC sederhana               |
| Target Project      | Project mata kuliah Flutter |
| Mode Tampilan       | Light mode only             |

---

## 3. Tujuan Project

Tujuan project ini adalah membuat aplikasi mobile sederhana yang dapat:

1. Menampilkan data resep dari public API.
2. Mencari resep berdasarkan keyword.
3. Menampilkan detail resep.
4. Menyimpan resep ke SQLite.
5. Mengelola resep pribadi dengan CRUD.
6. Mengambil foto makanan menggunakan kamera.
7. Menggunakan GetX untuk navigasi dan state management.
8. Menggunakan form dengan validasi.
9. Menerapkan security REST API sederhana.
10. Menyediakan profile sederhana dan logout.

---

## 4. Scope Project

## 4.1 Scope Utama

Fitur yang akan dibuat:

1. Splash Screen.
2. Login sederhana.
3. Home Screen daftar resep.
4. Search resep.
5. Detail resep.
6. Saved Recipes.
7. Tambah resep pribadi.
8. Edit resep.
9. Hapus resep.
10. Kamera untuk foto makanan.
11. Profile sederhana.
12. Logout.
13. Empty state sederhana.
14. Error handling sederhana.

---

## 4.2 Di Luar Scope

Fitur berikut tidak dikerjakan pada tahap utama:

1. Register user.
2. Login backend asli.
3. Firebase.
4. Push notification.
5. AI recipe recommendation.
6. Meal planner.
7. Upload foto ke server.
8. Maps.
9. Payment.
10. Role admin dan user.
11. Clean Architecture.
12. Repository pattern.
13. Unit testing.
14. Dark mode.
15. Multi-language.
16. Barcode scanner.

---

## 5. Struktur Folder Project

Struktur folder yang digunakan:

```text id="3wwhir"
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

Catatan:

1. Tidak menggunakan folder `repository/`.
2. Tidak menggunakan folder `usecase/`.
3. Tidak menggunakan folder `services/`.
4. Tidak menggunakan arsitektur Clean Architecture.
5. Logic utama berada di controller.
6. CRUD SQLite berada di dataaccess.
7. Koneksi database berada di provider.

---

## 6. Package yang Digunakan

Package yang digunakan:

```bash id="zsq4jw"
flutter pub add get http sqflite path path_provider image_picker shared_preferences intl cached_network_image
```

Kegunaan package:

| Package                | Fungsi                                 |
| ---------------------- | -------------------------------------- |
| `get`                  | Navigation dan state management        |
| `http`                 | Mengambil data dari REST API           |
| `sqflite`              | Database SQLite                        |
| `path`                 | Menggabungkan path database            |
| `path_provider`        | Menentukan lokasi file database SQLite |
| `image_picker`         | Mengambil foto makanan                 |
| `shared_preferences`   | Menyimpan status login                 |
| `intl`                 | Format tanggal                         |
| `cached_network_image` | Menampilkan gambar dari URL            |

---

## 7. Rencana Berdasarkan Sesi Perkuliahan

## Sesi 1 - Pengenalan Android dan Kontrak Perkuliahan

### Materi

Pengenalan Android, kontrak perkuliahan, dan gambaran project mobile.

### Implementasi Project

1. Menentukan ide project RecipeBook App.
2. Menentukan masalah yang ingin diselesaikan.
3. Menentukan fitur utama aplikasi.
4. Membuat dokumen awal:
   - PRD
   - MVP
   - Features
   - API & Database
   - Project Plan

### Output

1. Ide project sudah jelas.
2. Scope project sudah ditentukan.
3. Dokumen project tersedia.

---

## Sesi 2 - Pengenalan Flutter dan Widget

### Materi

Pengenalan Flutter, struktur project Flutter, dan widget dasar.

### Implementasi Project

1. Inisialisasi project Flutter dengan nama:

```text id="f4umjj"
recipebook_app
```

2. Menambahkan package yang dibutuhkan.
3. Membuat struktur folder.
4. Membuat file `main.dart`.
5. Membuat screen awal sederhana.
6. Membuat widget dasar seperti:
   - Text
   - Image
   - Icon
   - ElevatedButton
   - TextField
   - Card

### Output

1. Project Flutter dapat dijalankan.
2. Struktur folder awal sudah tersedia.
3. Tampilan awal sederhana tersedia.

---

## Sesi 3 - Layout Widget

### Materi

Layout dasar Flutter menggunakan widget seperti Column, Row, Container, Padding, dan Card.

### Implementasi Project

1. Membuat UI Login Screen.
2. Membuat UI Home Screen awal.
3. Membuat Recipe Card sederhana.
4. Mengatur layout dengan:
   - Column
   - Row
   - Container
   - Padding
   - Card
   - SizedBox

### Output

1. Login Screen memiliki layout rapi.
2. Home Screen memiliki layout awal.
3. Recipe Card dapat ditampilkan secara statis.

---

## Sesi 4 - Layout Desain Lanjutan

### Materi

Layout lebih lanjut dan perapian tampilan aplikasi.

### Implementasi Project

1. Membuat Detail Screen.
2. Membuat Saved Recipes Screen.
3. Membuat Recipe Form Screen.
4. Menambahkan tampilan:
   - Empty state
   - Error state
   - Loading state
   - Image placeholder
   - Form layout

### Output

1. Detail Screen tersedia.
2. Saved Recipes Screen tersedia.
3. Form tambah/edit resep tersedia secara tampilan.

---

## Sesi 5 - Flutter Navigation

### Materi

Navigasi antar halaman di Flutter.

### Implementasi Project

1. Menggunakan GetX untuk navigasi.
2. Mengubah `MaterialApp` menjadi `GetMaterialApp`.
3. Implementasi navigasi:
   - Splash ke Login
   - Splash ke Home
   - Login ke Home
   - Home ke Detail
   - Home ke Saved Recipes
   - Home ke Profile
   - Saved Recipes ke Form
   - Profile ke Login setelah logout

### Output

1. Navigasi antar halaman berjalan.
2. Aplikasi sudah memiliki alur halaman utama.

---

## Sesi 6 - ListView Flutter

### Materi

Menampilkan data menggunakan ListView.

### Implementasi Project

1. Membuat ListView resep di Home Screen.
2. Membuat ListView Saved Recipes.
3. Membuat Recipe Card sederhana.
4. Menampilkan data dummy terlebih dahulu jika API belum siap.

### Output

1. Home Screen dapat menampilkan daftar resep.
2. Saved Recipes Screen dapat menampilkan daftar resep tersimpan.
3. Recipe Card digunakan untuk list data.

---

## Sesi 7 - Flutter Form

### Materi

Form input, TextFormField, validator, dan GlobalKey FormState.

### Implementasi Project

1. Membuat form login.
2. Membuat form tambah resep.
3. Membuat form edit resep.
4. Menambahkan validasi:
   - Username wajib diisi.
   - Password wajib diisi.
   - Recipe name wajib diisi.
   - Category wajib diisi.
   - Ingredients wajib diisi.
   - Instructions wajib diisi.

### Output

1. Login form memiliki validasi.
2. Form tambah resep memiliki validasi.
3. Form edit resep memiliki validasi.

---

## Sesi 8 - UTS

### Target UTS

Pada UTS, aplikasi minimal sudah memiliki:

1. Struktur project.
2. Login Screen.
3. Home Screen.
4. Detail Screen.
5. Saved Recipes Screen.
6. Navigation.
7. ListView.
8. Form tambah/edit.
9. UI berjalan dengan data dummy atau data awal.

### Output

Aplikasi dapat didemonstrasikan secara UI dan alur navigation.

---

## Sesi 9 - Flutter SQLite

### Materi

Pengenalan SQLite di Flutter.

### Implementasi Project

1. Membuat `database_provider.dart`.
2. Membuat database `recipebook.db`.
3. Membuat table `my_recipes`.
4. Membuka koneksi database menggunakan `path_provider`.
5. Menyiapkan struktur model `MyRecipe`.

### Output

1. Database SQLite berhasil dibuat.
2. Table `my_recipes` tersedia.
3. Project siap melakukan CRUD lokal.

---

## Sesi 10 - Flutter SQLite CRUD

### Materi

Insert, read, update, dan delete data menggunakan SQLite.

### Implementasi Project

1. Membuat `my_recipe_dataaccess.dart`.
2. Implementasi fungsi:
   - Insert recipe
   - Get all recipes
   - Get recipe by id
   - Update recipe
   - Delete recipe

3. Menghubungkan CRUD SQLite ke `SavedRecipeController`.
4. Menampilkan data SQLite di Saved Recipes Screen.

### Output

1. Data resep dapat disimpan.
2. Data resep dapat ditampilkan.
3. Data resep dapat diedit.
4. Data resep dapat dihapus.

---

## Sesi 11 - Flutter REST API

### Materi

Mengambil data dari REST API.

### Implementasi Project

1. Membuat konfigurasi API di `constants.dart`.
2. Membuat model `Recipe`.
3. Membuat fungsi API di `recipe_controller.dart`.
4. Mengambil data resep dari API.
5. Menampilkan data API di Home Screen.
6. Membuat loading state sederhana.
7. Membuat error handling sederhana.

### Output

1. Aplikasi dapat mengambil data resep dari API.
2. Home Screen menampilkan data dari API.
3. Search resep mulai bisa digunakan.

---

## Sesi 12 - Flutter CRUD

### Materi

CRUD aplikasi secara lengkap.

### Implementasi Project

1. Menghubungkan data API ke SQLite.
2. Menambahkan fitur simpan resep dari Detail Screen ke Saved Recipes.
3. Menyempurnakan tambah resep manual.
4. Menyempurnakan edit resep.
5. Menyempurnakan hapus resep.
6. Menambahkan snackbar sukses dan gagal.

### Output

1. Data API dapat disimpan ke SQLite.
2. CRUD resep pribadi berjalan lengkap.
3. Saved Recipes berjalan sebagai fitur utama lokal.

---

## Sesi 13 - Akses Camera

### Materi

Mengakses kamera dari aplikasi Flutter.

### Implementasi Project

1. Menambahkan fitur ambil foto di Recipe Form Screen.
2. Menggunakan package `image_picker`.
3. Menampilkan preview foto.
4. Menyimpan path foto ke SQLite.
5. Menampilkan foto lokal di Saved Recipes.

### Output

1. Pengguna dapat mengambil foto makanan.
2. Foto tampil di form.
3. Foto tersimpan sebagai path lokal.
4. Foto dapat ditampilkan kembali di Saved Recipes.

---

## Sesi 14 - Security REST API

### Materi

Keamanan saat menggunakan REST API.

### Implementasi Project

1. Menyimpan base URL di `constants.dart`.
2. Tidak menulis endpoint berulang di screen.
3. Tidak menampilkan konfigurasi API di UI.
4. Membuat try-catch pada request API.
5. Menyimpan status login dengan SharedPreferences.
6. Menambahkan logout.
7. Menjelaskan batasan security pada project kuliah.

### Output

1. Konfigurasi API dikelola di satu tempat.
2. Request API lebih rapi.
3. Login/logout sederhana berjalan.
4. Aplikasi memiliki penjelasan security REST API sederhana.

---

## 8. Timeline Pengerjaan

| Tahap    | Fokus                   | Output                             |
| -------- | ----------------------- | ---------------------------------- |
| Tahap 1  | Dokumentasi dan setup   | PRD, MVP, struktur project         |
| Tahap 2  | UI dasar                | Login, Home, Detail, Saved Recipes |
| Tahap 3  | Navigation dan ListView | GetX navigation, list resep        |
| Tahap 4  | Form                    | Login form, Recipe form            |
| Tahap 5  | SQLite                  | Database dan CRUD                  |
| Tahap 6  | REST API                | Data resep dari API                |
| Tahap 7  | Integrasi               | API ke SQLite, Saved Recipes       |
| Tahap 8  | Kamera                  | Foto makanan                       |
| Tahap 9  | Profile dan logout      | Profile, saved count, logout       |
| Tahap 10 | Security dan finalisasi | API config, error handling         |
| Tahap 11 | Presentasi              | Demo dan laporan akhir             |

---

## 9. Prioritas Pengerjaan

## 9.1 Prioritas Wajib

Fitur yang harus selesai:

1. Login.
2. Home list resep.
3. Search resep.
4. Detail resep.
5. Saved Recipes.
6. SQLite CRUD.
7. Form tambah/edit.
8. Kamera.
9. Profile.
10. Logout.

---

## 9.2 Prioritas Tambahan

Fitur yang dikerjakan jika waktu cukup:

1. Pull to refresh.
2. Filter kategori.
3. Empty state lebih rapi.
4. Placeholder image.
5. Error state lebih rapi.

---

## 9.3 Tidak Dikerjakan

Fitur yang tidak dikerjakan:

1. Firebase.
2. Push notification.
3. AI recommendation.
4. Upload image.
5. Multi-role user.
6. Payment.
7. Maps.
8. Clean Architecture.
9. Register user.
10. Barcode scanner.

---

## 10. Target UTS

Target saat UTS:

1. Project Flutter sudah berjalan.
2. Struktur folder sudah sesuai.
3. Login Screen sudah ada.
4. Home Screen sudah ada.
5. Detail Screen sudah ada.
6. Saved Recipes Screen sudah ada.
7. Navigation menggunakan GetX sudah berjalan.
8. ListView sudah ada.
9. Form tambah/edit sudah ada.
10. Data boleh masih dummy atau sebagian statis.

---

## 11. Target Final Project

Target final project:

1. Login dan logout berjalan.
2. Home menampilkan data resep dari API.
3. Search resep berjalan.
4. Detail resep berjalan.
5. Simpan resep ke Saved Recipes berjalan.
6. Saved Recipes mengambil data dari SQLite.
7. Tambah resep pribadi berjalan.
8. Edit resep berjalan.
9. Hapus resep berjalan.
10. Kamera berjalan.
11. Data foto tersimpan sebagai path lokal.
12. Base URL dikelola di satu file.
13. Error handling sederhana tersedia.
14. Project dapat dipresentasikan dengan baik.

---

## 12. Testing Manual

Testing dilakukan secara manual.

Checklist testing:

| No  | Test Case                             | Status |
| --- | ------------------------------------- | ------ |
| 1   | Aplikasi dapat dibuka                 | Belum  |
| 2   | Splash Screen tampil                  | Belum  |
| 3   | Login dengan data benar berhasil      | Belum  |
| 4   | Login dengan data salah gagal         | Belum  |
| 5   | Home menampilkan data resep           | Belum  |
| 6   | Search resep berjalan                 | Belum  |
| 7   | Detail resep tampil                   | Belum  |
| 8   | Resep dapat disimpan ke Saved Recipes | Belum  |
| 9   | Saved Recipes menampilkan data SQLite | Belum  |
| 10  | Tambah resep pribadi berhasil         | Belum  |
| 11  | Edit resep berhasil                   | Belum  |
| 12  | Hapus resep berhasil                  | Belum  |
| 13  | Kamera dapat mengambil foto           | Belum  |
| 14  | Foto tampil di form                   | Belum  |
| 15  | Profile tampil                        | Belum  |
| 16  | Logout berhasil                       | Belum  |
| 17  | Aplikasi tidak crash saat API error   | Belum  |

---

## 13. Risiko Project

| Risiko                          | Dampak                  | Solusi                             |
| ------------------------------- | ----------------------- | ---------------------------------- |
| API tidak mengembalikan data    | Data tidak tampil       | Tampilkan empty state              |
| Internet mati                   | Data API tidak tampil   | Tampilkan snackbar error           |
| Response API null               | App berpotensi error    | Cek null sebelum parsing           |
| Gambar dari API kosong          | UI kurang rapi          | Gunakan placeholder image          |
| Kamera tidak muncul             | Foto tidak bisa diambil | Cek permission dan device/emulator |
| SQLite error                    | Data tidak tersimpan    | Cek query dan struktur table       |
| Project terlalu kompleks        | Sulit selesai           | Tetap ikuti MVP                    |
| Form terlalu panjang            | User sulit input        | Gunakan field penting saja         |
| Instruksi resep terlalu panjang | UI overflow             | Gunakan scroll view                |

---

## 14. Strategi Presentasi

Saat presentasi, alur demo yang disarankan:

1. Jelaskan tujuan aplikasi.
2. Tunjukkan Splash Screen.
3. Tunjukkan Login.
4. Tunjukkan Home Screen.
5. Cari resep menggunakan search.
6. Buka detail resep.
7. Simpan resep ke Saved Recipes.
8. Buka Saved Recipes.
9. Tambah resep pribadi.
10. Ambil foto makanan.
11. Edit resep.
12. Hapus resep.
13. Buka Profile.
14. Logout.
15. Jelaskan penggunaan API, SQLite, GetX, dan kamera.

---

## 15. Kesimpulan

Project Plan ini menjadi panduan pengerjaan RecipeBook App dari awal sampai final. Rencana dibuat berdasarkan silabus perkuliahan agar setiap materi dapat diterapkan langsung dalam project.

Dengan mengikuti rencana ini, RecipeBook App dapat selesai secara bertahap, tetap sederhana, dan sesuai dengan kemampuan beginner-to-intermediate Flutter.
