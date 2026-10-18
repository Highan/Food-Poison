import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:food_poison/repositories/booking_repository.dart';

void main() {
  group('Booking API Test', () {

    test('API sukses', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {
              'id': '1',
              'foodId': 'F001',
              'foodName': 'Nasi Ayam',
              'customerName': 'Budi',
              'phone': '08123456789',
              'quantity': 2,
            }
          ]),
          200,
        );
      });

      final repository = BookingRepository(
        baseUrl: 'http://test',
        client: client,
      );

      final result = await repository.getBookings();

      expect(result.length, 1);
      expect(result.first.foodName, 'Nasi Ayam');
    });

    test('Data kosong', () async {
      final client = MockClient((request) async {
        return http.Response('[]', 200);
      });

      final repository = BookingRepository(
        baseUrl: 'http://test',
        client: client,
      );

      final result = await repository.getBookings();

      expect(result, isEmpty);
    });

    test('HTTP gagal', () async {
      final client = MockClient((request) async {
        return http.Response(
          '{"message":"Server Error"}',
          500,
        );
      });

      final repository = BookingRepository(
        baseUrl: 'http://test',
        client: client,
      );

      expect(
        () => repository.getBookings(),
        throwsException,
      );
    });

    test('JSON rusak', () async {
      final client = MockClient((request) async {
        return http.Response(
          '{invalid-json',
          200,
        );
      });

      final repository = BookingRepository(
        baseUrl: 'http://test',
        client: client,
      );

      expect(
        () => repository.getBookings(),
        throwsFormatException,
      );
    });
  });
}