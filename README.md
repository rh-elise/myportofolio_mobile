Nama : Rheina Uliana

NPM : 2506600801

Kelas : PBP A

# My Portfolio Mobile

Aplikasi mobile portofolio pribadi yang dibangun menggunakan **Flutter** dan **Dart**. Proyek ini merupakan pasangan mobile dari website portofolio Django [myportofolio](https://github.com/rh-elise/myportofolio), sehingga identitas visualnya dibuat senada dengan website: aksen merah dan warna ink hitam.

Proyek ini dikerjakan bertahap mengikuti Tutorial dan Individual Assignment mata kuliah Pemrograman Berbasis Platform. Pada tahap ini aplikasi masih berupa halaman menu statis yang menampilkan identitas pemilik portofolio beserta tombol-tombol aksi utama.

## Fitur yang Sudah Ada

- **Kartu identitas (InfoCard):** menampilkan NPM, nama, dan kelas pemilik portofolio.
- **Kartu aksi (ItemCard):** tiga tombol menu portofolio dalam bentuk kartu berikon.
- **Umpan balik interaktif:** setiap tombol memunculkan `SnackBar` sebagai konfirmasi aksi.
- **Tema warna kustom:** palet merah dan ink yang mengikuti desain website portofolio Django.
- **Struktur modular:** halaman utama dipisahkan ke `lib/menu.dart`, sementara `lib/main.dart` hanya berisi bootstrap aplikasi.

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
| `ItemHomepage` | Model data sederhana yang merepresentasikan satu tombol menu (nama dan ikon). |
| `ItemCard` | Widget kartu tombol yang menampilkan ikon dan nama item, serta memunculkan `SnackBar` saat ditekan. |

## Mengubah Data Portofolio

Seluruh data yang ditampilkan berada di `lib/menu.dart` pada kelas `MyHomePage`:

```dart
final String npm = "2506600801";
final String name = "Rheina Uliana";
final String className = "PBP A";

final List<ItemHomepage> items = [
  ItemHomepage("View Projects", Icons.folder),
  ItemHomepage("Add Project", Icons.add_circle),
  ItemHomepage("Logout", Icons.logout),
];
```

Untuk menambah tombol baru, cukup tambahkan satu entri `ItemHomepage` pada list `items`; `GridView.count` akan menyesuaikan tata letaknya secara otomatis.

## Progres Mingguan

| Tahap | Topik | Status |
| --- | --- | --- |
| Tutorial 08 | Basic Flutter: setup proyek, pemisahan `menu.dart`, `InfoCard`, `ItemCard`, `SnackBar` | Selesai |
| Tugas 7 (IA7) | Personalisasi data pemilik portofolio, warna tiap tombol aksi, dokumentasi dan refleksi | Sedang dikerjakan |

---

## Pengungkapan Penggunaan AI (AI Disclosure)

<!--
  BAGIAN INI MASIH PERLU DIISI SEBELUM DIKUMPULKAN.
  Rubrik IA7 memberi bobot 10% untuk dokumentasi + AI disclosure, jadi bagian kosong
  akan menurunkan nilai. Gunakan kerangka di bawah dan sesuaikan dengan proses
  pengerjaan yang benar-benar dilakukan.
-->

### Tools yang Digunakan

- _(isi: misalnya OpenCode, ChatGPT, GitHub Copilot, dan lain-lain)_

### Strategi Prompting

- _(isi: jenis konteks yang diberikan ke AI, misalnya potongan kode, traceback, atau screenshot; serta jenis permintaan seperti debugging, penjelasan konsep, atau review)_

### Bagian yang Dibantu AI

- _(isi: bagian spesifik, misalnya penulisan `InfoCard`/`ItemCard`, penyesuaian tema warna, perbaikan error analyzer, atau penyusunan README)_

### Keterbatasan AI yang Ditemui

- _(isi: bagian yang saran AI-nya tidak sesuai dengan struktur proyek atau harus diperbaiki manual)_

### Perbaikan Manual yang Dilakukan

- _(isi: perubahan yang dikerjakan sendiri tanpa bantuan AI)_

### Log Obrolan AI

1. _(isi: tautan atau lampiran log percakapan)_

---

## Pertanyaan Reflektif

<!--
  BAGIAN INI MASIH PERLU DIISI SEBELUM DIKUMPULKAN.
  Tulis jawaban langsung di bawah setiap pertanyaan dengan format penomoran
  seperti di bawah agar konsisten seiring bertambahnya tugas.
-->

### Tugas 7

1. **Widget tree pada Flutter dan hubungan parent-child antar-widget**

   _(jawaban)_

2. **Daftar seluruh widget yang digunakan dalam proyek ini beserta fungsinya**

   _(jawaban)_

3. **Fungsi `MaterialApp` dan alasan widget ini digunakan sebagai root widget**

   _(jawaban)_

4. **Perbedaan `StatelessWidget` dan `StatefulWidget`, serta kapan memilih masing-masing**

   _(jawaban)_

5. **Pengertian `BuildContext` dan pentingnya dalam Flutter, termasuk penggunaannya di dalam metode `build`**

   _(jawaban)_

6. **Konsep hot reload, perbedaannya dengan hot restart, dan kapan hot reload tidak lagi cukup**

   _(jawaban)_
