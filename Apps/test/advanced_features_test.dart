import 'package:flutter_test/flutter_test.dart';

/// =======================================================
/// FAKE AUTHENTICATION SERVICE
/// =======================================================

class FakeAuthService {
  bool isLoggedIn = false;

  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email dan password wajib diisi');
    }

    if (email == 'user@test.com' && password == '123456') {
      isLoggedIn = true;
      return true;
    }

    throw Exception('Email atau password salah');
  }

  Future<void> logout() async {
    isLoggedIn = false;
  }
}

/// =======================================================
/// FAKE CAMERA SERVICE
/// =======================================================

class FakeCameraService {
  bool permissionGranted;
  bool userCancelled;

  FakeCameraService({
    this.permissionGranted = true,
    this.userCancelled = false,
  });

  Future<String?> takePhoto() async {
    if (!permissionGranted) {
      throw Exception('Camera permission denied');
    }

    if (userCancelled) {
      return null;
    }

    return 'food_photo.jpg';
  }
}

/// =======================================================
/// FAKE LOCATION SERVICE
/// =======================================================

class FakeLocationService {
  bool permissionGranted;
  bool serviceEnabled;

  FakeLocationService({
    this.permissionGranted = true,
    this.serviceEnabled = true,
  });

  Future<String> getLocation() async {
    if (!serviceEnabled) {
      throw Exception('Location service disabled');
    }

    if (!permissionGranted) {
      throw Exception('Location permission denied');
    }

    return 'Jakarta';
  }
}

/// =======================================================
/// TEST
/// =======================================================

void main() {
  group('Advanced Features Test', () {

    // =====================================================
    // 1. AUTHENTICATION
    // =====================================================

    test('Authentication - login berhasil', () async {
      final auth = FakeAuthService();

      final result = await auth.login(
        'user@test.com',
        '123456',
      );

      expect(result, true);
      expect(auth.isLoggedIn, true);
    });

    test('Authentication - login gagal', () async {
      final auth = FakeAuthService();

      expect(
        () => auth.login(
          'wrong@test.com',
          'wrongpassword',
        ),
        throwsException,
      );

      expect(auth.isLoggedIn, false);
    });

    test('Authentication - logout berhasil', () async {
      final auth = FakeAuthService();

      await auth.login(
        'user@test.com',
        '123456',
      );

      expect(auth.isLoggedIn, true);

      await auth.logout();

      expect(auth.isLoggedIn, false);
    });

    // =====================================================
    // 2. CAMERA
    // =====================================================

    test('Camera - mengambil foto berhasil', () async {
      final camera = FakeCameraService();

      final result = await camera.takePhoto();

      expect(result, 'food_photo.jpg');
    });

    test('Camera - permission ditolak', () async {
      final camera = FakeCameraService(
        permissionGranted: false,
      );

      expect(
        () => camera.takePhoto(),
        throwsException,
      );
    });

    test('Camera - user membatalkan pengambilan foto', () async {
      final camera = FakeCameraService(
        userCancelled: true,
      );

      final result = await camera.takePhoto();

      expect(result, isNull);
    });

    // =====================================================
    // 3. LOCATION
    // =====================================================

    test('Location - mendapatkan lokasi berhasil', () async {
      final location = FakeLocationService();

      final result = await location.getLocation();

      expect(result, 'Jakarta');
    });

    test('Location - permission ditolak', () async {
      final location = FakeLocationService(
        permissionGranted: false,
      );

      expect(
        () => location.getLocation(),
        throwsException,
      );
    });

    test('Location - service lokasi tidak aktif', () async {
      final location = FakeLocationService(
        serviceEnabled: false,
      );

      expect(
        () => location.getLocation(),
        throwsException,
      );
    });
  });
}
