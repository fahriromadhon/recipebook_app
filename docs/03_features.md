# Features - RecipeBook App

## 1. Ringkasan

Dokumen ini berisi daftar fitur **RecipeBook App** secara lebih detail. Fitur disusun berdasarkan kebutuhan aplikasi, materi perkuliahan, dan batasan project agar tetap sederhana.

RecipeBook App menggunakan Flutter dengan GetX, REST API, SQLite, SharedPreferences, dan kamera.

Struktur project mengikuti pola MVC sederhana:

```text id="vl3ioh"
lib/
  model/
  controller/
  screen/
  dataaccess/
  provider/
  utils/
```

Fitur dalam dokumen ini dibagi menjadi:

1. Authentication
2. Splash Screen
3. Home / Recipe List
4. Search Recipe
5. Recipe Detail
6. Saved Recipes
7. Add Recipe
8. Edit Recipe
9. Delete Recipe
10. Camera
11. Local Database
12. REST API
13. Security REST API
14. Error Handling
15. UI Components
16. Profile

---

## 2. Authentication

## 2.1 Login Sederhana

### Deskripsi

Login digunakan sebagai pintu masuk aplikasi. Pada versi awal, login dibuat sederhana tanpa backend.

### Input

| Field    | Tipe | Wajib | Keterangan        |
| -------- | ---- | ----- | ----------------- |
| Username | Text | Ya    | Username pengguna |
| Password | Text | Ya    | Password pengguna |

### Data Login Default

```text id="f89emz"
Username: admin
Password: admin123
```

### Validasi

1. Username tidak boleh kosong.
2. Password tidak boleh kosong.
3. Username dan password harus sesuai dengan data login default.

### Jika Berhasil

1. Simpan status login ke SharedPreferences.
2. Arahkan pengguna ke Home Screen.
3. Tampilkan pesan berhasil menggunakan `Get.snackbar()`.

### Jika Gagal

1. Tampilkan pesan error menggunakan `Get.snackbar()`.
2. Tetap di Login Screen.

---

## 2.2 Logout

### Deskripsi

Logout digunakan untuk keluar dari aplikasi.

### Alur

1. Pengguna menekan tombol logout.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika pengguna memilih logout, hapus status login.
4. Arahkan pengguna ke Login Screen menggunakan `Get.offAll()`.

### Output

Pengguna keluar dari aplikasi dan harus login kembali.

---

## 3. Splash Screen

### Deskripsi

Splash Screen adalah halaman awal untuk mengecek status login.

### Fitur

1. Menampilkan nama aplikasi.
2. Menampilkan ikon aplikasi bertema resep/makanan.
3. Menampilkan teks loading sederhana.
4. Mengecek status login dari SharedPreferences.
5. Mengarahkan pengguna ke halaman yang sesuai.

### Alur

```text id="l0vkk9"
Aplikasi dibuka
    ↓
Splash Screen
    ↓
Cek status login
    ↓
Jika login = true → Home Screen
Jika login = false → Login Screen
```

### Catatan

Splash Screen tidak perlu animasi kompleks.

---

## 4. Home / Recipe List

### Deskripsi

Home Screen menampilkan daftar resep dari public API.

### Fitur

1. Menampilkan daftar resep.
2. Menampilkan gambar resep.
3. Menampilkan nama resep.
4. Menampilkan kategori jika tersedia.
5. Menampilkan area/origin jika tersedia.
6. Menampilkan loading ketika mengambil data.
7. Menampilkan pesan error jika gagal mengambil data.
8. Menyediakan search resep.
9. Menyediakan tombol menuju Saved Recipes.
10. Menyediakan tombol menuju Profile.

### Komponen UI

1. AppBar.
2. TextField search.
3. ListView.
4. Card resep.
5. CachedNetworkImage.
6. CircularProgressIndicator.
7. IconButton.
8. FloatingActionButton atau AppBar action.

### Data yang Ditampilkan

| Data        | Keterangan            |
| ----------- | --------------------- |
| Image       | Gambar resep dari API |
| Recipe Name | Nama resep            |
| Category    | Kategori makanan      |
| Area        | Asal/area makanan     |

---

## 5. Search Recipe

### Deskripsi

Search digunakan untuk mencari resep berdasarkan nama makanan.

### Input

| Field   | Tipe | Keterangan                     |
| ------- | ---- | ------------------------------ |
| Keyword | Text | Nama makanan yang ingin dicari |

### Alur

1. Pengguna mengetik keyword.
2. Pengguna menekan tombol search.
3. Controller memanggil API search.
4. List resep diperbarui berdasarkan hasil pencarian.

### Validasi

1. Jika keyword kosong, tampilkan resep default.
2. Jika hasil tidak ditemukan, tampilkan pesan data kosong.

### Catatan

Search tidak perlu real-time. Untuk versi sederhana, search dijalankan ketika pengguna menekan tombol search.

---

## 6. Recipe Detail

### Deskripsi

Recipe Detail menampilkan informasi lengkap resep yang dipilih dari Home Screen.

### Fitur

1. Menampilkan gambar resep.
2. Menampilkan nama resep.
3. Menampilkan kategori.
4. Menampilkan area/origin.
5. Menampilkan ingredients.
6. Menampilkan instructions.
7. Menyediakan tombol simpan ke Saved Recipes.
8. Menampilkan snackbar ketika data berhasil disimpan.

### Data Detail

| Data         | Keterangan                      |
| ------------ | ------------------------------- |
| ID           | ID resep dari API               |
| Recipe Name  | Nama resep                      |
| Category     | Kategori                        |
| Area         | Asal/area makanan               |
| Image URL    | Gambar resep                    |
| Ingredients  | Bahan-bahan                     |
| Instructions | Langkah memasak                 |
| YouTube URL  | Opsional, tidak wajib digunakan |

### Kondisi Data Kosong

Jika data tertentu tidak tersedia dari API, tampilkan teks default:

```text id="ex44t3"
Data tidak tersedia
```

---

## 7. Saved Recipes

### Deskripsi

Saved Recipes adalah halaman untuk menampilkan resep yang disimpan oleh pengguna. Data berasal dari SQLite.

### Fitur

1. Menampilkan resep yang tersimpan di SQLite.
2. Menampilkan nama resep.
3. Menampilkan gambar dari API atau foto lokal.
4. Menampilkan kategori.
5. Menampilkan area/origin.
6. Menyediakan tombol tambah resep.
7. Menyediakan tombol edit resep.
8. Menyediakan tombol hapus resep.
9. Menampilkan pesan jika data kosong.

### Empty State

Jika belum ada resep:

```text id="wajq68"
No recipes saved yet.
Save your favorite recipe or add your own recipe.
```

### Prioritas Gambar

Urutan gambar yang digunakan:

1. Jika ada `local_image_path`, tampilkan foto lokal.
2. Jika tidak ada, tampilkan `image_url`.
3. Jika keduanya kosong, tampilkan placeholder.

---

## 8. Add Recipe

### Deskripsi

Add Recipe digunakan untuk menambahkan resep pribadi secara manual ke Saved Recipes.

### Input Form

| Field         | Tipe           | Wajib | Keterangan               |
| ------------- | -------------- | ----- | ------------------------ |
| Recipe Name   | Text           | Ya    | Nama resep               |
| Category      | Text           | Ya    | Kategori makanan         |
| Area / Origin | Text           | Tidak | Asal makanan             |
| Ingredients   | Multiline Text | Ya    | Bahan-bahan              |
| Instructions  | Multiline Text | Ya    | Langkah memasak          |
| Note          | Multiline Text | Tidak | Catatan pribadi          |
| Photo         | Image          | Tidak | Foto makanan dari kamera |

### Validasi

1. Recipe Name wajib diisi.
2. Category wajib diisi.
3. Ingredients wajib diisi.
4. Instructions wajib diisi.
5. Area / Origin boleh kosong.
6. Note boleh kosong.
7. Photo boleh kosong.

### Output

Data resep masuk ke SQLite dan muncul di Saved Recipes.

---

## 9. Edit Recipe

### Deskripsi

Edit Recipe digunakan untuk mengubah data resep yang sudah tersimpan.

### Fitur

1. Menampilkan data lama di dalam form.
2. Pengguna dapat mengubah data.
3. Pengguna dapat mengganti foto makanan.
4. Data di SQLite diperbarui.
5. Setelah berhasil, pengguna kembali ke Saved Recipes.

### Validasi

Validasi sama seperti Add Recipe:

1. Recipe Name wajib diisi.
2. Category wajib diisi.
3. Ingredients wajib diisi.
4. Instructions wajib diisi.

---

## 10. Delete Recipe

### Deskripsi

Delete Recipe digunakan untuk menghapus resep dari Saved Recipes.

### Alur

1. Pengguna menekan tombol hapus.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika pengguna memilih batal, data tidak dihapus.
4. Jika pengguna memilih hapus, data dihapus dari SQLite.
5. List Saved Recipes diperbarui.

### Dialog Konfirmasi

```text id="lmqsza"
Judul: Hapus Resep
Pesan: Apakah kamu yakin ingin menghapus resep ini?
Tombol: Batal, Hapus
```

---

## 11. Camera

### Deskripsi

Camera digunakan untuk mengambil foto makanan atau resep pribadi.

### Package

```text id="wg3aq3"
image_picker
```

### Fitur

1. Ambil foto dari kamera.
2. Menampilkan preview foto di form.
3. Menyimpan path foto ke SQLite.
4. Menampilkan foto lokal di Saved Recipes.

### Catatan

Untuk MVP, foto tidak diupload ke server. Aplikasi hanya menyimpan path lokal gambar.

---

## 12. Local Database SQLite

### Deskripsi

SQLite digunakan untuk menyimpan data Saved Recipes.

### Fungsi Database

1. Insert resep.
2. Select semua resep.
3. Select resep berdasarkan ID.
4. Update resep.
5. Delete resep.

### Table Utama

```text id="a191pa"
my_recipes
```

### Data yang Disimpan

| Field            | Tipe    | Keterangan                |
| ---------------- | ------- | ------------------------- |
| id               | INTEGER | Primary key lokal         |
| api_id           | TEXT    | ID dari API, boleh kosong |
| name             | TEXT    | Nama resep                |
| category         | TEXT    | Kategori                  |
| area             | TEXT    | Asal/area makanan         |
| image_url        | TEXT    | URL gambar API            |
| local_image_path | TEXT    | Path foto lokal           |
| instructions     | TEXT    | Langkah memasak           |
| ingredients      | TEXT    | Bahan-bahan               |
| note             | TEXT    | Catatan pengguna          |
| created_at       | TEXT    | Tanggal dibuat            |

---

## 13. REST API

### Deskripsi

REST API digunakan untuk mengambil data resep dari public API.

### API yang Digunakan

```text id="xs5lbc"
TheMealDB API
```

### Base URL

```text id="jsrvsk"
https://www.themealdb.com/api/json/v1/1
```

### Endpoint yang Digunakan

| Fitur           | Method | Endpoint                 |
| --------------- | ------ | ------------------------ |
| Search resep    | GET    | `/search.php?s=keyword`  |
| Detail resep    | GET    | `/lookup.php?i=id`       |
| Categories      | GET    | `/categories.php`        |
| Filter category | GET    | `/filter.php?c=category` |

### Data dari API

1. ID resep.
2. Nama resep.
3. Kategori.
4. Area.
5. Gambar resep.
6. Instruksi.
7. Ingredients.
8. Measures.
9. YouTube URL jika tersedia.

### Error API

Jika API gagal diakses:

1. Tampilkan snackbar error.
2. Jangan crash.
3. Jika data list kosong, tampilkan empty state.

---

## 14. Security REST API

### Deskripsi

Security REST API dibuat sederhana sesuai kebutuhan project kuliah.

### Implementasi

1. Base URL disimpan di satu file, misalnya:

```text id="s5b9n1"
lib/utils/constants.dart
```

2. Endpoint tidak ditulis berulang di banyak file.
3. Jika menggunakan token login sederhana, simpan di SharedPreferences.
4. Request API dibungkus dengan try-catch.
5. Jangan tampilkan konfigurasi API di UI.
6. Jangan print data sensitif ke console.

### Catatan

TheMealDB public API dasar tidak membutuhkan API key. Jika nanti menggunakan API yang membutuhkan key, API key harus diletakkan di satu file constants dan tidak ditampilkan di UI.

---

## 15. Error Handling

### Deskripsi

Error handling dibuat sederhana agar mudah dipahami.

### Jenis Error

| Error         | Solusi                |
| ------------- | --------------------- |
| API gagal     | Tampilkan snackbar    |
| Data kosong   | Tampilkan empty state |
| Gambar kosong | Tampilkan placeholder |
| SQLite error  | Tampilkan snackbar    |
| Kamera gagal  | Tampilkan snackbar    |
| Form kosong   | Tampilkan validator   |

### Contoh Pesan

```text id="jw95g0"
Gagal mengambil data resep
Data resep tidak ditemukan
Nama resep wajib diisi
Foto gagal diambil
Data berhasil disimpan
```

---

## 16. UI Components

### Komponen yang Dibutuhkan

1. Recipe Card.
2. Loading Widget.
3. Empty State Widget.
4. Error State Widget.
5. Form Input.
6. Image Placeholder.
7. Confirmation Dialog.

### Recipe Card

Recipe Card digunakan di Home dan Saved Recipes.

Isi Recipe Card:

1. Gambar resep.
2. Nama resep.
3. Kategori.
4. Area/origin.
5. Tombol aksi jika diperlukan.

---

## 17. State Management GetX

### Controller yang Digunakan

| Controller            | Fungsi                               |
| --------------------- | ------------------------------------ |
| AuthController        | Login, logout, cek status login      |
| RecipeController      | Ambil data API, search, detail resep |
| SavedRecipeController | CRUD SQLite dan kamera               |

### Contoh State

```text id="l6li4a"
isLoading
recipes
selectedRecipe
savedRecipes
imagePath
```

### Aturan

1. Gunakan `GetxController`.
2. Gunakan `.obs` untuk state.
3. Gunakan `Obx()` di UI.
4. Gunakan `Get.to()` untuk navigasi.
5. Gunakan `Get.back()` untuk kembali.
6. Gunakan `Get.offAll()` untuk login/logout.
7. Gunakan `Get.snackbar()` untuk notifikasi.
8. Gunakan `Get.dialog()` untuk konfirmasi.

---

## 18. Profile

### Deskripsi

Profile Screen digunakan untuk menampilkan informasi pengguna dan aplikasi secara sederhana.

### Data yang Ditampilkan

1. Username: `admin`.
2. Subtitle: `RecipeBook User`.
3. Total saved recipes.
4. App version.
5. Logout button.

### Catatan

Profile tidak perlu fitur edit profil, upload avatar, atau role user.

---

## 19. Mapping Fitur ke Materi Kuliah

| Materi                        | Implementasi                                 |
| ----------------------------- | -------------------------------------------- |
| Pengenalan Flutter dan Widget | Text, Image, Icon, Button, Card              |
| Layout Widget                 | Column, Row, Container, ListView             |
| Layout Desain Lanjutan        | Card layout, form layout, detail layout      |
| Flutter Navigation            | Get.to, Get.back, Get.offAll                 |
| ListView Flutter              | Daftar resep                                 |
| Flutter Form                  | Login, tambah resep, edit resep              |
| Flutter SQLite                | Saved Recipes local database                 |
| Flutter SQLite CRUD           | Insert, read, update, delete resep           |
| Flutter REST API              | Ambil data resep dari TheMealDB              |
| Flutter CRUD                  | CRUD resep pribadi                           |
| Akses Camera                  | Foto makanan                                 |
| Security REST API             | Base URL, try-catch, SharedPreferences login |

---

## 20. Prioritas Fitur

### Prioritas 1 - Wajib Selesai

1. Login.
2. Home list resep.
3. Search resep.
4. Detail resep.
5. Save to Saved Recipes.
6. Saved Recipes SQLite.
7. Tambah resep.
8. Edit resep.
9. Hapus resep.
10. Kamera.
11. Profile.
12. Logout.

### Prioritas 2 - Jika Ada Waktu

1. Filter kategori.
2. Pull to refresh.
3. Placeholder image.
4. Empty state yang lebih rapi.
5. Error state yang lebih rapi.

### Prioritas 3 - Tidak Wajib

1. Reminder.
2. Register.
3. Upload foto.
4. Meal planner.
5. AI recommendation.
6. Barcode scanner.
7. Firebase.

---

## 21. Kesimpulan

Fitur RecipeBook App dibuat untuk memenuhi kebutuhan project mata kuliah Flutter tanpa membuat aplikasi terlalu kompleks. Fitur utama berfokus pada penggunaan GetX, REST API, ListView, Form, SQLite CRUD, kamera, profile, dan security REST API sederhana.

Dengan fitur yang ada di dokumen ini, project sudah cukup kuat untuk dipresentasikan sebagai aplikasi mobile berbasis Flutter.
