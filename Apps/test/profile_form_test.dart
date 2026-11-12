import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_poison/screens/profile/profile_form.dart';
import 'package:food_poison/repositories/profile_repository.dart';

class FakeProfileRepository extends ProfileRepository {
  FakeProfileRepository()
      : super(baseUrl: 'https://example.com');

  @override
  Future<bool> updateProfile({
    required String name,
    required String email,
  }) async {
    return true;
  }
}

void main() {
  testWidgets('ProfileForm menampilkan input dan tombol',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileForm(
            repository: FakeProfileRepository(),
          ),
        ),
      ),
    );

    expect(find.text('Nama'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Simpan Profil'), findsOneWidget);
  });

  testWidgets('Nama kosong menampilkan pesan validasi',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileForm(
            repository: FakeProfileRepository(),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Simpan Profil'));
    await tester.pump();

    expect(
      find.text('Nama tidak boleh kosong'),
      findsOneWidget,
    );
  });
}
