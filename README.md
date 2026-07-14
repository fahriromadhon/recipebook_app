# RecipeBook App

Aplikasi Flutter untuk mencari resep makanan dari TheMealDB API, melihat detail resep, menyimpan resep favorit, dan mengelola resep pribadi menggunakan SQLite.

Dibuat sebagai project mata kuliah Flutter.

---

## Daftar Isi

- [Tujuan Aplikasi](#tujuan-aplikasi)
- [Fitur Utama](#fitur-utama)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Public API](#public-api)
- [Struktur Folder](#struktur-folder)
- [Cara Instalasi](#cara-instalasi)
- [Cara Menjalankan](#cara-menjalankan)
- [Akun Login Default](#akun-login-default)
- [Struktur Database SQLite](#struktur-database-sqlite)
- [Mapping Fitur ke Materi Perkuliahan](#mapping-fitur-ke-materi-perkuliahan)
- [Alur Aplikasi](#alur-aplikasi)
- [Screenshot](#screenshot)
- [Manual Testing Checklist](#manual-testing-checklist)
- [Batasan Project](#batasan-project)
- [Kesimpulan](#kesimpulan)

---

## Tujuan Aplikasi

1. Menerapkan Flutter widget dan layout.
2. Menerapkan navigation menggunakan GetX.
3. Mengambil data dari REST API (TheMealDB).
4. Menyimpan data lokal dengan SQLite.
5. Membuat fitur CRUD (Create, Read, Update, Delete).
6. Mengakses kamera perangkat.
7. Membuat login/logout sederhana.
8. Membuat project yang sesuai dengan materi perkuliahan Flutter.

---

## Fitur Utama

- [x] Splash Screen
- [x] Login sederhana
- [x] Home recipe list dari API
- [x] Search recipe
- [x] Recipe detail
- [x] Save recipe ke SQLite
- [x] Saved Recipes
- [x] Add personal recipe
- [x] Edit recipe
- [x] Delete recipe
- [x] Camera food photo
- [x] Profile
- [x] Logout
- [x] Empty state
- [x] Error state

---

## Teknologi yang Digunakan

| Teknologi / Package  | Fungsi                              |
| -------------------- | ----------------------------------- |
| Flutter              | Framework aplikasi mobile           |
| Dart                 | Bahasa pemrograman                  |
| GetX                 | State management dan navigation     |
| http                 | Mengambil data dari REST API        |
| sqflite              | Database SQLite                     |
| path                 | Mengatur path database              |
| path_provider        | Menentukan lokasi database          |
| image_picker         | Mengakses kamera                    |
| shared_preferences   | Menyimpan status login              |
| intl                 | Format tanggal                      |
| cached_network_image | Menampilkan gambar dari URL         |

---

## Public API

Aplikasi ini menggunakan **TheMealDB API** untuk mendapatkan data resep.

**Base URL:**

```
https://www.themealdb.com/api/json/v1/1
```

**Endpoint yang digunakan:**

| Endpoint              | Fungsi                         |
| --------------------- | ------------------------------ |
| `/search.php?s=keyword` | Mencari resep berdasarkan kata kunci |
| `/lookup.php?i=id`      | Mendapatkan detail resep berdasarkan ID |

API digunakan untuk:
- Menampilkan daftar resep di halaman Home.
- Melakukan pencarian resep.
- Menampilkan detail resep (nama, kategori, daerah asal, bahan, instruksi, gambar).

---

## Struktur Folder

```
lib/
  main.dart                     # Entry point aplikasi

  model/
    recipe.dart                 # Model data resep dari API
    my_recipe.dart              # Model data resep lokal (SQLite)

  controller/
    auth_controller.dart        # Logic login/logout
    recipe_controller.dart      # Logic API dan data resep
    saved_recipe_controller.dart # Logic saved recipes dan CRUD

  screen/
    splash_screen.dart          # Splash screen cek login status
    login_screen.dart           # Form login
    home_screen.dart            # Daftar resep dari API
    detail_screen.dart          # Detail resep
    saved_recipes_screen.dart   # Daftar resep tersimpan
    recipe_form_screen.dart     # Form tambah/edit resep
    profile_screen.dart         # Profile dan logout

  dataaccess/
    my_recipe_dataaccess.dart   # Akses data SQLite / SharedPreferences

  provider/
    database_provider.dart      # Singleton database SQLite

  utils/
    constants.dart              # Konstanta warna, URL API, dsb.
```

**Penjelasan folder:**

| Folder        | Fungsi                                        |
| ------------- | --------------------------------------------- |
| `model/`      | Menyimpan class data (model) dengan `fromMap()` dan `toMap()` |
| `controller/` | Menyimpan GetX controller untuk logic dan state management |
| `screen/`     | Menyimpan halaman UI aplikasi                 |
| `dataaccess/` | Menyimpan logic akses database SQLite         |
| `provider/`   | Menyimpan singleton database provider         |
| `utils/`      | Menyimpan konstanta dan utility               |

---

## Cara Instalasi

1. Pastikan Flutter SDK sudah terinstall.

2. Clone atau download project ini.

3. Install package dependencies:

```bash
flutter pub add get http sqflite path path_provider image_picker shared_preferences intl cached_network_image
```

4. Jalankan perintah berikut untuk mengunduh semua package:

```bash
flutter pub get
```

---

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

**Catatan:**
- Pastikan emulator Android atau perangkat Android sudah terhubung.
- Untuk menjalankan di Chrome/Web:

```bash
flutter run -d chrome
```

- Untuk fitur kamera, disarankan testing di HP fisik karena kamera emulator sering bermasalah.
- Di Chrome/Web, kamera dan penyimpanan foto lokal tidak tersedia. Gunakan Android untuk fitur lengkap.

---

## Akun Login Default

| Field    | Value      |
| -------- | ---------- |
| Username | `admin`    |
| Password | `admin123` |

---

## Struktur Database SQLite

**Nama database:** `recipebook.db`

**Nama table:** `my_recipes`

| Kolom            | Tipe                              | Keterangan            |
| ---------------- | --------------------------------- | --------------------- |
| `id`             | INTEGER PRIMARY KEY AUTOINCREMENT | ID lokal resep        |
| `api_id`         | TEXT                              | ID resep dari API     |
| `name`           | TEXT                              | Nama resep            |
| `category`       | TEXT                              | Kategori resep        |
| `area`           | TEXT                              | Asal / daerah makanan |
| `image_url`      | TEXT                              | URL gambar dari API   |
| `local_image_path` | TEXT                            | Path foto dari kamera |
| `instructions`   | TEXT                              | Instruksi memasak     |
| `ingredients`    | TEXT                              | Bahan-bahan resep     |
| `note`           | TEXT                              | Catatan pribadi       |
| `created_at`     | TEXT                              | Tanggal data dibuat   |

**Catatan:** Di Chrome/Web, data tidak disimpan di SQLite melainkan di SharedPreferences dalam format JSON.

---

## Mapping Fitur ke Materi Perkuliahan

| Materi                          | Implementasi di Project                                        |
| ------------------------------- | -------------------------------------------------------------- |
| Pengenalan Flutter dan Widget   | Text, Image, Icon, Button, Card                                |
| Layout Widget                   | Column, Row, Container, Padding, ListView                      |
| Layout Desain Lanjutan          | Recipe card, detail layout, form layout                        |
| Flutter Navigation              | `Get.to()`, `Get.back()`, `Get.offAll()`                       |
| ListView Flutter                | Daftar resep di Home dan Saved Recipes                         |
| Flutter Form                    | Form login, form tambah resep, form edit resep                 |
| Flutter SQLite                  | Database `recipebook.db` dengan table `my_recipes`             |
| Flutter SQLite CRUD             | Insert, read, update, delete data resep                        |
| Flutter REST API                | TheMealDB API (`/search.php`, `/lookup.php`)                   |
| Flutter CRUD                    | CRUD personal recipe (Create, Read, Update, Delete)            |
| Akses Camera                    | Mengambil foto makanan dengan `image_picker`                   |
| Security REST API sederhana     | Base URL di constants, try-catch error handling, SharedPreferences untuk login |

---

## Alur Aplikasi

```
Splash Screen
  |
  +-- Jika belum login --> Login Screen
  |                          |
  |                          v
  |                       Home Screen
  |
  +-- Jika sudah login --> Home Screen

Home Screen
  |
  +-- Search Recipe --> Hasil pencarian di Home Screen
  |
  +-- Tap Recipe --> Recipe Detail
  |                    |
  |                    +-- Save to Saved Recipes
  |
  +-- Saved Recipes --> Saved Recipes Screen
  |                       |
  |                       +-- Add Recipe --> Recipe Form (mode add)
  |                       +-- Edit Recipe --> Recipe Form (mode edit)
  |                       +-- Delete Recipe --> Konfirmasi delete
  |
  +-- Profile --> Profile Screen
                    |
                    +-- Logout --> Login Screen
```

---

## Screenshot

> Tambahkan screenshot aplikasi pada folder `docs/screenshots/` dan ganti nama file sesuai di bawah ini.

### Login Screen
![Login Screen](docs/screenshots/login.png)

### Home Screen
![Home Screen](docs/screenshots/home.png)

### Detail Screen
![Detail Screen](docs/screenshots/detail.png)

### Saved Recipes Screen
![Saved Recipes Screen](docs/screenshots/saved-recipes.png)

### Recipe Form Screen
![Recipe Form Screen](docs/screenshots/recipe-form.png)

### Profile Screen
![Profile Screen](docs/screenshots/profile.png)

---

## Manual Testing Checklist

- [ ] Aplikasi dapat dibuka
- [ ] Splash Screen tampil
- [ ] User belum login diarahkan ke Login
- [ ] Login gagal jika field kosong
- [ ] Login gagal dengan credential salah
- [ ] Login berhasil dengan credential benar
- [ ] User yang sudah login diarahkan ke Home saat app dibuka ulang
- [ ] Home menampilkan resep dari API
- [ ] Search resep berjalan
- [ ] Search yang tidak ditemukan menampilkan empty state
- [ ] Detail resep tampil
- [ ] Ingredients tampil
- [ ] Instructions tampil tanpa overflow
- [ ] Save to Saved Recipes berhasil
- [ ] Saved Recipes menampilkan data SQLite
- [ ] Add personal recipe berhasil
- [ ] Edit recipe berhasil
- [ ] Delete recipe berhasil
- [ ] Kamera dapat mengambil foto
- [ ] Foto tampil di form
- [ ] Foto tampil di Saved Recipes
- [ ] Profile tampil
- [ ] Total saved recipes tampil di Profile
- [ ] Logout confirmation muncul
- [ ] Logout berhasil kembali ke Login
- [ ] Aplikasi tidak crash saat API gagal

---

## Batasan Project

Project ini memiliki beberapa batasan karena dibuat sesuai materi perkuliahan:

1. **Tidak ada register user** — Hanya login dengan akun default (`admin / admin123`).
2. **Tidak ada backend login** — Login disimpan secara lokal di SharedPreferences.
3. **Tidak menggunakan Firebase** — Semua data lokal menggunakan SQLite.
4. **Tidak ada upload foto ke server** — Foto hanya disimpan secara lokal.
5. **Tidak ada push notification** — Aplikasi tidak mengirim notifikasi.
6. **Tidak ada AI recommendation** — Tidak ada rekomendasi resep otomatis.
7. **Tidak ada payment / sistem bayar** — Aplikasi gratis.
8. **Tidak ada maps / lokasi** — Tidak menggunakan Google Maps.
9. **Tidak menggunakan Clean Architecture** — Menggunakan arsitektur MVC sederhana.
10. **Tidak menggunakan Repository Pattern** — DataAccess langsung dipanggil oleh Controller.
11. **Tidak menggunakan BLoC / Riverpod / Provider** — State management menggunakan GetX.

Project ini sengaja dibuat sederhana agar sesuai dengan materi yang telah diajarkan di perkuliahan dan mudah dipahami untuk presentasi.

---

## Kesimpulan

RecipeBook App adalah aplikasi Flutter yang menerapkan berbagai materi perkuliahan, mulai dari widget dasar, layout, navigation, ListView, form, SQLite CRUD, REST API, akses kamera, hingga security REST API sederhana.

Aplikasi ini berhasil:

1. Menampilkan resep dari TheMealDB API.
2. Melakukan pencarian resep.
3. Menyimpan resep favorit ke database lokal.
4. Mengelola resep pribadi dengan fitur CRUD lengkap.
5. Mengambil foto makanan menggunakan kamera.
6. Menyediakan login/logout sederhana.
7. Menangani empty state dan error state dengan baik.

Dengan demikian, RecipeBook App dapat digunakan sebagai referensi pembelajaran Flutter dan sebagai project tugas mata kuliah.

---

**Dibuat oleh:** Mahasiswa Flutter  
**Mata Kuliah:** Pemrograman Mobile / Flutter  
**Tahun:** 2026
