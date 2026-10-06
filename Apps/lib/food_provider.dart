import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food_model.dart';
import '../repositories/food_repository.dart';

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepository();
});

final foodProvider =
    AsyncNotifierProvider<FoodNotifier, List<FoodModel>>(
  FoodNotifier.new,
);

class FoodNotifier extends AsyncNotifier<List<FoodModel>> {
  @override
  Future<List<FoodModel>> build() async {
    return ref.read(foodRepositoryProvider).getFoods();
  }

  Future<void> retry() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(foodRepositoryProvider).getFoods(),
    );
  }
}