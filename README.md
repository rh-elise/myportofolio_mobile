Nama : Rheina Uliana

NPM : 2506600801

Kelas : PBP A

# My Portfolio Mobile

[![CI](https://github.com/rh-elise/myportofolio_mobile/actions/workflows/main.yaml/badge.svg)](https://github.com/rh-elise/myportofolio_mobile/actions/workflows/main.yaml)

Aplikasi mobile portofolio pribadi yang dibangun menggunakan **Flutter** dan **Dart**. Proyek ini merupakan pasangan mobile dari website portofolio Django [myportofolio](https://github.com/rh-elise/myportofolio), dan memakai design system yang sama dengan website tersebut.

Proyek ini dikerjakan bertahap mengikuti Tutorial dan Individual Assignment mata kuliah Pemrograman Berbasis Platform. Pada tahap ini aplikasi sudah memiliki halaman menu, drawer navigasi, serta dua halaman formulir (tambah proyek dan tambah pengalaman) lengkap dengan validasi dan dialog ringkasan.

## Hubungan dengan Website Portofolio

Website Django `myportofolio` memiliki halaman dan data berikut:

| Bagian Website | Isi |
| --- | --- |
| Profile (`/`) | Halaman utama berisi sapaan, ringkasan Projects, Experience, dan Artworks |
| Projects (`/projects/`) | Daftar project beserta deskripsi, gambar, tautan eksternal, dan fitur star |
| Experience (`/experience/`) | Riwayat pengalaman dengan kategori, tahun, status ongoing/completed, dan fitur star |
| Artworks (`/artworks/`) | Galeri karya visual dengan kategori, berupa gambar atau video |
| Login / Register / Logout | Autentikasi pengguna berbasis session |
| API (`/api/v1/`) | Endpoint Django REST Framework untuk data Projects dan Experience |

Aplikasi mobile ini disiapkan sebagai klien mobile dari website tersebut. Pada tahap ini aplikasi memiliki halaman menu dengan enam aksi utama:

- **View Projects** — nantinya membuka daftar project.
- **View Experience** — nantinya membuka daftar pengalaman.
- **View Artworks** — nantinya membuka galeri karya.
- **Add Project** — membuka form penambahan project.
- **Add Experience** — membuka form penambahan pengalaman.
- **Logout** — keluar dari sesi pengguna.

## Repositori dan API Backend

| Kebutuhan | Tautan |
| --- | --- |
| Repositori Django | https://github.com/rh-elise/myportofolio |
| API Experience (publik) | https://rheina-uliana-myportofolio.pws.cs.ui.ac.id/api/v1/experience/ |
| API Projects (publik) | https://rheina-uliana-myportofolio.pws.cs.ui.ac.id/api/v1/projects/ |
| Endpoint token | `POST /api/v1/auth/token/` |
| Endpoint logout | `POST /api/v1/auth/logout/` |

Operasi baca (`GET`) dapat diakses tanpa token. Operasi tulis (`POST`) memerlukan header `Authorization: Token <key>`.

## Fitur yang Sudah Ada

- **Kartu identitas (InfoCard):** menampilkan NPM, nama, dan kelas pemilik portofolio.
- **Kartu aksi (ItemCard):** enam tombol menu portofolio dalam bentuk kartu berikon.
- **Warna per aksi:** setiap tombol memakai warna berbeda tanpa percabangan `if-else`. Warna utama diambil dari design system website, ditambah beberapa warna kontras untuk membedakan tiap aksi.
- **Konfirmasi aksi destruktif:** tombol Logout menampilkan dialog konfirmasi sebelum dijalankan.
- **Umpan balik interaktif:** setiap tombol memunculkan `SnackBar` mengambang dengan aksi *Dismiss*.
- **Drawer bersama:** `LeftDrawer` berisi Home, Add Project, dan Add Experience, dipakai oleh halaman menu maupun kedua halaman formulir.
- **Form tambah proyek:** `StatefulWidget` dengan `Form`, `GlobalKey<FormState>`, dan validasi isian wajib.
- **Form tambah pengalaman:** enam input dengan label dan aturan validasi yang sama seperti `ExperienceForm` di Django (judul, deskripsi, kategori, tahun lewat `showDatePicker`, thumbnail, status): judul 3–255 karakter, thumbnail berupa path `/static/` atau URL http(s), dan tahun dalam rentang 1950 sampai tahun berjalan + 5.
- **Dialog ringkasan:** tombol Simpan memanggil `FormState.validate()` lalu menampilkan seluruh isian melalui `AlertDialog` hanya jika valid.
- **Layout responsif:** konten memakai `SafeArea` dan `SingleChildScrollView`. Kartu identitas ditumpuk di layar sempit (< 480 px) dan sejajar di layar lebar, sedangkan grid aksi memakai 2 kolom di ponsel dan 4 kolom di layar lebar.
- **Struktur modular:** halaman ada di `lib/screens/`, komponen yang dipakai ulang ada di `lib/widgets/`, dan `lib/main.dart` hanya berisi bootstrap aplikasi.
- **Integrasi backend Experience (Tutorial 10 & IA9):** daftar dan detail Experience diambil dari `/api/v1/experience/` tanpa login; penambahan pengalaman memerlukan token dan dikirim lewat `POST` bertoken.
- **Autentikasi token:** `AuthState` menyimpan token dari `/api/v1/auth/token/`, `ensureLoggedIn` menjaga halaman tulis, dan status `401`/`403` menghapus sesi.
- **CI/CD:** GitHub Actions menjalankan format, analyze, dan test lewat `very_good_workflows`, lalu membangun serta mengunggah `app-release-apk`.

## Design System

Warna diambil langsung dari `static/css/style.css` pada repositori website agar aplikasi mobile dan website terlihat sebagai satu kesatuan.

| Token | Nilai | Pemakaian di aplikasi |
| --- | --- | --- |
| `--accent` | `#EB1000` | AppBar semua halaman dan tombol View Projects |
| `--ink` | `#151515` | Tombol Add Project dan header drawer |
| `--text-muted` | `#374151` | Tombol Add Experience |
| Accent dark | `#9B0A00` | Tombol Logout |
| `--paper` | `#FFFFFF` | Latar halaman |

Tidak ada warna baru di luar palet tersebut.

## Prasyarat

Sebelum menjalankan proyek, pastikan perangkat sudah memenuhi kebutuhan berikut.

- **Flutter SDK** versi 3.x (proyek ini dikembangkan dengan Flutter 3.47.9 dan Dart 3.13.7).
- **Google Chrome**, digunakan sebagai target eksekusi tercepat selama pengembangan.
- **Android Studio + Android SDK** (opsional), hanya diperlukan jika ingin menjalankan aplikasi pada emulator atau perangkat Android.
- **IDE** dengan ekstensi Flutter, misalnya Visual Studio Code.

Periksa status instalasi Flutter terlebih dahulu:

```bash
flutter doctor
```

Jika muncul peringatan `Some Android licenses not accepted`, setujui lisensi dengan:

```bash
flutter doctor --android-licenses
```

Catatan: peringatan `Visual Studio - develop Windows apps` boleh diabaikan karena proyek ini menargetkan Android dan web, bukan aplikasi desktop Windows.

## Instruksi Setup

Ikuti langkah-langkah berikut untuk menjalankan proyek secara lokal.

### 1. Clone Repository

```bash
git clone https://github.com/rh-elise/myportofolio_mobile.git
```

### 2. Masuk ke Direktori Proyek

```bash
cd myportofolio_mobile
```

### 3. Install Dependencies

Unduh seluruh package yang dibutuhkan sesuai `pubspec.yaml`:

```bash
flutter pub get
```

Model memakai `json_serializable`, jadi berkas `*.g.dart` perlu dibuat sebelum aplikasi dijalankan:

```bash
dart run build_runner build
```

Berkas hasil generate tidak di-commit (lihat `.gitignore`); CI membuatnya ulang otomatis.

### 4. Periksa Perangkat yang Tersedia

Pastikan Flutter mendeteksi target eksekusi, misalnya Chrome atau emulator Android:

```bash
flutter devices
```

### 5. Jalankan Aplikasi

Jalankan server Django terlebih dahulu (`python manage.py runserver`), lalu aplikasi Flutter.

Di Chrome, arahkan ke backend lokal:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

Di emulator Android, `10.0.2.2` adalah alias `localhost` komputer host, sehingga `--dart-define` tidak wajib:

```bash
flutter run
```

Untuk menunjuk backend yang sudah di-deploy:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=https://rheina-uliana-myportofolio.pws.cs.ui.ac.id
```

Login memakai akun superuser Django. Token disimpan di memori oleh `AuthState`, jadi sesi berakhir saat aplikasi ditutup.

### 6. Periksa Kualitas Kode

Pastikan tidak ada error maupun peringatan pada kode:

```bash
flutter analyze
```

Luaran yang diharapkan:

```
Analyzing myportofolio_mobile...
No issues found!
```

### 7. Jalankan Test

```bash
flutter test
```

## Struktur Proyek

Bagian terpenting dari proyek ini adalah direktori `lib/`:

```
myportofolio_mobile/
├── lib/
│   ├── main.dart                    # Bootstrap: main(), MyApp, MaterialApp, dan tema
│   ├── screens/
│   │   ├── menu.dart                # Halaman utama: MyHomePage, InfoCard, ItemHomepage
│   │   ├── project_form.dart        # Form tambah proyek (Tutorial 09)
│   │   └── experience_form.dart     # Form tambah pengalaman (Tugas 8)
│   └── widgets/
│       ├── left_drawer.dart         # Drawer bersama: Home, Add Project, Add Experience
│       └── project_card.dart        # Kartu aksi (ItemCard) beserta navigasinya
├── test/
│   └── widget_test.dart             # Widget test navigasi dan validasi form
├── android/ ios/ web/               # Berkas pembungkus native tiap platform
├── analysis_options.yaml            # Konfigurasi linter Dart
└── pubspec.yaml                     # Manifes dependensi dan aset
```

Pemisahan tersebut mengikuti prinsip *separation of concerns*:

- `main.dart` hanya bertanggung jawab menjalankan aplikasi dan menyiapkan `MaterialApp` beserta temanya.
- `screens/` berisi halaman-halaman yang menjadi tujuan navigasi, sehingga perubahan tampilan satu halaman tidak mengganggu titik masuk aplikasi.
- `widgets/` berisi komponen yang dipakai lebih dari satu halaman, terutama `LeftDrawer` yang muncul di halaman menu dan kedua halaman formulir.

Penjelasan komponen utama:

| Komponen | Berkas | Peran |
| --- | --- | --- |
| `MyHomePage` | `screens/menu.dart` | Halaman menu utama, berupa `StatelessWidget` karena isinya tidak berubah selama aplikasi berjalan. |
| `InfoCard` | `screens/menu.dart` | Widget kartu yang dapat digunakan ulang untuk menampilkan satu pasang judul dan isi. |
| `ItemHomepage` | `screens/menu.dart` | Model data satu tombol menu: nama, ikon, warna, penanda konfirmasi, dan halaman tujuan (`page`). |
| `ItemCard` | `widgets/project_card.dart` | Kartu tombol yang meminta konfirmasi bila diperlukan, memunculkan `SnackBar`, lalu membuka `item.page` bila ada. |
| `LeftDrawer` | `widgets/left_drawer.dart` | Drawer bersama. Opsi Home memakai `popUntil` agar kembali ke halaman utama tanpa menumpuk halaman. |
| `ProjectFormPage` | `screens/project_form.dart` | Form tambah proyek dari Tutorial 09. |
| `ExperienceFormPage` | `screens/experience_form.dart` | Form tambah pengalaman: `Form`, `GlobalKey<FormState>`, `showDatePicker`, validasi URL, dan dialog ringkasan. |

## Mengubah Data Portofolio

Seluruh data yang ditampilkan berada di `lib/screens/menu.dart` pada kelas `MyHomePage`:

```dart
final String npm = "2506600801";
final String name = "Rheina Uliana";
final String className = "PBP A";

final List<ItemHomepage> items = const [
  // Warna diambil dari design system website portofolio
  // (static/css/style.css): accent, ink, text muted, accent dark.
  ItemHomepage("View Projects", Icons.folder, Color(0xFFEB1000)),
  ItemHomepage(
    "Add Project",
    Icons.add_circle,
    Color(0xFF151515),
    page: ProjectFormPage(),
  ),
  ItemHomepage(
    "Add Experience",
    Icons.work_outline,
    Color(0xFF374151),
    page: ExperienceFormPage(),
  ),
  ItemHomepage(
    "Logout",
    Icons.logout,
    Color(0xFF9B0A00),
    requiresConfirmation: true,
  ),
];
```

Untuk menambah tombol baru, cukup tambahkan satu entri `ItemHomepage` pada list `items` dan isi `page` dengan halaman tujuannya. Jumlah kolom grid menyesuaikan otomatis (2 kolom di ponsel, 4 kolom di layar lebar). Parameter `requiresConfirmation` diisi `true` hanya untuk aksi yang bersifat destruktif, seperti Logout.

## Progres Mingguan

| Tahap | Topik | Status |
| --- | --- | --- |
| Tutorial 08 | Basic Flutter: setup proyek, pemisahan `menu.dart`, `InfoCard`, `ItemCard`, `SnackBar` | Selesai |
| Tugas 7 (IA7) | Personalisasi identitas pemilik, warna aksi sesuai design system, dialog konfirmasi logout, `SnackBar` mengambang, layout responsif | Selesai |
| Tutorial 09 | Navigasi `Navigator.push`, drawer menu, dan form tambah proyek dengan validasi | Selesai |
| Tugas 8 (IA8) | Form Experience baru, `showDatePicker`, validasi panjang/URL/rentang tahun, drawer Home, dan dialog ringkasan | Selesai |
| Tutorial 10 | Integrasi DRF, token authentication, `ApiClient`, `AuthState`, dan CI/CD | Selesai |
| Tugas 9 (IA9) | Integrasi Experience: list/detail publik, form POST bertoken, dan artefak APK | Selesai |

---

## Pengungkapan Penggunaan AI (AI Disclosure)
#### Strategi Prompting

- Menyertakan lembar tugas IA8, kode `lib/screens/project_form.dart`, dan `lib/widgets/left_drawer.dart` sebagai acuan agar saran yang diberikan sesuai dengan pola dan materi Tutorial 09, bukan menggunakan contoh kode yang terlalu umum.
- Meminta AI membaca `main/models.py` pada proyek Django terlebih dahulu agar field form (`title`, `description`, `category`, `year`, `status`, dan `thumbnail`) sesuai dengan model `Experience`, termasuk pilihan kategorinya.
- Meminta AI memeriksa setiap poin checklist, mulai dari navigasi, layout, validasi, hingga dialog, sebelum mulai menulis kode. Setelah itu, saya meminta urutan pengerjaan agar setiap bagian bisa dikerjakan secara bertahap.
- Menjalankan `flutter analyze` dan `flutter test` sendiri setelah melakukan perubahan. Jika muncul error, saya menyalin pesan error tersebut untuk dibahas kembali dengan AI.

#### Bagian yang Dibantu AI

- **Penyesuaian field dengan model:** AI membantu menyusun enam input untuk form Experience agar sesuai dengan field dan aturan validasi pada `ExperienceForm` di Django. Aturannya mencakup judul sepanjang 3–255 karakter, thumbnail berupa path `/static/` atau URL http(s), serta pemilihan tahun menggunakan `showDatePicker` dalam mode tahun.
- **Penyederhanaan navigasi:** AI menyarankan penggunaan properti `ItemHomepage.page` agar `ItemCard` dapat langsung membuka halaman yang dituju, tanpa harus mencocokkan nama item melalui kondisi seperti `item.name == "Add Project"`.
- **Perbaikan drawer:** AI membantu mengatur navigasi drawer, seperti menggunakan `Navigator.pop()` untuk menutup drawer sebelum berpindah halaman dan `popUntil((route) => route.isFirst)` untuk mengarahkan pengguna kembali ke Home.
- **Pembuatan widget test:** AI membantu menambahkan beberapa pengujian, seperti akses ke halaman form, validasi input kosong dan URL, kemunculan dialog ringkasan, serta alur navigasi kembali ke Home.
- **Penyusunan dokumentasi:** AI membantu memperbarui dokumentasi proyek, termasuk struktur folder, tabel design system, progres mingguan, dan styling pada README.

#### Keterbatasan AI yang Ditemui

- **Tidak selalu dapat mendeteksi masalah tampilan:** Salah satu contohnya adalah overflow sebesar 33 piksel pada `DrawerHeader` yang baru diketahui setelah menjalankan `flutter test` dan muncul pesan `A RenderFlex overflowed by 33 pixels`. Perbaikannya dilakukan dengan membatasi `maxLines` dan menggunakan `Flexible`, tetapi hasilnya tetap perlu diuji kembali.
- **Saran awal belum tentu sesuai dengan model:** Pada awalnya, AI masih menggunakan beberapa nama field dan pilihan kategori dari form Project untuk form Experience. Akibatnya, form yang disarankan belum sesuai dengan model yang digunakan. Saya perlu mencocokkannya kembali dengan isi `main/models.py`.
- **Tidak dapat memastikan kenyamanan tampilan:** AI dapat membantu menyusun layout dari kode, tetapi belum tentu bisa menilai apakah tampilannya nyaman digunakan. Karena itu, saya tetap memeriksa hasilnya melalui `flutter run -d chrome`, termasuk pada ukuran layar seperti ponsel dan saat keyboard muncul.
- **Jawaban AI perlu dibuktikan:** AI terkadang menyatakan bahwa suatu perubahan sudah benar, padahal kode tersebut belum dijalankan. Oleh karena itu, saya tidak langsung menganggap semua saran sudah berhasil dan tetap melakukan pengecekan melalui `flutter analyze`, `flutter test`, serta pengujian manual.

#### Verifikasi Manual yang Dilakukan

- Memilih `Experience` sebagai model yang digunakan untuk form karena model tersebut memang sudah tersedia pada website Django, sehingga tidak perlu membuat bagian baru yang tidak memiliki padanan data.
- Menjalankan `flutter analyze` hingga tidak ditemukan masalah (`No issues found!`) dan `flutter test` hingga seluruh pengujian berhasil sebelum melakukan commit.
- Menguji aplikasi melalui Chrome dengan membuka form dari kartu maupun drawer, mencoba mengosongkan input wajib, memasukkan URL yang tidak valid, dan mengisi seluruh field hingga dialog ringkasan muncul. Saya juga memastikan tombol OK dapat mengosongkan kembali form.
- Memastikan tombol Save tetap mudah dijangkau pada layar yang sempit dengan menggunakan `SingleChildScrollView` dan menambahkan jarak pada bagian bawah form.

#### Tambahan untuk Assignment 9

- **Alat:** asisten AI berbasis LLM (DeepSeek melalui OpenCode) untuk membaca ulang kode Tutorial 10 dan menyusun langkah integrasi Experience.
- **Strategi prompting:** menyertakan lembar IA9, `main/models.py`, `main/serializers.py`, `main/api_urls.py`, serta `project_list_screen.dart`, `project_detail_screen.dart`, `project_form.dart`, dan `api_client.dart` sebagai acuan pola. Saya meminta AI menunjukkan lokasi perubahan (nama file dan method) sebelum menulis kode, lalu memeriksa setiap saran dengan `flutter analyze` dan `flutter test`.
- **Bagian yang dibantu:** pemetaan label ke slug (`full-time`, `part-time`, `ongoing`, `completed`), method `getExperiences`/`createExperience`, list dan detail screen, refactor `_submit()` agar memakai token, serta penyesuaian widget test.
- **Koreksi manual:** AI awalnya menyalin model `Project` menjadi `Experience` sehingga `image`/`link` tidak ada di serializer dan `category`/`year`/`status` tidak pernah diisi. Saya memperbaikinya berdasarkan `ExperienceSerializer`. AI juga sempat menyarankan `_category.toLowerCase()`, yang menghasilkan `parttime` (bukan `part-time`), sehingga saya menggantinya dengan peta slug eksplisit. Selain itu, backend membalas `403` (bukan `401`) untuk token yang dicabut, jadi penanganan sesi memeriksa kedua status.
- **Keterbatasan:** AI tidak dapat melihat log GitHub Actions tanpa login, sehingga penyebab job `build` merah diverifikasi manual dari halaman run; solusi yang diterapkan adalah mematok versi Flutter agar sama dengan lingkungan lokal.

### Log Obrolan AI

1. [Link Chat 1](https://drive.google.com/file/d/1JL3fvUyxVwTbR80omkDarGHWWh2a1sjP/view?usp=sharing)

---

## Pertanyaan Reflektif

### Tugas 7

1. **Widget Tree pada Flutter dan Hubungan Parent-Child Antar-Widget**

   Widget Tree adalah representasi hierarki dari seluruh widget yang membentuk User Interface (UI) dalam aplikasi Flutter. Setiap widget menjadi sebuah node dalam tree dan dapat memiliki widget lain sebagai child-nya.

   Hubungan antar-widget terdiri dari:

   - **Parent:** widget yang membungkus atau memiliki widget lain.
   - **Child:** widget yang berada di dalam widget lain.

   Pada proyek ini, `main.dart` menempatkan `MyHomePage` sebagai `home` dari `MaterialApp`, lalu `MyHomePage` membangun `Scaffold` yang membungkus seluruh isi halaman:

   ```dart
   MaterialApp(
     title: 'MyPortfolio',
     theme: ThemeData(...),
     home: const MyHomePage(),
   )
   ```

   Struktur Widget Tree pada halaman menu:

   ```
   MaterialApp
   └── MyHomePage
       └── Scaffold
           ├── AppBar
           │   └── Text
           └── SafeArea
               └── SingleChildScrollView
                   └── Column
                       ├── Row
                       │   ├── InfoCard
                       │   ├── InfoCard
                       │   └── InfoCard
                       └── Center
                           └── Column
                               ├── Text
                               └── LayoutBuilder
                                   └── GridView
                                       └── ItemCard
   ```

   Widget Tree digunakan Flutter dalam proses layout, rendering (menampilkan UI ke layar), dan hit testing (menentukan widget yang menerima interaksi seperti sentuhan). Ketika terjadi perubahan state, widget yang bersangkutan beserta child-nya dapat mengalami rebuild sehingga tampilan diperbarui.

2. **Daftar Widget yang Digunakan dalam Proyek Ini Beserta Fungsinya**

   Widget-widget berikut dipakai langsung di `lib/main.dart` dan `lib/menu.dart`:

   | Widget | Fungsi | Berkas |
   | --- | --- | --- |
   | `MaterialApp` | Menjadi dasar aplikasi Material Design: tema, navigasi, dan halaman awal. | `main.dart` |
   | `Scaffold` | Menyediakan struktur dasar halaman: `AppBar`, `body`, dan wadah `SnackBar`. | `menu.dart` |
   | `AppBar` | Menampilkan header atau toolbar aplikasi. | `menu.dart` |
   | `SafeArea` | Menjaga konten agar tidak tertutup notch atau status bar. | `menu.dart` |
   | `SingleChildScrollView` | Membuat isi halaman dapat digulir saat layar pendek. | `menu.dart` |
   | `Column` | Menyusun widget secara vertikal. | `menu.dart` |
   | `Row` | Menyusun tiga `InfoCard` secara horizontal. | `menu.dart` |
   | `Center` | Menempatkan child di tengah area yang tersedia. | `menu.dart` |
   | `Padding` | Memberikan jarak di sekitar child. | `menu.dart` |
   | `SizedBox` | Memberikan jarak antar-widget. | `menu.dart` |
   | `Text` | Menampilkan tulisan seperti NPM, nama, dan label tombol. | `menu.dart` |
   | `Icon` | Menampilkan ikon pada setiap `ItemCard`. | `menu.dart` |
   | `Card` | Membungkus isi `InfoCard` agar tampil sebagai kartu. | `menu.dart` |
   | `Container` | Mengatur lebar dan padding kartu. | `menu.dart` |
   | `Material` | Memberi warna latar kartu aksi beserta efek ripple. | `menu.dart` |
   | `InkWell` | Mendeteksi tap pada kartu aksi. | `menu.dart` |
   | `LayoutBuilder` | Membaca lebar area yang tersedia untuk menentukan jumlah kolom. | `menu.dart` |
   | `GridView` | Menampilkan kartu aksi dalam tata letak kisi. | `menu.dart` |
   | `MediaQuery` | Mengambil ukuran layar untuk menghitung lebar `InfoCard`. | `menu.dart` |
   | `Theme` | Mengakses `colorScheme` aplikasi. | `main.dart`, `menu.dart` |
   | `AlertDialog` | Menampilkan dialog konfirmasi sebelum logout. | `menu.dart` |
   | `TextButton` | Tombol "Cancel" pada dialog konfirmasi. | `menu.dart` |
   | `FilledButton` | Tombol "Confirm" pada dialog konfirmasi. | `menu.dart` |
   | `Navigator` | Menutup dialog dan mengembalikan hasil pilihan pengguna. | `menu.dart` |
   | `SnackBar` | Menampilkan pesan singkat di bagian bawah layar. | `menu.dart` |
   | `SnackBarAction` | Menyediakan tombol "Dismiss" pada `SnackBar`. | `menu.dart` |
   | `ScaffoldMessenger` | Menampilkan dan menyembunyikan `SnackBar`. | `menu.dart` |

   Semua widget tersebut dikombinasikan menjadi komponen yang dapat digunakan kembali. `InfoCard` dipakai tiga kali untuk NPM, nama, dan kelas, sedangkan `ItemCard` dipakai untuk setiap item pada list `items`.

3. **Fungsi `MaterialApp` dan Alasan Widget Ini Digunakan sebagai Root Widget**

   `MaterialApp` adalah widget yang menyediakan konfigurasi dasar aplikasi Flutter dengan Material Design. Pada proyek ini, `MaterialApp` menjadi root widget di `lib/main.dart`:

   ```dart
   void main() {
     runApp(const MyApp());
   }

   class MyApp extends StatelessWidget {
     const MyApp({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'MyPortfolio',
         theme: ThemeData(
           colorScheme: ColorScheme.fromSeed(
             seedColor: const Color(0xFFEB1000),
             primary: const Color(0xFFEB1000),
             secondary: const Color(0xFF151515),
           ),
           useMaterial3: true,
         ),
         home: const MyHomePage(),
       );
     }
   }
   ```

   Beberapa fungsi `MaterialApp`:

   - Menentukan halaman awal aplikasi melalui properti `home`, pada proyek ini `MyHomePage`.
   - Menyediakan konfigurasi tema aplikasi, termasuk palet merah dan ink yang dipakai `AppBar` serta kartu aksi.
   - Mendukung navigasi antarhalaman.
   - Menyediakan lingkungan Material Design untuk widget turunannya.

   Dengan menjadikan `MaterialApp` sebagai root widget, widget lain dapat menggunakan fitur dan konfigurasi yang disediakan oleh aplikasi, seperti `Theme` dan navigasi.

4. **Perbedaan `StatelessWidget` dan `StatefulWidget`, Serta Kapan Memilih Masing-Masing**

   **A. StatelessWidget**

   `StatelessWidget` adalah widget yang tidak memiliki state internal yang dapat berubah melalui aksi widget itu sendiri. Properti yang diterima biasanya bersifat `final`, sehingga nilainya ditentukan ketika widget dibuat. Halaman menu pada proyek ini menggunakan `StatelessWidget`:

   ```dart
   class MyHomePage extends StatelessWidget {
     const MyHomePage({super.key});

     final String npm = "2506600801";
     final String name = "Rheina Uliana";
     final String className = "PBP A";

     @override
     Widget build(BuildContext context) {
       return Scaffold(...);
     }
   }
   ```

   Data NPM, nama, kelas, dan daftar `items` tidak berubah selama aplikasi berjalan, sehingga tidak perlu class `State` pendamping.

   **B. StatefulWidget**

   `StatefulWidget` adalah widget yang memiliki class `State` pendamping untuk menyimpan dan mengelola state yang dapat berubah selama aplikasi berjalan. Widget ini menggunakan `createState()` untuk membuat objek State dan `build()` untuk membangun tampilannya.

   ```dart
   class Counter extends StatefulWidget {
     @override
     State<Counter> createState() => CounterState();
   }

   class CounterState extends State<Counter> {
     int counter = 0;

     @override
     Widget build(BuildContext context) {
       return ElevatedButton(
         onPressed: () {
           setState(() {
             counter++;
           });
         },
         child: Text('Counter: $counter'),
       );
     }
   }
   ```

   Setiap kali tombol ditekan, `counter` bertambah. `setState()` memberi tahu Flutter bahwa state berubah sehingga widget perlu di-rebuild.

   | Aspek | StatelessWidget | StatefulWidget |
   | --- | --- | --- |
   | State | Tidak memiliki state internal. | Memiliki class State pendamping. |
   | Properti | Umumnya menggunakan `final`. | Widget tetap immutable, perubahan disimpan di State. |
   | Rebuild | Dipengaruhi perubahan dari parent. | Dipengaruhi perubahan input atau state internal. |
   | Method | `build()` | `createState()` dan `build()` pada State. |
   | Penggunaan | Tampilan sederhana dan statis. | Tampilan dengan data yang dapat berubah. |

   Jadi, gunakan `StatelessWidget` ketika komponen tidak perlu mengelola state sendiri, seperti halaman menu ini. Gunakan `StatefulWidget` ketika terdapat data lokal yang berubah, misalnya input pengguna atau counter. Pada proyek ini belum ada `StatefulWidget` karena dialog dan `SnackBar` sudah dikelola oleh `Navigator` dan `ScaffoldMessenger` milik Flutter.

5. **Pengertian `BuildContext` dan Pentingnya dalam Flutter**

   `BuildContext` adalah objek yang merepresentasikan posisi sebuah widget di dalam Widget Tree. Setiap widget yang menggunakan metode `build()` menerima `BuildContext` sebagai parameter:

   ```dart
   @override
   Widget build(BuildContext context) {
     return Scaffold(...);
   }
   ```

   `context` membantu widget mengakses informasi dari widget lain yang berada di atasnya (ancestor) dalam Widget Tree. Beberapa contoh penggunaannya di proyek ini:

   ```dart
   // Mengambil warna utama dari tema yang disediakan MaterialApp.
   backgroundColor: Theme.of(context).colorScheme.primary,

   // Mengambil lebar layar untuk menghitung lebar InfoCard.
   width: MediaQuery.of(context).size.width / 3.5,

   // Menampilkan SnackBar melalui Scaffold terdekat.
   ScaffoldMessenger.of(context).showSnackBar(...);
   ```

   Kode `Theme.of(context)` digunakan untuk mengakses konfigurasi Theme yang diwariskan melalui `InheritedWidget`. `InheritedWidget` sendiri berfungsi menyebarkan informasi ke widget-widget turunannya tanpa harus mengirimkan data secara manual satu per satu.

   Pada dialog konfirmasi logout, `ItemCard` memakai `dialogContext` milik `AlertDialog` untuk menutup dialog:

   ```dart
   Navigator.of(dialogContext).pop(true)
   ```

   Context tersebut berbeda dengan `context` milik `ItemCard` karena posisinya berada di dalam tree dialog. Selain itu, setelah `await showDialog(...)` selesai, `context` milik `ItemCard` bisa sudah tidak valid, sehingga perlu dicek dengan `if (!context.mounted) return;` sebelum dipakai kembali.

   Jadi, `BuildContext` penting karena memungkinkan widget mengakses informasi dan konfigurasi berdasarkan posisinya dalam Widget Tree.

6. **Konsep Hot Reload, Perbedaannya dengan Hot Restart, dan Kapan Hot Reload Tidak Lagi Cukup**

   Flutter menyediakan fitur Hot Reload untuk mempercepat proses pengembangan aplikasi. Hot Reload memungkinkan developer menerapkan perubahan kode dan membangun ulang Widget Tree tanpa harus memulai ulang aplikasi. Keunggulan utamanya adalah state aplikasi tetap dipertahankan. Pada proyek ini, saat aplikasi dijalankan dengan `flutter run -d chrome`, menekan `r` di terminal akan melakukan Hot Reload dan perubahan tampilan langsung terlihat.

   Hot Restart memulai ulang aplikasi dari awal. Berbeda dengan Hot Reload, state aplikasi akan hilang dan fungsi `main()` serta `initState()` dijalankan kembali. Full Restart memulai ulang seluruh aplikasi sekaligus melakukan kompilasi ulang kode native, sehingga prosesnya lebih lama.

   | Aspek | Hot Reload | Hot Restart | Full Restart |
   | --- | --- | --- | --- |
   | Memperbarui kode | Ya | Ya | Ya |
   | Widget Tree | Rebuild | Aplikasi restart | Aplikasi restart |
   | State | Dipertahankan | Hilang | Hilang |
   | `main()` / `initState()` | Tidak dijalankan ulang | Dijalankan ulang | Dijalankan ulang |
   | Waktu | Paling cepat | Lebih lama | Paling lama |

   Hot Reload tidak cukup ketika perubahan kode membutuhkan inisialisasi ulang aplikasi, misalnya:

   - Perubahan pada fungsi `main()` atau proses inisialisasi.
   - Perubahan struktur kode tertentu yang tidak didukung Hot Reload.
   - Perubahan tidak diterapkan dengan benar setelah Hot Reload, misalnya setelah menambahkan package baru di `pubspec.yaml`.

   Dalam kondisi tersebut, developer dapat menggunakan Hot Restart. Jika perubahan juga melibatkan kode native seperti Java, Kotlin, Swift, atau Objective-C, Full Restart mungkin diperlukan. Hot Reload menggunakan Dart JIT (Just-In-Time) sehingga perubahan dapat diterapkan dengan cepat tanpa melakukan kompilasi ulang seluruh kode native.

### Tugas 8

1. **Perbedaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`, metode untuk membuka form dari kartu aksi, serta cara opsi Home mengembalikan pengguna ke halaman utama.**

   - `Navigator.push()` menambahkan route baru di atas route yang sedang aktif. Route lama tetap berada di stack, sehingga tombol back perangkat mengembalikan pengguna ke halaman sebelumnya.
   - `Navigator.pushReplacement()` mengganti route yang sedang aktif dengan route baru, jadi pengguna tidak bisa kembali ke halaman sebelumnya lewat tombol back. Metode ini cocok ketika halaman sebelumnya tidak boleh dibuka lagi, misalnya setelah login berhasil.
   - `Navigator.pop()` melepas route teratas dari stack dan kembali ke route di bawahnya. Di proyek ini `pop()` dipakai untuk menutup `AlertDialog` ringkasan dan untuk menutup drawer.

   Kartu aksi membuka formulir dengan `Navigator.push()`, tepatnya melalui properti `item.page` pada `ItemCard`:

   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => destination),
   );
   ```

   Dengan begitu `MyHomePage` tetap berada di bawah formulir dan tombol back bawaan perangkat kembali ke menu utama. Jika memakai `pushReplacement()`, halaman menu ikut dibuang sehingga tombol back akan keluar dari aplikasi.

   Opsi Home di drawer tidak membuat halaman baru. Drawer ditutup lebih dulu, lalu semua halaman di atas halaman pertama dibuang:

   ```dart
   final navigator = Navigator.of(context);
   navigator.pop();                                // tutup drawer
   navigator.popUntil((route) => route.isFirst);   // kembali ke Home
   ```

   `popUntil((route) => route.isFirst)` terus mundur sampai mencapai halaman pertama di stack. Jadi baik drawer dibuka dari halaman menu maupun dari halaman formulir, pengguna selalu kembali ke `MyHomePage` yang sama, bukan halaman baru yang dibuat ulang.

2. **Peran susunan `Scaffold`, `AppBar`, dan `Drawer` dalam menjaga konsistensi, beserta contoh warna tema yang dipakai di lebih dari satu halaman.**

   `Scaffold` menyediakan slot tetap (`appBar`, `drawer`, `body`), jadi semua halaman punya kerangka yang sama: judul di atas, tombol menu di kiri, dan isi di tengah. `AppBar` pada `MyHomePage`, `ProjectFormPage`, dan `ExperienceFormPage` memakai konfigurasi yang sama, yaitu teks putih tebal dengan latar warna tema:

   ```dart
   appBar: AppBar(
     title: const Text(
       'Add Experience',
       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
     ),
     backgroundColor: Theme.of(context).colorScheme.primary, // #EB1000
     foregroundColor: Colors.white,
   ),
   ```

   `LeftDrawer` dipasang sebagai `drawer` pada halaman menu dan kedua halaman formulir, jadi pilihan Home, Add Project, dan Add Experience selalu tersedia di mana pun pengguna berada. Karena drawer berupa satu widget di `lib/widgets/left_drawer.dart`, menambah satu opsi cukup dilakukan sekali dan langsung berlaku di semua halaman.

   Contoh warna tema yang dipakai lebih dari satu halaman adalah `Theme.of(context).colorScheme.primary` (`#EB1000`, token `--accent` dari `static/css/style.css`). Warna yang sama menjadi latar `AppBar` halaman menu, halaman form proyek, dan halaman form pengalaman, sehingga perpindahan halaman tidak terasa seperti berpindah aplikasi.

3. **Alasan pemilihan tata letak formulir serta peran widget pengatur jarak dan widget penggulir saat ruang layar terbatas.**

   Formulir disusun sebagai `Form` → `SingleChildScrollView` → `Column`. `Column` dipilih karena field tersusun satu per satu dari atas ke bawah dan jumlahnya tetap. `SingleChildScrollView` diperlukan karena tinggi total field bisa melebihi tinggi layar, terutama di ponsel atau saat keyboard muncul:

   ```dart
   Form(
     key: _formKey,
     child: SingleChildScrollView(
       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
       padding: const EdgeInsets.all(16.0),
       child: Column(...),
     ),
   )
   ```

   `SizedBox(height: 16.0)` memberi jarak antar-field agar pesan error tidak menempel pada field berikutnya, sedangkan `Padding` menjaga isi form tidak menempel ke tepi layar. `SizedBox(height: 32.0)` di bagian paling bawah memberi ruang tambahan supaya tombol Save tidak mepet ke tepi layar dan lebih mudah dijangkau saat form digulir.

   Tanpa penggulir, ruang layar yang tersisa mengecil saat keyboard muncul, sehingga `Column` bisa melebihi tinggi yang tersedia dan memunculkan error `RenderFlex overflowed`. Dengan `SingleChildScrollView`, seluruh isi termasuk tombol Save tetap dapat dijangkau dengan menggeser, dan `keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag` membuat keyboard bisa ditutup hanya dengan menggeser form.

4. **Peran `GlobalKey<FormState>`, validator, dan `validate()` saat tombol Simpan ditekan, beserta contoh nilai yang ditolak dan alasan jenis input saja tidak cukup.**

   `GlobalKey<FormState>` dipakai untuk mengakses state dari widget `Form`. Lewat key ini, tombol Simpan bisa memanggil `validate()` untuk memeriksa semua field di dalam form sekaligus. Validator adalah fungsi yang mengembalikan pesan kesalahan (string) bila isian tidak memenuhi aturan, atau `null` bila valid. Saat `validate()` dipanggil, Flutter menjalankan semua validator, menampilkan pesan error di bawah field yang bermasalah, dan mengembalikan `false` bila ada yang gagal:

   ```dart
   void _submit() {
     if (!_formKey.currentState!.validate()) return; // dialog tidak dibuka
     showDialog(...); // hanya berjalan jika semua field valid
   }
   ```

   Contoh nilai yang ditolak adalah judul berisi spasi saja (`"   "`). Validator memakai `value.trim().isEmpty`, jadi spasi tidak dianggap sebagai isian. Contoh lain, judul `"ab"` ditolak karena kurang dari 3 karakter (aturan yang sama dengan `clean_title` pada `ExperienceForm` Django), thumbnail `"bukan url"` ditolak karena bukan path `/static/` dan, setelah diparse dengan `Uri.tryParse`, skemanya bukan `http` atau `https`, dan tahun `1900` ditolak karena berada di luar rentang `1950` sampai `DateTime.now().year + 5`.

   Memilih jenis input atau papan ketik saja belum cukup. `keyboardType: TextInputType.url` atau `TextInputType.number` hanya mengubah tampilan papan ketik pada perangkat sentuh. Pengguna tetap bisa menempel teks dari clipboard, memakai papan ketik fisik, atau mengisi lewat autofill, dan papan ketik tidak dapat menolak string kosong atau spasi. Karena itu aturan data tetap harus ditulis di `validator`, sedangkan `keyboardType` hanya berfungsi sebagai kemudahan memasukkan data.

### Assignment 9

1. **Mengapa memakai `@JsonSerializable(fieldRename: FieldRename.snake)` dan `@JsonKey(includeToJson: false)` alih-alih `Map<String, dynamic>` mentah?**

   `Map<String, dynamic>` tidak punya tipe maupun nama field yang tetap, sehingga kesalahan baru terlihat setelah request dikirim. Pada form Experience, tahun diambil dari `TextEditingController`, jadi nilainya `String`. Kalau payload disusun manual sebagai `{'year': _yearController.text}`, Django membalas `400 "A valid integer is required."` karena serializer mengharapkan integer. Dengan `Experience.year` bertipe `int`, kesalahan seperti ini tertangkap analyzer sebelum aplikasi dijalankan.

   `fieldRename: FieldRename.snake` menjaga satu konvensi: Dart memakai `starCount`, JSON memakai `star_count`. Tanpa itu, `starCount` akan dikirim dan diabaikan serializer, atau `star_count` dari server gagal dibaca. `@JsonKey(includeToJson: false)` pada `id`, `star_count`, `is_starred`, dan `starred_by_names` memastikan field yang dikelola server tidak ikut terkirim. Bug yang dicegah: payload berisi `"id": null` saat membuat entri baru; pada endpoint yang tidak menandai `id` read-only, nilai null bisa menimpa data atau memicu validasi yang membingungkan. `toJson()` hasil generate juga menjadi satu-satunya tempat yang perlu diubah bila nama field backend berubah.

2. **Mengapa Future diinisialisasi di `initState()`, dan mengapa `ApiClient` melempar `ApiException` daripada mengembalikan `null`?**

   `build()` bisa dijalankan berkali-kali: `setState`, perubahan tema, keyboard muncul, rotasi layar, atau `notifyListeners()` dari `AuthState`. Kalau `_experiencesFuture = api.getExperiences()` ditulis di dalam `build()`, setiap rebuild membuat Future baru, `FutureBuilder` kembali ke status `waiting`, dan aplikasi mengirim request berulang-ulang ke Django. `initState()` hanya berjalan sekali per `State`, jadi request pertama terjadi sekali; pemuatan ulang dilakukan eksplisit lewat `RefreshIndicator` dan tombol Retry.

   Mengembalikan `null` pada respons non-2xx membuat "daftar kosong" dan "gagal memuat" terlihat sama. Akibatnya `snapshot.hasError` tidak pernah bernilai true, UI error + Retry tidak bisa dibedakan dari kondisi kosong, dan status `401`/`403` tidak bisa ditangani khusus. Dengan melempar `ApiException(statusCode, body)`, pemanggil bisa memutuskan: `400` berarti data ditolak, `401`/`403` berarti sesi berakhir sehingga `AuthState.logout()` dijalankan, dan exception jaringan ditangani terpisah dengan pesan "Tidak dapat menghubungi server". Stack trace juga tetap utuh sehingga lebih mudah didiagnosis.

3. **SessionAuthentication vs TokenAuthentication.**

   `SessionAuthentication` bekerja dengan cookie `sessionid` yang dibuat Django saat login web, ditambah token CSRF untuk request yang mengubah data. Sesi disimpan di server dan terikat pada browser. Pola ini cocok untuk halaman HTML dan Django Admin, tetapi tidak praktis untuk aplikasi mobile: tidak ada cookie jar dan alur CSRF bawaan, sesi mudah hilang saat aplikasi ditutup, dan satu cookie tidak bisa dipakai beberapa perangkat sekaligus dengan aman.

   `TokenAuthentication` mengirim kredensial lewat header `Authorization: Token <key>`. Server tidak menyimpan state sesi, token bisa dicabut kapan saja dengan menghapus baris `Token` di database, dan setiap klien bisa punya token sendiri. Karena itu `myportofolio_mobile` memakai TokenAuthentication. `SessionAuthentication` tetap diaktifkan pada `DEFAULT_AUTHENTICATION_CLASSES` karena website Django dari Assignment 2–5 dan Django Admin masih memakai login berbasis sesi. DRF mencoba autentikator sesuai urutan, sehingga kedua jenis klien dapat memakai endpoint yang sama tanpa saling mengganggu.

4. **Peran job `build` dan `build_apk`, dan mengapa `*.g.dart` di-ignore padahal CI membutuhkannya.**

   Job `build` memanggil reusable workflow `very_good_workflows/flutter_package.yml@v2`. Di balik layar workflow tersebut melakukan checkout, memasang Flutter, `flutter pub get`, menjalankan `setup` (di proyek ini `dart run build_runner build`), memeriksa format (`dart format --set-exit-if-changed`), menjalankan `flutter analyze`, lalu `flutter test` beserta coverage dan batas `min_coverage`. Job ini adalah gerbang kualitas: kalau format, analyzer, atau test gagal, pipeline berhenti.

   Job `build_apk` memakai `needs: build`, sehingga hanya berjalan setelah seluruh pemeriksaan lolos. Job ini mengulang `flutter pub get` dan `build_runner` (runner kedua tidak mewarisi hasil job pertama), menjalankan `flutter build apk --release`, lalu mengunggah `build/app/outputs/flutter-apk/app-release.apk` sebagai artefak `app-release-apk` yang bisa diunduh dari halaman Actions.

   `*.g.dart` adalah artefak hasil generate yang isinya ditentukan sepenuhnya oleh sumber `.dart` dan versi `build_runner`/`json_serializable`. Menyimpannya di Git membuat diff penuh kode hasil generate setiap kali model berubah, memicu konflik merge, dan berisiko tidak sinkron dengan sumbernya. Karena itu file tersebut di-ignore, dan CI membuatnya ulang lewat input `setup`. `analysis_options.yaml` juga mengecualikannya agar analyzer tidak melaporkan masalah dari kode yang tidak ditulis manual.