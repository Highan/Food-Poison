import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_model.dart';

class FoodRepository {
  final FirebaseFirestore firestore;

  FoodRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<FoodModel>> getFoods() async {
    final snapshot = await firestore
        .collection('foods')
        .where('isActive', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => FoodModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> createBooking({
    required String foodId,
    required String customerName,
    required String phone,
    required int quantity,
  }) async {
    await firestore.collection('bookings').add({
      'foodId': foodId,
      'customerName': customerName,
      'phone': phone,
      'quantity': quantity,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}