import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/food_provider.dart';
import 'booking_screen.dart';

class FoodListScreen extends ConsumerWidget {
  const FoodListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foods = ref.watch(foodProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Poison'),
      ),
      body: foods.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Gagal memuat makanan'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  ref.read(foodProvider.notifier).retry();
                },
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),

        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada makanan tersedia',
              ),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final food = items[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  title: Text(food.name),
                  subtitle: Text(food.description),
                  trailing: Text(
                    'Rp ${food.price.toStringAsFixed(0)}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingScreen(
                          foodId: food.id,
                          foodName: food.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}