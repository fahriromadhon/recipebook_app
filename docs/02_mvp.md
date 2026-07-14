# MVP - RecipeBook App

## 1. Ringkasan MVP

MVP atau **Minimum Viable Product** adalah versi paling sederhana dari RecipeBook App yang tetap bisa digunakan dan didemonstrasikan.

Pada versi MVP, aplikasi tidak harus memiliki semua fitur lanjutan. Fokus utama MVP adalah memastikan fitur inti berjalan dengan baik, yaitu:

1. Login sederhana.
2. Menampilkan daftar resep dari public API.
3. Mencari resep berdasarkan keyword.
4. Menampilkan detail resep.
5. Menyimpan resep ke database lokal SQLite.
6. Mengelola resep pribadi dengan CRUD.
7. Mengambil foto makanan menggunakan kamera.
8. Logout.

MVP ini dibuat agar project dapat selesai sesuai materi perkuliahan dan tidak terlalu kompleks.

---

## 2. Tujuan MVP

Tujuan MVP RecipeBook App adalah:

1. Membuat aplikasi Flutter yang dapat berjalan di Android.
2. Mengimplementasikan GetX untuk navigasi dan state management sederhana.
3. Mengambil data resep dari public API.
4. Menampilkan data menggunakan ListView.
5. Membuat form tambah dan edit resep.
6. Menyimpan data lokal menggunakan SQLite.
7. Menggunakan kamera untuk mengambil foto makanan.
8. Menyimpan status login menggunakan SharedPreferences.
9. Menunjukkan penerapan materi perkuliahan secara lengkap.

---

## 3. Scope MVP

### 3.1 Termasuk dalam MVP

Fitur yang wajib ada dalam MVP:

1. Splash Screen.
2. Login Screen.
3. Home Screen berisi daftar resep.
4. Search resep.
5. Detail resep.
6. Simpan resep ke Saved Recipes.
7. Saved Recipes Screen.
8. Tambah resep pribadi.
9. Edit resep tersimpan.
10. Hapus resep tersimpan.
11. Ambil foto makanan.
12. Profile sederhana.
13. Logout.
14. Loading state sederhana.
15. Empty state sederhana.
16. Error message sederhana menggunakan snackbar.

---

### 3.2 Tidak Termasuk dalam MVP

Fitur berikut tidak wajib dibuat pada versi MVP:

1. Register user.
2. Backend login asli.
3. Role admin dan user.
4. Push notification.
5. Reminder masak.
6. Firebase.
7. Upload gambar ke server.
8. AI recipe recommendation.
9. Meal planner.
10. Barcode scanner.
11. Google Maps.
12. Kalender masak.
13. Dark mode.
14. Multi-language.
15. Unit test.
16. Clean Architecture.
17. Repository pattern.

---

## 4. Fitur MVP

## 4.1 Splash Screen

### Deskripsi

Splash Screen adalah halaman awal aplikasi. Halaman ini digunakan untuk mengecek apakah pengguna sudah login atau belum.

### Alur

1. Aplikasi dibuka.
2. Splash Screen tampil.
3. Aplikasi mengecek status login dari SharedPreferences.
4. Jika sudah login, pengguna diarahkan ke Home Screen.
5. Jika belum login, pengguna diarahkan ke Login Screen.

### Output

Pengguna diarahkan ke halaman yang sesuai berdasarkan status login.

---

## 4.2 Login Sederhana

### Deskripsi

Login digunakan agar aplikasi memiliki alur autentikasi dasar. Untuk MVP, login tidak menggunakan backend asli.

### Data Login

```text id="j9pye6"
Username: admin
Password: admin123
```

### Validasi

1. Username tidak boleh kosong.
2. Password tidak boleh kosong.
3. Username dan password harus sesuai dengan data login sederhana.

### Jika Login Berhasil

1. Status login disimpan menggunakan SharedPreferences.
2. Pengguna diarahkan ke Home Screen.
3. Aplikasi menampilkan snackbar berhasil login.

### Jika Login Gagal

1. Aplikasi menampilkan snackbar error.
2. Pengguna tetap berada di Login Screen.

---

## 4.3 Home Screen / Daftar Resep

### Deskripsi

Home Screen adalah halaman utama aplikasi. Halaman ini menampilkan daftar resep yang diambil dari public API.

### Fitur

1. Menampilkan daftar resep.
2. Menampilkan gambar resep.
3. Menampilkan nama resep.
4. Menampilkan kategori resep jika tersedia.
5. Menampilkan area/origin resep jika tersedia.
6. Search resep berdasarkan keyword.
7. Refresh data resep.
8. Tombol menuju Saved Recipes.
9. Tombol menuju Profile.

### Komponen Flutter

1. Scaffold.
2. AppBar.
3. TextField untuk search.
4. ListView.
5. Card.
6. CachedNetworkImage.
7. CircularProgressIndicator.
8. Get.snackbar untuk pesan error.

### State GetX

Contoh state yang dibutuhkan:

```text id="vhum43"
recipes
isLoading
keyword
selectedRecipe
```

---

## 4.4 Search Recipe

### Deskripsi

Search digunakan untuk mencari resep berdasarkan nama makanan.

### Alur

1. Pengguna mengetik keyword.
2. Pengguna menekan tombol search.
3. Controller memanggil API search.
4. List resep diperbarui berdasarkan hasil pencarian.

### Jika Keyword Kosong

Jika keyword kosong, aplikasi menampilkan resep default.

### Jika Hasil Kosong

Jika hasil pencarian tidak ditemukan, aplikasi menampilkan empty state.

---

## 4.5 Recipe Detail

### Deskripsi

Recipe Detail menampilkan informasi lebih lengkap dari resep yang dipilih pengguna.

### Data yang Ditampilkan

1. Gambar resep.
2. Nama resep.
3. Kategori.
4. Area / origin.
5. Ingredients.
6. Instructions.
7. Tombol simpan ke Saved Recipes.

### Fitur

1. Menampilkan data detail resep.
2. Menampilkan list ingredients dalam bentuk teks sederhana.
3. Menyimpan resep ke SQLite.
4. Menampilkan snackbar jika berhasil disimpan.
5. Menampilkan placeholder jika gambar tidak tersedia.

### Output

Resep yang dipilih dapat disimpan ke Saved Recipes.

---

## 4.6 Saved Recipes Screen

### Deskripsi

Saved Recipes adalah halaman yang menampilkan resep yang disimpan oleh pengguna. Data pada halaman ini berasal dari database SQLite.

### Fitur

1. Menampilkan list resep dari SQLite.
2. Menampilkan gambar dari API atau foto lokal.
3. Menampilkan nama resep.
4. Menampilkan kategori dan area.
5. Tombol tambah resep pribadi.
6. Tombol edit resep.
7. Tombol hapus resep.

### Kondisi Kosong

Jika belum ada data resep, tampilkan teks:

```text id="nrcufc"
Belum ada resep tersimpan.
```

Atau versi UI yang lebih friendly:

```text id="prxnuy"
No recipes saved yet.
Save your favorite recipe or add your own recipe.
```

---

## 4.7 Tambah Resep Pribadi

### Deskripsi

Pengguna dapat menambahkan resep pribadi secara manual.

### Input Form

1. Recipe Name.
2. Category.
3. Area / Origin.
4. Ingredients.
5. Instructions.
6. Note.
7. Photo.

### Validasi Form

1. Recipe Name wajib diisi.
2. Category wajib diisi.
3. Ingredients wajib diisi.
4. Instructions wajib diisi.
5. Area / Origin boleh kosong.
6. Note boleh kosong.
7. Photo boleh kosong.

### Output

Data resep tersimpan ke SQLite dan muncul di Saved Recipes.

---

## 4.8 Edit Resep

### Deskripsi

Pengguna dapat mengubah data resep yang sudah tersimpan.

### Data yang Bisa Diedit

1. Recipe Name.
2. Category.
3. Area / Origin.
4. Ingredients.
5. Instructions.
6. Note.
7. Photo.

### Output

Data lama di SQLite diperbarui dengan data baru.

---

## 4.9 Hapus Resep

### Deskripsi

Pengguna dapat menghapus resep dari Saved Recipes.

### Alur

1. Pengguna menekan tombol hapus.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika pengguna memilih batal, data tidak dihapus.
4. Jika pengguna memilih hapus, data dihapus dari SQLite.
5. List Saved Recipes diperbarui.

### Dialog

```text id="7vpe8u"
Apakah kamu yakin ingin menghapus resep ini?
```

---

## 4.10 Kamera

### Deskripsi

Fitur kamera digunakan untuk mengambil foto makanan atau hasil masakan.

### Implementasi

Package yang digunakan:

```text id="aewqy7"
image_picker
```

### Alur

1. Pengguna membuka form tambah atau edit resep.
2. Pengguna menekan tombol ambil foto.
3. Kamera terbuka.
4. Pengguna mengambil foto.
5. Path foto disimpan ke dalam form.
6. Saat data disimpan, path foto disimpan ke SQLite.

### Catatan

Aplikasi tidak perlu upload foto ke server pada versi MVP.

---

## 4.11 Profile Screen

### Deskripsi

Profile Screen digunakan untuk menampilkan informasi user sederhana dan tombol logout.

### Data yang Ditampilkan

1. Username: admin.
2. Subtitle: RecipeBook User.
3. Jumlah resep tersimpan.
4. App version.
5. Tombol logout.

---

## 4.12 Logout

### Deskripsi

Logout digunakan untuk keluar dari aplikasi.

### Alur

1. Pengguna menekan tombol logout.
2. Aplikasi menampilkan dialog konfirmasi.
3. Jika user memilih logout, status login di SharedPreferences dihapus atau diubah menjadi false.
4. Pengguna diarahkan kembali ke Login Screen.

---

## 5. Data yang Dibutuhkan

## 5.1 Data dari Public API

Data minimal dari API:

| Field               | Keterangan        |
| ------------------- | ----------------- |
| `idMeal`            | ID resep dari API |
| `strMeal`           | Nama resep        |
| `strCategory`       | Kategori resep    |
| `strArea`           | Area / origin     |
| `strMealThumb`      | Gambar resep      |
| `strInstructions`   | Instruksi memasak |
| `strIngredient1-20` | Bahan makanan     |
| `strMeasure1-20`    | Takaran bahan     |

---

## 5.2 Data SQLite

Data minimal yang disimpan di SQLite:

| Field              | Keterangan                                   |
| ------------------ | -------------------------------------------- |
| `id`               | ID lokal SQLite                              |
| `api_id`           | ID dari API, boleh kosong untuk resep manual |
| `name`             | Nama resep                                   |
| `category`         | Kategori resep                               |
| `area`             | Area / origin                                |
| `image_url`        | URL gambar dari API                          |
| `local_image_path` | Path foto lokal dari kamera                  |
| `instructions`     | Instruksi memasak                            |
| `ingredients`      | Bahan-bahan dalam bentuk teks                |
| `note`             | Catatan pengguna                             |
| `created_at`       | Tanggal dibuat                               |

---

## 6. Package yang Digunakan

Package yang digunakan dalam MVP:

```text id="ng0dgm"
get
http
sqflite
path
path_provider
image_picker
shared_preferences
intl
cached_network_image
```

Keterangan:

| Package                | Fungsi                                 |
| ---------------------- | -------------------------------------- |
| `get`                  | Navigation dan state management        |
| `http`                 | Mengambil data dari public API         |
| `sqflite`              | Database SQLite                        |
| `path`                 | Menggabungkan path database            |
| `path_provider`        | Menentukan lokasi file database SQLite |
| `image_picker`         | Mengakses kamera                       |
| `shared_preferences`   | Menyimpan status login                 |
| `intl`                 | Format tanggal                         |
| `cached_network_image` | Menampilkan dan cache gambar dari URL  |

---

## 7. Struktur Folder MVP

Struktur folder mengikuti MVC sederhana:

```text id="hj45lj"
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

---

## 8. Alur Navigasi MVP

```text id="a1s0jl"
Splash Screen
    ├── jika sudah login → Home Screen
    └── jika belum login → Login Screen

Login Screen
    └── login berhasil → Home Screen

Home Screen
    ├── pilih resep → Detail Screen
    ├── cari resep → Home Screen menampilkan hasil pencarian
    ├── buka Saved Recipes → Saved Recipes Screen
    └── buka Profile → Profile Screen

Detail Screen
    └── simpan resep → Saved Recipes

Saved Recipes Screen
    ├── tambah resep → Recipe Form Screen
    ├── edit resep → Recipe Form Screen
    └── hapus resep → Dialog Konfirmasi

Profile Screen
    └── logout → Login Screen
```

---

## 9. Prioritas Pengerjaan

Urutan pengerjaan MVP:

1. Setup package.
2. Buat struktur folder.
3. Buat constants.
4. Buat model.
5. Buat screen login dan home sederhana.
6. Buat navigation GetX.
7. Integrasi API daftar resep.
8. Buat detail resep.
9. Setup SQLite.
10. Buat CRUD Saved Recipes.
11. Buat form tambah dan edit resep.
12. Tambahkan kamera.
13. Tambahkan profile.
14. Tambahkan logout.
15. Rapikan UI.
16. Testing manual.

---

## 10. Kriteria Selesai MVP

MVP dianggap selesai jika:

1. Aplikasi dapat dibuka tanpa error.
2. Splash Screen dapat mengecek status login.
3. Login sederhana berjalan.
4. Home menampilkan list resep dari API.
5. Search resep berjalan.
6. Detail resep tampil.
7. Resep dapat disimpan ke SQLite.
8. Saved Recipes menampilkan data dari SQLite.
9. Pengguna dapat menambah resep manual.
10. Pengguna dapat mengedit resep.
11. Pengguna dapat menghapus resep.
12. Kamera dapat mengambil foto.
13. Profile Screen tampil.
14. Logout berjalan.
15. Project menggunakan GetX.
16. Struktur folder mengikuti MVC sederhana.

---

## 11. Hal yang Ditunda Setelah MVP

Fitur yang bisa dibuat setelah MVP selesai:

1. Filter resep berdasarkan kategori.
2. Halaman kategori.
3. Favorite terpisah dari resep pribadi.
4. Dark mode.
5. Multi-language.
6. Recipe YouTube link launcher.
7. Meal planner.
8. Reminder masak.
9. Register user.
10. Upload foto ke server.
11. Statistik jumlah resep berdasarkan kategori.

Catatan:

Fitur-fitur di atas tidak wajib untuk project utama. Kerjakan hanya jika fitur inti sudah selesai.

---

## 12. Kesimpulan

MVP RecipeBook App berfokus pada fitur inti yang cukup untuk memenuhi kebutuhan project mata kuliah Flutter. Dengan fitur login, REST API, ListView, detail, SQLite CRUD, form, kamera, profile, dan logout, aplikasi sudah mencakup sebagian besar materi dalam silabus.

MVP ini sengaja dibuat sederhana agar mudah dikerjakan, mudah dijelaskan saat presentasi, dan tetap sesuai dengan batasan project kuliah.
