import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking_model.dart';

class BookingRepository {
  final String baseUrl;

  BookingRepository({required this.baseUrl});

  Future<List<BookingModel>> getBookings() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/bookings'),
    );

    if (response.statusCode != 200) {
      throw Exception('HTTP Error: ${response.statusCode}');
    }

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is! List) {
        throw const FormatException('Response is not a list');
      }

      return decoded
          .map(
            (item) => BookingModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    } catch (_) {
      throw const FormatException('Invalid JSON response');
    }
  }

  Future<BookingModel> createBooking(
    BookingModel booking,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/bookings'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception('HTTP Error: ${response.statusCode}');
    }

    try {
      final decoded = jsonDecode(response.body);

      return BookingModel.fromJson(
        Map<String, dynamic>.from(decoded),
      );
    } catch (_) {
      throw const FormatException('Invalid JSON response');
    }
  }
}