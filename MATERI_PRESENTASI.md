# Materi Presentasi — RecipeBook App

**Mata Kuliah:** Pemrograman Flutter  
**Tahun:** 2026

---

## Daftar Isi

1. [Ringkasan Project](#1-ringkasan-project)
2. [Latar Belakang](#2-latar-belakang)
3. [Tujuan Aplikasi](#3-tujuan-aplikasi)
4. [Fitur Aplikasi](#4-fitur-aplikasi)
5. [Teknologi yang Digunakan](#5-teknologi-yang-digunakan)
6. [Public API](#6-public-api)
7. [Database SQLite](#7-database-sqlite)
8. [Struktur Folder](#8-struktur-folder)
9. [Alur Aplikasi](#9-alur-aplikasi)
10. [Penjelasan Tiap Screen](#10-penjelasan-tiap-screen)
11. [Mapping Fitur ke Materi Kuliah](#11-mapping-fitur-ke-materi-kuliah)
12. [Alur Demo Presentasi](#12-alur-demo-presentasi)
13. [Script Penjelasan Saat Demo](#13-script-penjelasan-saat-demo)
14. [Kesimpulan](#14-kesimpulan)

---

## 1. Ringkasan Project

**RecipeBook App** adalah aplikasi Flutter yang digunakan untuk mencari resep makanan dari public API, melihat detail resep, menyimpan resep favorit ke database lokal, dan mengelola resep pribadi dengan fitur CRUD lengkap.

Aplikasi ini dibuat sebagai project perkuliahan Flutter dengan menerapkan materi-materi yang telah diajarkan seperti widget, layout, navigation, ListView, form, SQLite, CRUD, REST API, akses kamera, dan security sederhana.

---

## 2. Latar Belakang

Beberapa masalah sederhana yang melatarbelakangi pembuatan aplikasi ini:

1. **Pengguna sering mencari inspirasi resep makanan** — Banyak orang yang ingin mencoba masakan baru tetapi bingung mencari referensi.
2. **Resep yang ditemukan sering tidak tersimpan rapi** — Setelah menemukan resep menarik, pengguna kesulitan menyimpannya secara terorganisir.
3. **Pengguna ingin mencatat resep pribadi** — Banyak orang memiliki resep turunan keluarga atau resep kreasi sendiri yang ingin dicatat.
4. **Pengguna ingin menyimpan foto makanan sendiri** — Dokumentasi visual hasil masakan sebagai pelengkap catatan resep.

Dari masalah tersebut, dibuatlah RecipeBook App sebagai solusi sederhana dalam satu aplikasi mobile.

---

## 3. Tujuan Aplikasi

1. **Membantu pengguna mencari resep makanan** — Melalui integrasi dengan TheMealDB API.
2. **Menampilkan detail resep** — Informasi lengkap seperti bahan, instruksi, kategori, dan asal daerah.
3. **Menyimpan resep favorit secara lokal** — Menggunakan SQLite agar data tetap ada meskipun offline.
4. **Mengelola resep pribadi** — Fitur CRUD untuk menambah, mengedit, dan menghapus resep buatan sendiri.
5. **Menerapkan materi Flutter selama perkuliahan** — Sebagai bukti pemahaman terhadap materi yang telah diajarkan.

---

## 4. Fitur Aplikasi

| No  | Fitur               | Keterangan                                         |
| --- | ------------------- | -------------------------------------------------- |
| 1   | Splash Screen       | Layar pembuka sambil mengecek status login         |
| 2   | Login               | Form login sederhana dengan username dan password  |
| 3   | Home Recipe List    | Daftar resep dari TheMealDB API                    |
| 4   | Search Recipe       | Pencarian resep berdasarkan kata kunci             |
| 5   | Recipe Detail       | Informasi lengkap resep (gambar, bahan, instruksi) |
| 6   | Save to SQLite      | Menyimpan resep dari API ke database lokal         |
| 7   | Saved Recipes       | Menampilkan semua resep yang tersimpan             |
| 8   | Add Recipe          | Menambah resep pribadi                             |
| 9   | Edit Recipe         | Mengedit resep yang sudah ada                      |
| 10  | Delete Recipe       | Menghapus resep yang tidak diinginkan              |
| 11  | Camera              | Mengambil foto makanan untuk resep pribadi         |
| 12  | Profile             | Informasi user dan jumlah resep tersimpan          |
| 13  | Logout              | Keluar dari aplikasi                               |
| 14  | Empty / Error State | Tampilan ketika data kosong atau terjadi error     |

---

## 5. Teknologi yang Digunakan

| Teknologi / Package  | Fungsi                               |
| -------------------- | ------------------------------------ |
| **Flutter**          | Framework utama untuk membuat aplikasi |
| **Dart**             | Bahasa pemrograman yang digunakan    |
| **GetX**             | State management dan navigation      |
| **http**             | Mengambil data dari REST API         |
| **sqflite**          | Database lokal SQLite                |
| **path_provider**    | Menentukan lokasi penyimpanan database |
| **path**             | Mengatur path / direktori file       |
| **image_picker**     | Mengakses kamera perangkat           |
| **shared_preferences** | Menyimpan status login secara lokal  |
| **intl**             | Memformat tanggal                    |
| **cached_network_image** | Menampilkan dan menyimpan cache gambar dari URL |

---

## 6. Public API

Aplikasi menggunakan **TheMealDB API** — sebuah public API gratis yang menyediakan data resep makanan dari berbagai negara.

**Base URL:**

```
https://www.themealdb.com/api/json/v1/1
```

**Endpoint yang digunakan:**

| Endpoint              | Fungsi                                    |
| --------------------- | ----------------------------------------- |
| `/search.php?s=keyword` | Mencari resep berdasarkan kata kunci     |
| `/lookup.php?i=id`      | Mendapatkan detail resep berdasarkan ID  |

**Contoh penggunaan:**

- `https://www.themealdb.com/api/json/v1/1/search.php?s=chicken` — Mencari resep ayam.
- `https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772` — Mendapatkan detail resep dengan ID tertentu.

**Data yang diambil dari API:**
- ID resep (`idMeal`)
- Nama resep (`strMeal`)
- Kategori (`strCategory`)
- Daerah asal (`strArea`)
- URL gambar (`strMealThumb`)
- Bahan-bahan (`strIngredient1` — `strIngredient20`)
- Takaran (`strMeasure1` — `strMeasure20`)
- Instruksi memasak (`strInstructions`)

---

## 7. Database SQLite

Aplikasi menggunakan SQLite untuk menyimpan data resep secara lokal.

**Nama database:** `recipebook.db`

**Nama table:** `my_recipes`

**Struktur kolom:**

| Kolom              | Tipe Data | Fungsi                            |
| ------------------ | --------- | --------------------------------- |
| `id`               | INTEGER   | ID unik (primary key, auto-increment) |
| `api_id`           | TEXT      | ID resep dari API                 |
| `name`             | TEXT      | Nama resep                        |
| `category`         | TEXT      | Kategori resep                    |
| `area`             | TEXT      | Asal / daerah makanan             |
| `image_url`        | TEXT      | URL gambar dari API               |
| `local_image_path` | TEXT      | Path foto lokal (dari kamera)     |
| `instructions`     | TEXT      | Instruksi memasak                 |
| `ingredients`      | TEXT      | Daftar bahan-bahan                |
| `note`             | TEXT      | Catatan pribadi                   |
| `created_at`       | TEXT      | Tanggal dan waktu data dibuat     |

**Catatan:** Untuk platform Web, data tidak disimpan di SQLite melainkan di SharedPreferences dalam format JSON karena `sqflite` tidak mendukung browser.

---

## 8. Struktur Folder

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
    splash_screen.dart          # Splash screen — cek login status
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
    constants.dart              # Konstanta warna, URL API, dll.
```

**Penjelasan tiap folder:**

| Folder        | Fungsi                                                  |
| ------------- | ------------------------------------------------------- |
| `model/`      | Class data dengan method `fromMap()` dan `toMap()`      |
| `controller/` | GetX controller untuk logic bisnis dan state management |
| `screen/`     | Halaman UI aplikasi                                     |
| `dataaccess/` | Layer akses database (SQLite / SharedPreferences)       |
| `provider/`   | Singleton untuk koneksi database                        |
| `utils/`      | Konstanta warna, URL, dan utility lainnya               |

**Alur data:** `Screen` → memanggil → `Controller` → memanggil → `DataAccess` → menggunakan → `DatabaseProvider`

---

## 9. Alur Aplikasi

```
Splash Screen
  |
  +-- Jika BELUM login --> Login Screen
  |                          |
  |                          v
  |                       Home Screen
  |
  +-- Jika SUDAH login --> Home Screen

Home Screen
  |
  +-- Search Recipe
  |
  +-- Tap resep --> Detail Screen
  |                    |
  |                    +-- Save to Saved Recipes
  |
  +-- Icon Bookmark --> Saved Recipes Screen
  |                       |
  |                       +-- Add Recipe --> Form (tambah)
  |                       +-- Edit Recipe --> Form (edit)
  |                       +-- Delete --> Konfirmasi hapus
  |
  +-- Icon Profile --> Profile Screen
                         |
                         +-- Logout --> Login Screen
```

**Alur navigasi dengan GetX:**

| Aksi                 | Method GetX      | Keterangan                          |
| -------------------- | ---------------- | ----------------------------------- |
| Login                | `Get.offAll()`   | Hapus semua route, pindah ke Home   |
| Logout               | `Get.offAll()`   | Hapus semua route, pindah ke Login  |
| Pindah screen        | `Get.to()`       | Tambah route baru ke stack          |
| Kembali              | `Get.back()`     | Kembali ke screen sebelumnya        |

---

## 10. Penjelasan Tiap Screen

### Splash Screen

- Screen pertama saat aplikasi dibuka.
- Menampilkan logo aplikasi (icon buku) dan tulisan "RecipeBook".
- Mengecek status login dari **SharedPreferences**.
- Jika sudah login → langsung ke **Home Screen**.
- Jika belum login → pindah ke **Login Screen**.
- Menggunakan `Get.put()` untuk mendaftarkan controller secara global.

### Login Screen

- Form login dengan dua field: **Username** dan **Password**.
- Validasi: kedua field tidak boleh kosong.
- Credential default: `admin` / `admin123`.
- Jika salah → snackbar "Invalid username or password".
- Jika benar → simpan status ke SharedPreferences → `Get.offAll()` ke Home.
- Menggunakan **SharedPreferences** agar login tetap terekam meskipun aplikasi ditutup.

### Home Screen

- Menampilkan daftar resep dari TheMealDB API.
- Default menampilkan resep dengan kata kunci "chicken".
- Fitur **search** di bagian atas — pengguna bisa mencari resep lain.
- Setiap resep ditampilkan dalam bentuk **Card** dengan gambar, nama, kategori, dan asal daerah.
- Menggunakan **CachedNetworkImage** untuk menampilkan gambar dari URL.
- Jika API gagal → menampilkan **error state** dengan tombol "Try Again".
- Jika pencarian tidak ditemukan → **empty state**.

### Detail Screen

- Menampilkan detail lengkap sebuah resep.
- Informasi yang ditampilkan:
  - Gambar resep (ukuran besar)
  - Nama resep
  - Chip kategori dan asal daerah
  - Daftar bahan-bahan (ingredients)
  - Instruksi memasak
- Tombol **"Save to Saved Recipes"** untuk menyimpan ke database lokal.
- Menggunakan `SingleChildScrollView` agar konten panjang bisa di-scroll.

### Saved Recipes Screen

- Menampilkan semua resep yang sudah disimpan (dari API maupun buatan sendiri).
- Data diambil dari **SQLite** (atau SharedPreferences untuk Web).
- Setiap item menampilkan gambar, nama, kategori, dan asal daerah.
- Tombol **Edit** untuk mengubah resep.
- Tombol **Delete** untuk menghapus resep (dengan konfirmasi dialog).
- **FloatingActionButton** untuk menambah resep baru.
- Jika belum ada data → **empty state** dengan pesan dan tombol "Add Recipe".

### Recipe Form Screen

- Digunakan untuk **menambah** dan **mengedit** resep pribadi.
- Field yang tersedia:
  - Recipe Name (wajib)
  - Category (wajib)
  - Area / Origin (opsional)
  - Ingredients (wajib)
  - Instructions (wajib)
  - Note (opsional)
  - Photo (opsional) — bisa mengambil foto dari kamera
- Jika mode **edit**, field akan terisi dengan data lama.
- Tombol **kamera** untuk mengambil foto makanan.
- Menggunakan `SingleChildScrollView` agar tidak overflow saat keyboard muncul.
- Validasi form menggunakan `GlobalKey<FormState>`.

### Profile Screen

- Menampilkan avatar user (icon orang di lingkaran orange).
- Nama user (`admin`).
- Status ("RecipeBook User").
- Jumlah **Saved Recipes** (diambil dari controller — realtime via `Obx`).
- **App Version** (diambil dari constants).
- Tombol **Logout** berwarna merah — menampilkan dialog konfirmasi sebelum logout.

---

## 11. Mapping Fitur ke Materi Kuliah

| No | Materi Kuliah              | Implementasi di Project                                     |
| -- | -------------------------- | ----------------------------------------------------------- |
| 1  | **Pengenalan Flutter dan Widget** | Penggunaan Text, Image, Icon, Button, Card di seluruh screen |
| 2  | **Layout Widget**          | Column, Row, Container, Padding, ListView, Expanded          |
| 3  | **Layout Desain Lanjutan** | Recipe card dengan ClipRRect, detail layout, form layout     |
| 4  | **Flutter Navigation**     | `Get.to()` untuk pindah screen, `Get.back()` untuk kembali, `Get.offAll()` untuk login/logout |
| 5  | **ListView Flutter**       | `ListView.builder` untuk daftar resep di Home dan Saved Recipes |
| 6  | **Flutter Form**           | Form login (`LoginScreen`), form tambah/edit resep (`RecipeFormScreen`) dengan validasi |
| 7  | **Flutter SQLite**         | Database `recipebook.db` dengan table `my_recipes` melalui `DatabaseProvider` |
| 8  | **Flutter SQLite CRUD**    | Insert (tambah resep), Read (tampilkan resep), Update (edit), Delete (hapus) melalui `MyRecipeDataAccess` |
| 9  | **Flutter REST API**       | GET request ke TheMealDB API (`/search.php`, `/lookup.php`) menggunakan package `http` |
| 10 | **Flutter CRUD**           | CRUD untuk personal recipe — Create, Read, Update, Delete   |
| 11 | **Akses Camera**           | `image_picker` untuk mengambil foto makanan                  |
| 12 | **Security REST API**      | Base URL disimpan di constants, try-catch untuk error handling, SharedPreferences untuk login session |

---

## 12. Alur Demo Presentasi

Berikut urutan demo yang bisa dilakukan saat presentasi (estimasi waktu: 5–10 menit):

| Langkah | Aksi                              | Durasi |
| ------- | --------------------------------- | ------ |
| 1       | Buka aplikasi                     | 10 detik |
| 2       | Tampilkan Splash Screen           | 10 detik |
| 3       | Login dengan admin/admin123       | 20 detik |
| 4       | Tampilkan Home Screen + data API  | 30 detik |
| 5       | Search resep (misal "beef")       | 20 detik |
| 6       | Buka detail resep                 | 20 detik |
| 7       | Save to Saved Recipes             | 15 detik |
| 8       | Buka Saved Recipes                | 15 detik |
| 9       | Tambah resep pribadi              | 30 detik |
| 10      | Ambil foto dengan kamera          | 20 detik |
| 11      | Edit resep                        | 20 detik |
| 12      | Hapus resep                       | 15 detik |
| 13      | Buka Profile                      | 10 detik |
| 14      | Tunjukkan jumlah saved recipes    | 10 detik |
| 15      | Logout                            | 15 detik |
|         | **Total**                         | **~5 menit** |

---

## 13. Script Penjelasan Saat Demo

Berikut narasi yang bisa dibacakan/diucapkan saat presentasi.

### Pembukaan

> **"Selamat pagi/siang. Perkenalkan, saya ... NPM ... . Pada kesempatan ini saya akan mempresentasikan project Flutter saya yang berjudul RecipeBook App."**
>
> **"RecipeBook App adalah aplikasi Flutter yang digunakan untuk mencari resep makanan dari public API, melihat detail resep, menyimpan resep favorit ke database lokal, dan mengelola resep pribadi."**
>
> **"Aplikasi ini dibuat sebagai project mata kuliah Flutter dengan menerapkan materi-materi yang sudah diajarkan selama perkuliahan."**

### Latar Belakang

> **"Latar belakang pembuatan aplikasi ini cukup sederhana. Banyak dari kita yang suka mencari inspirasi resep masakan di internet, tetapi seringkali resep yang ditemukan tidak tersimpan dengan rapi. Selain itu, beberapa orang juga memiliki resep pribadi atau resep keluarga yang ingin dicatat. Dari situ muncullah ide untuk membuat RecipeBook App."**

### Teknologi

> **"Untuk teknologi yang digunakan, aplikasi ini menggunakan Flutter sebagai framework utama, Dart sebagai bahasa pemrograman, dan GetX untuk state management serta navigation. Untuk mengambil data dari internet, saya menggunakan package http. Data lokal disimpan menggunakan SQLite melalui package sqflite. Untuk kamera, menggunakan image_picker. Sedangkan status login disimpan menggunakan SharedPreferences."**

### Demo — Buka Aplikasi

> **"Sekarang saya akan mendemokan aplikasi ini. Pertama, saya buka aplikasinya."**

### Demo — Splash Screen

> **"Setelah aplikasi dibuka, muncul Splash Screen dengan logo RecipeBook. Di sini aplikasi mengecek apakah user sudah login atau belum. Karena kita belum login, maka kita akan diarahkan ke halaman Login."**

### Demo — Login

> **"Ini adalah halaman Login. Ada dua field yaitu username dan password. Kedua field ini wajib diisi dan sudah ada validasinya. Saya akan login menggunakan credential default yaitu admin dan admin123. Setelah login berhasil, status login disimpan ke SharedPreferences, dan kita langsung diarahkan ke Home Screen."**

### Demo — Home & API

> **"Ini adalah Home Screen. Di sini ditampilkan daftar resep yang diambil dari TheMealDB API. Secara default, aplikasi akan menampilkan resep dengan kata kunci chicken. Setiap resep ditampilkan dalam bentuk Card yang berisi gambar, nama resep, kategori, dan asal daerah. Gambar di sini menggunakan CachedNetworkImage yang akan menyimpan cache gambar agar tidak perlu loading ulang."**

### Demo — Search

> **"Di bagian atas ada fitur search. Saya bisa mencari resep lain, misalnya beef. Maka aplikasi akan memanggil API lagi dengan kata kunci beef dan menampilkan hasilnya. Jika pencarian tidak ditemukan, akan muncul empty state. Jika API mengalami error, akan muncul tampilan error dengan tombol Try Again."**

### Demo — Detail

> **"Saya tap salah satu resep untuk melihat detailnya. Di sini ditampilkan gambar resep ukuran besar, nama resep, chip kategori dan asal daerah, daftar bahan-bahan, serta instruksi memasak. Untuk instruksi yang panjang, kita bisa scroll ke bawah karena menggunakan SingleChildScrollView."**

### Demo — Save to SQLite

> **"Ada tombol Save to Saved Recipes. Jika saya tap, resep ini akan disimpan ke database SQLite. Setelah berhasil, muncul snackbar Success."**

### Demo — Saved Recipes

> **"Saya buka halaman Saved Recipes melalui icon bookmark di AppBar. Di sini ditampilkan semua resep yang sudah saya simpan, termasuk yang tadi baru saya simpan dari API. Data ini diambil dari SQLite."**

### Demo — Add Recipe & Camera

> **"Saya juga bisa menambah resep pribadi dengan menekan tombol +. Akan muncul form yang berisi field nama resep, kategori, asal daerah, bahan-bahan, instruksi, catatan, dan foto. Field yang wajib diisi ada name, category, ingredients, dan instructions. Saya bisa mengambil foto makanan menggunakan kamera dengan menekan tombol Take Photo. Setelah difoto, gambar akan tampil di form. Lalu saya simpan."**

### Demo — Edit & Delete

> **"Untuk mengedit, saya bisa tekan tombol Edit. Form akan terisi dengan data lama. Saya bisa mengubahnya lalu simpan. Untuk menghapus, saya tekan tombol Delete, akan muncul dialog konfirmasi, dan jika saya setuju, data akan dihapus dari SQLite."**

### Demo — Profile

> **"Terakhir, ada halaman Profile. Di sini ditampilkan avatar user, nama admin, jumlah saved recipes yang diambil secara realtime, versi aplikasi, dan tombol logout."**

### Demo — Logout

> **"Jika saya tekan Logout, akan muncul dialog konfirmasi. Setelah saya konfirmasi, status login dihapus dari SharedPreferences dan saya dikembalikan ke halaman Login menggunakan Get.offAll agar tidak bisa kembali ke halaman sebelumnya."**

### Penutup

> **"Sebagai kesimpulan, RecipeBook App ini sudah menerapkan berbagai materi Flutter yang telah diajarkan, mulai dari widget dasar, layout, navigation, ListView, form, SQLite, CRUD, REST API, akses kamera, hingga security sederhana."**
>
> **"Aplikasi ini masih memiliki beberapa batasan karena sengaja dibuat sederhana sesuai materi perkuliahan, seperti tidak ada register user, tidak menggunakan Firebase, dan tidak menggunakan arsitektur yang kompleks."**
>
> **"Sekian presentasi dari saya. Terima kasih atas perhatiannya. Silakan jika ada pertanyaan."**

---

## 14. Kesimpulan

1. **RecipeBook App** adalah aplikasi Flutter yang berhasil menerapkan materi perkuliahan secara komprehensif.

2. **Fitur utama** meliputi pencarian resep dari TheMealDB API, penyimpanan resep ke SQLite, dan pengelolaan resep pribadi dengan CRUD lengkap.

3. **Teknologi yang digunakan** sesuai dengan yang diajarkan: Flutter, Dart, GetX, http, sqflite, image_picker, shared_preferences, dan lainnya.

4. **Materi yang diterapkan** mencakup 12 topik perkuliahan: widget, layout, navigation, ListView, form, SQLite, SQLite CRUD, REST API, CRUD, kamera, dan security REST API.

5. **Aplikasi siap digunakan** sebagai referensi pembelajaran Flutter dan sebagai project tugas mata kuliah.

---

**Dibuat oleh:** Mahasiswa Flutter  
**Mata Kuliah:** Pemrograman Mobile / Flutter  
**Tahun:** 2026
