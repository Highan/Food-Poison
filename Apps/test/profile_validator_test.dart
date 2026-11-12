import 'package:flutter_test/flutter_test.dart';
import 'package:food_poison/validators/profile_validator.dart';

void main() {
  group('ProfileValidator Test', () {
    test('Nama kosong harus gagal', () {
      expect(
        ProfileValidator.validateName(''),
        'Nama tidak boleh kosong',
      );
    });

    test('Nama kurang dari 3 karakter harus gagal', () {
      expect(
        ProfileValidator.validateName('AB'),
        'Nama minimal 3 karakter',
      );
    });

    test('Nama valid harus berhasil', () {
      expect(
        ProfileValidator.validateName('Michael'),
        null,
      );
    });

    test('Email tidak valid harus gagal', () {
      expect(
        ProfileValidator.validateEmail('email-salah'),
        'Format email tidak valid',
      );
    });

    test('Email valid harus berhasil', () {
      expect(
        ProfileValidator.validateEmail('test@gmail.com'),
        null,
      );
    });
  });
}
