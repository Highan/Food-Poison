import 'package:flutter_test/flutter_test.dart';
import 'package:food_poison/models/order_model.dart';

void main() {
  test('OrderModel dapat dikonversi ke JSON dan kembali', () {
    final order = OrderModel(
      id: 'ORD001',
      buyerId: 'BUY001',
      foodId: 'FOOD001',
      pickupCode: 'POISON123',
      status: 'pending',
      createdAt: DateTime.parse('2026-11-19T10:00:00.000'),
    );

    final json = order.toJson();
    final result = OrderModel.fromJson(json);

    expect(result.id, 'ORD001');
    expect(result.buyerId, 'BUY001');
    expect(result.foodId, 'FOOD001');
    expect(result.pickupCode, 'POISON123');
    expect(result.status, 'pending');
    expect(result.createdAt, order.createdAt);
  });

  test('copyWith dapat mengubah status pesanan', () {
    final order = OrderModel(
      id: 'ORD001',
      buyerId: 'BUY001',
      foodId: 'FOOD001',
      pickupCode: 'POISON123',
      status: 'pending',
      createdAt: DateTime.now(),
    );

    final updatedOrder = order.copyWith(status: 'confirmed');

    expect(updatedOrder.status, 'confirmed');
    expect(updatedOrder.id, order.id);
  });
}
