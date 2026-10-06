import 'package:flutter/material.dart';
import 'screens/food_list_screen.dart';

class FoodPoisonApp extends StatelessWidget {
  const FoodPoisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Poison',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const FoodListScreen(),
    );
  }
}