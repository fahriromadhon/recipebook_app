# User Flow - RecipeBook App

## 1. Ringkasan

Dokumen ini menjelaskan alur penggunaan aplikasi **RecipeBook App** dari awal aplikasi dibuka sampai pengguna menggunakan fitur utama.

User flow dibuat agar proses implementasi screen, navigation, controller, dan logic aplikasi menjadi lebih jelas.

Aplikasi menggunakan:

- Flutter
- GetX untuk navigation dan state management
- SQLite untuk data Saved Recipes
- Public API untuk data resep
- SharedPreferences untuk status login
- Image Picker untuk kamera

---

## 2. Daftar Screen

Screen utama pada aplikasi:

| No  | Screen               | Fungsi                                    |
| --- | -------------------- | ----------------------------------------- |
| 1   | Splash Screen        | Mengecek status login pengguna            |
| 2   | Login Screen         | Form login sederhana                      |
| 3   | Home Screen          | Menampilkan daftar resep dari API         |
| 4   | Recipe Detail Screen | Menampilkan detail resep                  |
| 5   | Saved Recipes Screen | Menampilkan resep yang disimpan di SQLite |
| 6   | Recipe Form Screen   | Menambah atau mengedit resep              |
| 7   | Profile Screen       | Menampilkan profil sederhana dan logout   |
| 8   | State Components     | Tampilan empty state dan error state      |

---

## 3. Alur Utama Aplikasi

Alur utama aplikasi:

```text
Aplikasi dibuka
    ↓
Splash Screen
    ↓
Cek status login
    ↓
Jika belum login → Login Screen
Jika sudah login → Home Screen
```

Setelah pengguna masuk ke Home Screen:

```text
Home Screen
    ├── Pilih resep → Recipe Detail Screen
    ├── Search resep → Home Screen menampilkan hasil pencarian
    ├── Buka Saved Recipes → Saved Recipes Screen
    ├── Buka Profile → Profile Screen
    └── Logout dari Profile → Login Screen
```

---

## 4. Splash Flow

## 4.1 Tujuan

Splash Screen digunakan untuk mengecek apakah pengguna sudah login atau belum.

## 4.2 Alur

```text
Aplikasi dibuka
    ↓
Splash Screen tampil
    ↓
AuthController mengecek SharedPreferences
    ↓
Apakah user sudah login?
    ├── Ya → Home Screen
    └── Tidak → Login Screen
```

## 4.3 State yang Digunakan

| State        | Keterangan                          |
| ------------ | ----------------------------------- |
| `isLoggedIn` | Status login dari SharedPreferences |

## 4.4 Output

| Kondisi          | Tujuan       |
| ---------------- | ------------ |
| User sudah login | Home Screen  |
| User belum login | Login Screen |

---

## 5. Login Flow

## 5.1 Tujuan

Login Flow digunakan agar pengguna dapat masuk ke aplikasi.

Untuk MVP, login dibuat sederhana tanpa backend.

## 5.2 Data Login Default

```text
Username: admin
Password: admin123
```

## 5.3 Alur Login Berhasil

```text
Login Screen
    ↓
User mengisi username dan password
    ↓
User menekan tombol Login
    ↓
Form divalidasi
    ↓
Username dan password benar
    ↓
Simpan status login ke SharedPreferences
    ↓
Tampilkan snackbar berhasil
    ↓
Arahkan ke Home Screen
```

## 5.4 Alur Login Gagal

```text
Login Screen
    ↓
User mengisi username dan password
    ↓
User menekan tombol Login
    ↓
Form divalidasi
    ↓
Username atau password salah
    ↓
Tampilkan snackbar error
    ↓
Tetap di Login Screen
```

## 5.5 Validasi Form

| Field    | Validasi           |
| -------- | ------------------ |
| Username | Tidak boleh kosong |
| Password | Tidak boleh kosong |

## 5.6 Output

| Kondisi        | Output                |
| -------------- | --------------------- |
| Login berhasil | Masuk ke Home Screen  |
| Login gagal    | Muncul snackbar error |
| Field kosong   | Muncul pesan validasi |

---

## 6. Home Flow

## 6.1 Tujuan

Home Screen digunakan untuk menampilkan daftar resep dari public API.

## 6.2 Alur Load Data Resep

```text
Home Screen dibuka
    ↓
RecipeController memanggil API recipe list/search default
    ↓
isLoading = true
    ↓
API mengembalikan data
    ↓
Data disimpan ke list recipes
    ↓
isLoading = false
    ↓
ListView menampilkan daftar resep
```

## 6.3 Alur Jika API Gagal

```text
Home Screen dibuka
    ↓
RecipeController memanggil API
    ↓
API gagal / internet bermasalah
    ↓
isLoading = false
    ↓
Tampilkan snackbar error
    ↓
Tampilkan error state atau list kosong
```

## 6.4 Aksi di Home Screen

| Aksi User                | Tujuan               |
| ------------------------ | -------------------- |
| Klik recipe card         | Recipe Detail Screen |
| Ketik keyword search     | Mengisi keyword      |
| Tekan tombol search      | Memanggil API search |
| Klik Saved Recipes       | Saved Recipes Screen |
| Klik Profile             | Profile Screen       |
| Pull refresh jika dibuat | Load ulang data API  |

---

## 7. Search Recipe Flow

## 7.1 Tujuan

Search digunakan untuk mencari resep berdasarkan keyword makanan.

## 7.2 Alur Search

```text
Home Screen
    ↓
User mengetik keyword
    ↓
User menekan tombol search
    ↓
RecipeController memanggil API search
    ↓
isLoading = true
    ↓
API mengembalikan hasil
    ↓
List recipes diperbarui
    ↓
isLoading = false
```

## 7.3 Jika Keyword Kosong

```text
User menekan search dengan keyword kosong
    ↓
Aplikasi memanggil recipe list default
    ↓
List resep awal ditampilkan
```

Rekomendasi keyword default:

```text
chicken
```

## 7.4 Jika Hasil Kosong

```text
Search dijalankan
    ↓
API berhasil
    ↓
Data tidak ditemukan
    ↓
Tampilkan empty state
```

---

## 8. Recipe Detail Flow

## 8.1 Tujuan

Recipe Detail Screen digunakan untuk melihat informasi resep secara lebih lengkap.

## 8.2 Alur Buka Detail

```text
Home Screen
    ↓
User memilih salah satu recipe card
    ↓
Navigasi ke Recipe Detail Screen
    ↓
RecipeController mengambil detail resep berdasarkan ID
    ↓
Detail resep ditampilkan
```

## 8.3 Data yang Ditampilkan

| Data         | Keterangan                        |
| ------------ | --------------------------------- |
| Recipe image | Gambar resep                      |
| Recipe name  | Nama resep                        |
| Category     | Kategori                          |
| Area         | Asal/area makanan                 |
| Ingredients  | Bahan-bahan                       |
| Instructions | Langkah memasak                   |
| YouTube URL  | Opsional, tidak wajib ditampilkan |

---

## 9. Save to Saved Recipes Flow

## 9.1 Tujuan

Pengguna dapat menyimpan resep dari API ke Saved Recipes.

## 9.2 Alur Simpan

```text
Recipe Detail Screen
    ↓
User menekan tombol Save to Saved Recipes
    ↓
Data Recipe dikonversi menjadi MyRecipe
    ↓
SavedRecipeController memanggil insert SQLite
    ↓
Data tersimpan ke table my_recipes
    ↓
Tampilkan snackbar berhasil
```

## 9.3 Mapping Data

| Recipe         | MyRecipe         |
| -------------- | ---------------- |
| `apiId`        | `apiId`          |
| `name`         | `name`           |
| `category`     | `category`       |
| `area`         | `area`           |
| `imageUrl`     | `imageUrl`       |
| `instructions` | `instructions`   |
| `ingredients`  | `ingredients`    |
| Empty string   | `localImagePath` |
| Empty string   | `note`           |
| Current date   | `createdAt`      |

## 9.4 Jika Simpan Gagal

```text
User menekan Save to Saved Recipes
    ↓
Insert SQLite gagal
    ↓
Tampilkan snackbar error
```

## 9.5 Output

| Kondisi  | Output                       |
| -------- | ---------------------------- |
| Berhasil | Resep masuk ke Saved Recipes |
| Gagal    | Snackbar error               |

---

## 10. Saved Recipes Flow

## 10.1 Tujuan

Saved Recipes Screen menampilkan resep yang disimpan di SQLite.

## 10.2 Alur Load Saved Recipes

```text
Saved Recipes Screen dibuka
    ↓
SavedRecipeController mengambil data dari SQLite
    ↓
isLoading = true
    ↓
Data berhasil diambil
    ↓
savedRecipes diperbarui
    ↓
isLoading = false
    ↓
ListView menampilkan resep
```

## 10.3 Jika Saved Recipes Kosong

```text
Saved Recipes Screen dibuka
    ↓
SQLite tidak memiliki data
    ↓
Tampilkan empty state
```

## 10.4 Aksi di Saved Recipes

| Aksi User       | Tujuan                       |
| --------------- | ---------------------------- |
| Klik Add Recipe | Recipe Form Screen mode add  |
| Klik Edit       | Recipe Form Screen mode edit |
| Klik Delete     | Dialog konfirmasi hapus      |
| Klik Home       | Home Screen                  |
| Klik Profile    | Profile Screen               |

---

## 11. Add Recipe Flow

## 11.1 Tujuan

Recipe Form Screen mode add digunakan untuk menambahkan resep pribadi secara manual.

## 11.2 Alur Tambah Resep

```text
Saved Recipes Screen
    ↓
User menekan Add Recipe
    ↓
Recipe Form Screen terbuka dalam mode add
    ↓
User mengisi form
    ↓
User dapat mengambil foto makanan
    ↓
User menekan Save Recipe
    ↓
Form divalidasi
    ↓
Data disimpan ke SQLite
    ↓
Snackbar berhasil ditampilkan
    ↓
Kembali ke Saved Recipes Screen
```

## 11.3 Validasi Form

| Field         | Validasi    |
| ------------- | ----------- |
| Recipe Name   | Wajib diisi |
| Category      | Wajib diisi |
| Area / Origin | Opsional    |
| Ingredients   | Wajib diisi |
| Instructions  | Wajib diisi |
| Note          | Opsional    |
| Photo         | Opsional    |

## 11.4 Jika Validasi Gagal

```text
User menekan Save Recipe
    ↓
Form belum valid
    ↓
Tampilkan pesan validasi pada field yang kosong
    ↓
Tetap di Recipe Form Screen
```

---

## 12. Edit Recipe Flow

## 12.1 Tujuan

Recipe Form Screen mode edit digunakan untuk mengubah resep yang sudah tersimpan.

## 12.2 Alur Edit Resep

```text
Saved Recipes Screen
    ↓
User menekan Edit pada salah satu resep
    ↓
Recipe Form Screen terbuka dalam mode edit
    ↓
Form terisi data lama
    ↓
User mengubah data
    ↓
User dapat mengganti foto
    ↓
User menekan Update Recipe
    ↓
Form divalidasi
    ↓
Data SQLite diperbarui
    ↓
Snackbar berhasil ditampilkan
    ↓
Kembali ke Saved Recipes Screen
```

## 12.3 Jika Update Gagal

```text
User menekan Update Recipe
    ↓
Update SQLite gagal
    ↓
Tampilkan snackbar error
    ↓
Tetap di Recipe Form Screen
```

---

## 13. Delete Recipe Flow

## 13.1 Tujuan

Delete Recipe Flow digunakan untuk menghapus resep dari Saved Recipes.

## 13.2 Alur Delete

```text
Saved Recipes Screen
    ↓
User menekan Delete
    ↓
Dialog konfirmasi tampil
    ↓
Apakah user yakin?
    ├── Tidak → Dialog ditutup, data tidak dihapus
    └── Ya → Data dihapus dari SQLite
            ↓
            Snackbar berhasil ditampilkan
            ↓
            List Saved Recipes diperbarui
```

## 13.3 Dialog

```text
Title: Hapus Resep
Message: Apakah kamu yakin ingin menghapus resep ini?
Button: Batal, Hapus
```

---

## 14. Camera Flow

## 14.1 Tujuan

Camera digunakan untuk mengambil foto makanan atau resep pribadi.

## 14.2 Alur Ambil Foto

```text
Recipe Form Screen
    ↓
User menekan area foto atau tombol kamera
    ↓
ImagePicker membuka kamera
    ↓
User mengambil foto
    ↓
Path foto disimpan ke state imagePath
    ↓
Preview foto ditampilkan di form
    ↓
Saat form disimpan, path foto masuk ke SQLite
```

## 14.3 Jika Kamera Gagal

```text
User membuka kamera
    ↓
Kamera gagal / user batal
    ↓
Tampilkan snackbar jika diperlukan
    ↓
Tetap di form
```

Catatan:

Jika user batal mengambil foto, aplikasi tidak perlu menampilkan error berlebihan.

---

## 15. Profile Flow

## 15.1 Tujuan

Profile Screen digunakan untuk menampilkan informasi user sederhana dan tombol logout.

## 15.2 Alur Buka Profile

```text
Home Screen / Saved Recipes Screen
    ↓
User menekan Profile
    ↓
Profile Screen terbuka
    ↓
Tampilkan username dan informasi aplikasi
```

## 15.3 Data yang Ditampilkan

| Data            | Keterangan                   |
| --------------- | ---------------------------- |
| Username        | `admin`                      |
| Role / Subtitle | RecipeBook User              |
| Saved Recipes   | Jumlah data di Saved Recipes |
| App Version     | 1.0.0                        |

---

## 16. Logout Flow

## 16.1 Tujuan

Logout digunakan untuk keluar dari aplikasi.

## 16.2 Alur Logout

```text
Profile Screen
    ↓
User menekan Logout
    ↓
Dialog konfirmasi tampil
    ↓
Apakah user yakin logout?
    ├── Tidak → Dialog ditutup
    └── Ya → Hapus status login dari SharedPreferences
            ↓
            Arahkan ke Login Screen
```

## 16.3 Output

| Kondisi           | Output                       |
| ----------------- | ---------------------------- |
| Logout berhasil   | User kembali ke Login Screen |
| Logout dibatalkan | User tetap di Profile Screen |

---

## 17. Empty State Flow

## 17.1 Kondisi Empty State

Empty state muncul ketika data kosong.

Contoh kondisi:

1. Saved Recipes belum memiliki resep.
2. Search resep tidak menemukan hasil.
3. API berhasil dipanggil tetapi data kosong.

## 17.2 Tampilan Empty State

```text
Icon: Recipe book / empty plate
Title: No recipes saved yet
Message: Save your favorite recipe or add your own recipe.
Button: Add Recipe
```

## 17.3 Aksi Empty State

| Lokasi        | Aksi                                          |
| ------------- | --------------------------------------------- |
| Saved Recipes | Tombol Add Recipe menuju Recipe Form Screen   |
| Search Result | Tombol Clear Search atau kembali ke list awal |

---

## 18. Error State Flow

## 18.1 Kondisi Error State

Error state muncul ketika terjadi kesalahan.

Contoh kondisi:

1. Internet bermasalah.
2. API gagal diakses.
3. SQLite gagal mengambil data.
4. Response API tidak valid.

## 18.2 Tampilan Error State

```text
Icon: Warning / wifi off
Title: Something went wrong
Message: Failed to load recipe data. Please check your connection and try again.
Button: Try Again
```

## 18.3 Aksi Error State

| Lokasi        | Aksi                             |
| ------------- | -------------------------------- |
| Home Screen   | Try Again memanggil ulang API    |
| Recipe Detail | Try Again memanggil ulang detail |
| Saved Recipes | Try Again membaca ulang SQLite   |

---

## 19. Main Navigation Flow

Aplikasi dapat menggunakan AppBar actions atau BottomNavigationBar sederhana.

Menu utama:

| Menu          | Screen               |
| ------------- | -------------------- |
| Home          | Home Screen          |
| Saved Recipes | Saved Recipes Screen |
| Profile       | Profile Screen       |

Alur:

```text
Home ↔ Saved Recipes ↔ Profile
```

Catatan:

Jika ingin sederhana, gunakan AppBar icon untuk membuka Saved Recipes dan Profile. BottomNavigationBar tidak wajib.

---

## 20. GetX Navigation

Navigasi menggunakan GetX.

Contoh alur navigation:

```text
Get.to(() => DetailScreen())
Get.to(() => SavedRecipesScreen())
Get.to(() => RecipeFormScreen())
Get.back()
Get.offAll(() => LoginScreen())
```

Aturan:

1. Gunakan `Get.to()` untuk berpindah ke screen baru.
2. Gunakan `Get.back()` untuk kembali.
3. Gunakan `Get.offAll()` setelah login/logout agar user tidak bisa kembali ke screen sebelumnya menggunakan tombol back.
4. Gunakan `Get.snackbar()` untuk pesan berhasil atau gagal.
5. Jangan membuat navigation system terlalu kompleks.

---

## 21. Ringkasan Alur Lengkap

```text
Splash Screen
    ↓
Cek Login
    ├── Belum Login
    │       ↓
    │   Login Screen
    │       ↓
    │   Home Screen
    │
    └── Sudah Login
            ↓
        Home Screen
            ├── Search Recipe
            ├── Recipe Detail
            │       └── Save to Saved Recipes
            │
            ├── Saved Recipes
            │       ├── Add Recipe
            │       ├── Edit Recipe
            │       └── Delete Recipe
            │
            └── Profile
                    └── Logout
                            ↓
                        Login Screen
```

---

## 22. Kesimpulan

User flow RecipeBook App dibuat sederhana agar mudah diimplementasikan menggunakan Flutter dan GetX. Alur utama aplikasi dimulai dari Splash Screen, Login Screen, Home Screen, Detail Screen, Saved Recipes, Form CRUD resep, kamera, Profile, dan Logout.

Dengan user flow ini, proses implementasi screen dan controller menjadi lebih jelas serta tetap sesuai dengan scope project mata kuliah.
