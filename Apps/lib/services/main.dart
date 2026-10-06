import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/food_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    const ProviderScope(
      child: FoodPoisonApp(),
    ),
  );
}

class FoodPoisonApp extends StatelessWidget {
  const FoodPoisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Poison',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const FoodListScreen(),
    );
  }
}