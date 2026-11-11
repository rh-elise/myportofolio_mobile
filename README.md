Nama : Rheina Uliana

NPM : 2506600801

Kelas : PBP A

# My Portfolio Mobile

Aplikasi mobile portofolio pribadi yang dibangun menggunakan **Flutter** dan **Dart**. Proyek ini merupakan pasangan mobile dari website portofolio Django [myportofolio](https://github.com/rh-elise/myportofolio), dan memakai design system yang sama dengan website tersebut.

Proyek ini dikerjakan bertahap mengikuti Tutorial dan Individual Assignment mata kuliah Pemrograman Berbasis Platform. Pada tahap ini aplikasi masih berupa halaman menu statis yang menampilkan identitas pemilik portofolio beserta tombol-tombol aksi utama.

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

Aplikasi mobile ini disiapkan sebagai klien mobile dari website tersebut. Pada tahap ini aplikasi baru memiliki halaman menu dengan tiga aksi utama:

- **View Projects** — nantinya membuka daftar project.
- **Add Project** — nantinya membuka form penambahan project.
- **Logout** — keluar dari sesi pengguna.

## Fitur yang Sudah Ada

- **Kartu identitas (InfoCard):** menampilkan NPM, nama, dan kelas pemilik portofolio.
- **Kartu aksi (ItemCard):** tiga tombol menu portofolio dalam bentuk kartu berikon.
- **Warna per aksi:** setiap tombol memakai warna berbeda yang diambil dari design system website, tanpa percabangan `if-else`.
- **Konfirmasi aksi destruktif:** tombol Logout menampilkan dialog konfirmasi sebelum dijalankan.
- **Umpan balik interaktif:** setiap tombol memunculkan `SnackBar` mengambang dengan aksi *Dismiss*.
- **Layout responsif:** konten memakai `SafeArea` dan dapat di-*scroll*; jumlah kolom grid menyesuaikan lebar layar (3 kolom di ponsel, 4 kolom di layar lebar).
- **Struktur modular:** halaman utama dipisahkan ke `lib/menu.dart`, sementara `lib/main.dart` hanya berisi bootstrap aplikasi.

## Design System

Warna diambil langsung dari `static/css/style.css` pada repositori website agar aplikasi mobile dan website terlihat sebagai satu kesatuan.

| Token | Nilai | Pemakaian di aplikasi |
| --- | --- | --- |
| `--accent` | `#EB1000` | Tombol View Projects dan AppBar |
| `--ink` | `#151515` | Tombol Add Project |
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

### 4. Periksa Perangkat yang Tersedia

Pastikan Flutter mendeteksi target eksekusi, misalnya Chrome atau emulator Android:

```bash
flutter devices
```

### 5. Jalankan Aplikasi

Menjalankan di Google Chrome (paling ringan dan direkomendasikan untuk pengembangan awal):

```bash
flutter run -d chrome
```

Menjalankan di emulator atau perangkat Android yang sudah terhubung:

```bash
flutter run
```

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
│   ├── main.dart          # Bootstrap aplikasi: main(), MyApp, MaterialApp, dan tema
│   └── menu.dart          # Halaman utama: MyHomePage, InfoCard, ItemCard, ItemHomepage
├── test/                  # Widget test
├── android/ ios/ web/     # Berkas pembungkus native tiap platform
├── analysis_options.yaml  # Konfigurasi linter Dart
└── pubspec.yaml           # Manifes dependensi dan aset
```

Pemisahan tersebut mengikuti prinsip *separation of concerns*:

- `main.dart` hanya bertanggung jawab menjalankan aplikasi dan menyiapkan `MaterialApp` beserta temanya.
- `menu.dart` berisi seluruh komponen antarmuka halaman menu, sehingga perubahan tampilan tidak mengganggu titik masuk aplikasi.

Penjelasan komponen di `menu.dart`:

| Komponen | Peran |
| --- | --- |
| `MyHomePage` | Halaman menu utama, berupa `StatelessWidget` karena isinya tidak berubah selama aplikasi berjalan. |
| `InfoCard` | Widget kartu yang dapat digunakan ulang untuk menampilkan satu pasang judul dan isi. |
| `ItemHomepage` | Model data yang merepresentasikan satu tombol menu: nama, ikon, warna, dan penanda apakah aksi tersebut perlu konfirmasi. |
| `ItemCard` | Widget kartu tombol yang menampilkan ikon dan nama item, meminta konfirmasi bila diperlukan, lalu memunculkan `SnackBar` saat ditekan. |

## Mengubah Data Portofolio

Seluruh data yang ditampilkan berada di `lib/menu.dart` pada kelas `MyHomePage`:

```dart
final String npm = "2506600801";
final String name = "Rheina Uliana";
final String className = "PBP A";

final List<ItemHomepage> items = const [
  // Warna diambil dari design system website portofolio
  // (static/css/style.css): accent, ink, dan accent dark.
  ItemHomepage("View Projects", Icons.folder, Color(0xFFEB1000)),
  ItemHomepage("Add Project", Icons.add_circle, Color(0xFF151515)),
  ItemHomepage(
    "Logout",
    Icons.logout,
    Color(0xFF9B0A00),
    requiresConfirmation: true,
  ),
];
```

Untuk menambah tombol baru, cukup tambahkan satu entri `ItemHomepage` pada list `items`. Jumlah kolom grid akan menyesuaikan secara otomatis. Parameter `requiresConfirmation` diisi `true` hanya untuk aksi yang bersifat destruktif, seperti Logout.

## Progres Mingguan

| Tahap | Topik | Status |
| --- | --- | --- |
| Tutorial 08 | Basic Flutter: setup proyek, pemisahan `menu.dart`, `InfoCard`, `ItemCard`, `SnackBar` | Selesai |
| Tugas 7 (IA7) | Personalisasi identitas pemilik, warna aksi sesuai design system, dialog konfirmasi logout, `SnackBar` mengambang, layout responsif | Selesai |

---

## Pengungkapan Penggunaan AI (AI Disclosure)

### Pesan Singkat untuk Kak Asdos

Halo Kak! Dalam pengerjaan aplikasi mobile ini, saya menggunakan AI sebagai alat bantu untuk memeriksa kode, memahami konsep Flutter, dan merapikan dokumentasi. Saya tetap menentukan keputusan desain dan menuliskan sendiri sebagian besar perubahan pada `menu.dart`, lalu meminta AI memeriksa hasilnya.

### Strategi Prompting

Saya tidak meminta AI membuat aplikasi dari nol. Pola yang saya pakai adalah memberikan konteks terlebih dahulu, kemudian meminta AI memeriksa atau menjelaskan:

- Menempelkan isi berkas yang sedang dikerjakan (`lib/main.dart` dan `lib/menu.dart`) agar saran AI sesuai kondisi proyek, bukan contoh umum.
- Menempelkan luaran `flutter analyze` dan kutipan lembar tugas IA7, lalu meminta AI memeriksa kesesuaian kode dengan checklist.
- Menunjukkan berkas `static/css/style.css` milik website Django ketika meminta warna tombol disamakan, supaya AI bekerja berdasarkan palet yang benar-benar ada.
- Meminta penjelasan alasan suatu perubahan, bukan hanya kode jadinya, misalnya mengapa `context.mounted` perlu dicek setelah `await`.
- Meminta hasil akhir diverifikasi dengan `flutter analyze` dan `flutter test`, bukan hanya dilihat sekilas.

### Bagian yang Dibantu AI

- **Audit kesesuaian tugas:** memeriksa kode terhadap checklist IA7 dan menunjukkan bagian yang belum terpenuhi, terutama warna tombol dan teks `SnackBar`.
- **Penyusunan struktur:** saran pemisahan komponen dan penggunaan model `ItemHomepage` dengan atribut `color` agar pewarnaan tidak memakai percabangan berulang.
- **Perbaikan issue analyzer:** menemukan penyebab `prefer_const_constructors_in_immutables` yang muncul setelah list `items` dijadikan `const`, lalu menyarankan perubahan konstruktor dan pemanggilan `const MyHomePage()`.
- **Perapian format:** menjalankan `dart format` untuk memperbaiki indentasi dan baris yang terlalu panjang.
- **Dokumentasi:** menyusun kerangka `README.md` (deskripsi proyek, instruksi setup, struktur direktori) serta merapikan format penulisannya.

### Keterbatasan AI yang Ditemui

- **Konteks awal tidak lengkap:** AI sempat menyimpulkan proyek belum ada karena mencari di lokasi yang salah. Setelah saya berikan path yang benar (`C:\Kuliah\Coding\myportofolio_mobile`), barulah pemeriksaan bisa dilakukan.
- **Saran di luar design system:** pada rancangan awal, AI mengusulkan warna biru dan hijau untuk tombol. Warna itu terlihat wajar secara umum, tetapi tidak ada di palet website saya, sehingga membuat aplikasi terasa seperti proyek yang berbeda. Saya menggantinya dengan warna dari `style.css`.
- **Komentar tidak ikut diperbarui:** setelah kode diubah, masih ada komentar lama seperti "menggunakan warna sekunder dari skema tema" padahal warnanya sudah diambil dari `item.color`. Hal seperti ini harus saya periksa sendiri karena tidak terdeteksi oleh analyzer.
- **Tidak bisa menilai tampilan:** AI tidak dapat memastikan hasil akhir terlihat baik di layar. Penilaian visual tetap saya lakukan dengan menjalankan `flutter run -d chrome`.

### Perbaikan Manual yang Dilakukan

- Menuliskan sendiri perubahan pada `lib/menu.dart`: menambahkan atribut `color` dan `requiresConfirmation` pada `ItemHomepage`, mengisi tiga warna berbeda, membuat dialog konfirmasi logout, mengubah `SnackBar` menjadi mengambang dengan aksi *Dismiss*, serta membungkus body dengan `SafeArea` dan `SingleChildScrollView`.
- Mengganti warna usulan AI (biru/hijau) dengan palet dari `static/css/style.css`: `#EB1000`, `#151515`, dan `#9B0A00`.
- Memutuskan sendiri konvensi penulisan: antarmuka dan nama variabel berbahasa Inggris, sedangkan komentar kode berbahasa Indonesia.
- Memperbaiki komentar yang sudah tidak sesuai dengan kode setelah pewarnaan diubah.
- Menyesuaikan `test/widget_test.dart` agar menguji data pemilik portofolio, bukan test counter bawaan Flutter.
- Memastikan hasil akhir bersih dengan `flutter analyze` (`No issues found`) dan `flutter test` (seluruh test lulus) sebelum melakukan commit.
- Menilai tampilan akhir dengan menjalankan aplikasi di Chrome dan mencoba beberapa ukuran layar untuk memastikan grid responsif berjalan.

### Log Obrolan AI

1. [Link Chat 1](https://drive.google.com/file/d/1L1xeq2Oap1b0duCLO9IkmCyTJhP71SNh/view?usp=sharing)

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

