Untuk Food Poison, supaya tugas ini memenuhi seluruh requirement dan mudah didemokan ke reviewer, saya sarankan memilih 3 advanced feature yang paling relevan:
1. Autentikasi — Firebase Authentication
2. Kamera — mengambil foto makanan
3. Lokasi — menampilkan lokasi merchant
Alurnya menjadi:
Login/Register
      ↓
Dashboard
      ↓
Daftar Surplus Food
      ↓
Detail Food
      ↓
Booking
      ↓
Form + Validasi
      ↓
Kamera ← foto makanan
      ↓
Lokasi ← lokasi merchant
      ↓
Simpan Booking
      ↓
Booking berhasil

Struktur final
lib/
├── main.dart
├── app.dart
│
├── models/
│   ├── user_model.dart
│   ├── food_model.dart
│   └── booking_model.dart
│
├── repositories/
│   ├── auth_repository.dart
│   ├── food_repository.dart
│   └── booking_repository.dart
│
├── providers/
│   ├── auth_provider.dart
│   ├── food_provider.dart
│   └── booking_provider.dart
│
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── dashboard_screen.dart
│   ├── detail_screen.dart
│   ├── booking_screen.dart
│   └── profile_screen.dart
│
├── services/
│   ├── camera_service.dart
│   └── location_service.dart
│
└── widgets/
    ├── primary_button.dart
    ├── app_text_field.dart
    ├── food_card.dart
    └── loading_widget.dart

1. Advanced Feature — Autentikasi
Gunakan Firebase Authentication.
Alur
Login
 ↓
Firebase Auth
 ↓
Berhasil → Dashboard
Gagal → Error message

Yang harus ada:
- Login
- Register
- Logout
- Loading saat login
- Error jika email/password salah
- Validasi form
- Session tetap tersimpan
Manfaat: pengguna memiliki akun sehingga booking dapat dikaitkan dengan identitas pengguna dan data lebih aman.
2. Advanced Feature — Kamera
Kamera digunakan ketika merchant/user ingin mengambil foto makanan.

Dependency:
dependencies:
  image_picker: ^1.1.2

Contoh:
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> takePhoto() async {
    return await _picker.pickImage(
      source: ImageSource.camera,
    );
  }
}

UI:
final photo = await cameraService.takePhoto();

if (photo != null) {
  setState(() {
    selectedPhoto = photo;
  });
}

Jika user membatalkan kamera:
if (photo == null) {
  // User membatalkan kamera
  return;
}

Manfaat: merchant dapat memberikan foto aktual makanan sehingga buyer lebih mudah mengetahui kondisi makanan sebelum melakukan booking.
3. Advanced Feature — Lokasi
Gunakan geolocator.
dependencies:
  geolocator: ^14.0.2

Service:
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location service disabled');
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }

    if (permission ==
        LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}

UI harus menangani:
Location Loading
       ↓
Request Permission
       ↓
 ┌───────────────┐
 │ Allow         │ → tampilkan lokasi
 │ Deny          │ → tampilkan error
 │ Cancel/Back   │ → kembali tanpa lokasi
 │ GPS disabled  │ → tampilkan pesan
 └───────────────┘

Manfaat: buyer dapat mengetahui lokasi merchant dan memperkirakan tempat pengambilan makanan.
Loading, Empty, Error
Semua fitur utama harus mempunyai state yang jelas.
Food List
Loading
   ↓
API
   ├── Success → Food Card
   ├── Empty → "Belum ada makanan"
   └── Error → "Gagal memuat data" + Retry

Booking
Form
 ↓
Validation
 ├── Invalid → pesan error
 └── Valid
      ↓
 Submit Loading
      ↓
 API
      ├── Success → Booking berhasil
      └── Error → Retry

Kamera
Request Camera
 ↓
Permission
 ├── Granted → Camera
 ├── Denied → Error
 └── Cancel → kembali ke form

Lokasi
Request Location
 ↓
Permission
 ├── Granted → Location
 ├── Denied → Error
 └── GPS disabled → Inform user

Checklist Reviewer
Reviewer bisa mengecek langsung bagian berikut:
Fitur	Lokasi kode	Yang dicek
Autentikasi	repositories/auth_repository.dart	Login/Register/Logout bekerja
Camera	services/camera_service.dart	Kamera terbuka dan foto dapat diambil
Location	services/location_service.dart	Permission dan lokasi bekerja
Navigasi	app.dart, routes/	Login → Dashboard → Detail → Booking
Form	booking_screen.dart	Input dapat diisi
Validasi	booking_screen.dart / provider	Input invalid ditolak
API	repositories/	Data dikirim/diambil Backend
Persistence	repositories/	Data tersimpan
Loading	providers/ + UI	Loading ditampilkan
Empty	UI	Empty state ditampilkan
Error	UI/provider	Error ditampilkan
Retry	UI/provider	Request dapat diulang
