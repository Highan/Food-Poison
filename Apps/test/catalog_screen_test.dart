import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_poison/screens/catalog_screen.dart';
import 'package:food_poison/providers/food_provider.dart';
import 'package:food_poison/models/food_model.dart';
import 'package:food_poison/repositories/food_repository.dart';

class FakeFoodRepository implements FoodRepository {
  final List<FoodModel> foods;
  final bool shouldThrow;

  FakeFoodRepository({
    this.foods = const [],
    this.shouldThrow = false,
  });

  @override
  Future<List<FoodModel>> getFoods() async {
    if (shouldThrow) {
      throw Exception('Failed to load food');
    }

    return foods;
  }
}

void main() {
  group('CatalogScreen Widget Test', () {

    testWidgets(
      'menampilkan loading state',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: const MaterialApp(
              home: CatalogScreen(),
            ),
          ),
        );

        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'menampilkan data makanan ketika API berhasil',
      (tester) async {
        final repository = FakeFoodRepository(
          foods: [
            FoodModel(
              id: 'F001',
              name: 'Nasi Ayam',
              originalPrice: 30000,
              discountPrice: 15000,
              quota: 5,
            ),
            FoodModel(
              id: 'F002',
              name: 'Roti',
              originalPrice: 20000,
              discountPrice: 10000,
              quota: 3,
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              foodRepositoryProvider.overrideWithValue(
                repository,
              ),
            ],
            child: const MaterialApp(
              home: CatalogScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(
          find.text('Nasi Ayam'),
          findsOneWidget,
        );

        expect(
          find.text('Roti'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'menampilkan empty state ketika data kosong',
      (tester) async {
        final repository = FakeFoodRepository(
          foods: [],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              foodRepositoryProvider.overrideWithValue(
                repository,
              ),
            ],
            child: const MaterialApp(
              home: CatalogScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(
          find.text('Belum ada makanan'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'menampilkan error state ketika API gagal',
      (tester) async {
        final repository = FakeFoodRepository(
          shouldThrow: true,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              foodRepositoryProvider.overrideWithValue(
                repository,
              ),
            ],
            child: const MaterialApp(
              home: CatalogScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(
          find.text('Gagal memuat data'),
          findsOneWidget,
        );

        expect(
          find.text('Retry'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'tombol Retry dapat ditekan',
      (tester) async {
        final repository = FakeFoodRepository(
          shouldThrow: true,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              foodRepositoryProvider.overrideWithValue(
                repository,
              ),
            ],
            child: const MaterialApp(
              home: CatalogScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final retryButton = find.text('Retry');

        expect(
          retryButton,
          findsOneWidget,
        );

        await tester.tap(retryButton);

        await tester.pump();

        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
        );
      },
    );
  });
}
