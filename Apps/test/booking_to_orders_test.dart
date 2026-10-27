import 'package:flutter_test/flutter_test.dart';

class Booking {
  final String id;
  final String foodId;
  final String foodName;
  final String customerName;
  final int quantity;

  Booking({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.customerName,
    required this.quantity,
  });
}

class Order {
  final String id;
  final String foodId;
  final String foodName;
  final String customerName;
  final int quantity;
  final String status;

  Order({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.customerName,
    required this.quantity,
    required this.status,
  });
}

Order bookingToOrder(Booking booking) {
  if (booking.quantity <= 0) {
    throw ArgumentError('Quantity harus lebih dari 0');
  }

  if (booking.customerName.trim().isEmpty) {
    throw ArgumentError('Customer name tidak boleh kosong');
  }

  return Order(
    id: 'ORDER-${booking.id}',
    foodId: booking.foodId,
    foodName: booking.foodName,
    customerName: booking.customerName,
    quantity: booking.quantity,
    status: 'pending',
  );
}

void main() {
  group('Booking to Order Test', () {

    test('Booking berhasil dibuat menjadi Order', () {
      final booking = Booking(
        id: 'B001',
        foodId: 'F001',
        foodName: 'Nasi Ayam',
        customerName: 'Budi',
        quantity: 2,
      );

      final order = bookingToOrder(booking);

      expect(order.id, 'ORDER-B001');
      expect(order.foodId, 'F001');
      expect(order.foodName, 'Nasi Ayam');
      expect(order.customerName, 'Budi');
      expect(order.quantity, 2);
      expect(order.status, 'pending');
    });

    test('Booking dengan quantity 0 ditolak', () {
      final booking = Booking(
        id: 'B002',
        foodId: 'F001',
        foodName: 'Nasi Ayam',
        customerName: 'Budi',
        quantity: 0,
      );

      expect(
        () => bookingToOrder(booking),
        throwsArgumentError,
      );
    });

    test('Booking dengan customer kosong ditolak', () {
      final booking = Booking(
        id: 'B003',
        foodId: 'F001',
        foodName: 'Nasi Ayam',
        customerName: '',
        quantity: 1,
      );

      expect(
        () => bookingToOrder(booking),
        throwsArgumentError,
      );
    });

    test('Status Order awal adalah pending', () {
      final booking = Booking(
        id: 'B004',
        foodId: 'F002',
        foodName: 'Roti',
        customerName: 'Andi',
        quantity: 1,
      );

      final order = bookingToOrder(booking);

      expect(order.status, 'pending');
    });

    test('Data Booking tetap sama setelah menjadi Order', () {
      final booking = Booking(
        id: 'B005',
        foodId: 'F003',
        foodName: 'Sandwich',
        customerName: 'Citra',
        quantity: 3,
      );

      final order = bookingToOrder(booking);

      expect(order.foodId, booking.foodId);
      expect(order.foodName, booking.foodName);
      expect(order.customerName, booking.customerName);
      expect(order.quantity, booking.quantity);
    });
  });
}
