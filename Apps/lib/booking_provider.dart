import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/food_repository.dart';

final bookingProvider =
    NotifierProvider<BookingNotifier, BookingState>(
  BookingNotifier.new,
);

class BookingState {
  final bool isSubmitting;
  final bool success;
  final String? errorMessage;

  const BookingState({
    this.isSubmitting = false,
    this.success = false,
    this.errorMessage,
  });

  BookingState copyWith({
    bool? isSubmitting,
    bool? success,
    String? errorMessage,
  }) {
    return BookingState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      success: success ?? this.success,
      errorMessage: errorMessage,
    );
  }
}

class BookingNotifier extends Notifier<BookingState> {
  @override
  BookingState build() {
    return const BookingState();
  }

  Future<void> submitBooking({
    required String foodId,
    required String customerName,
    required String phone,
    required int quantity,
  }) async {
    // Mencegah double tap
    if (state.isSubmitting) return;

    state = const BookingState(isSubmitting: true);

    try {
      await FoodRepository().createBooking(
        foodId: foodId,
        customerName: customerName,
        phone: phone,
        quantity: quantity,
      );

      state = const BookingState(
        isSubmitting: false,
        success: true,
      );
    } catch (e) {
      state = BookingState(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const BookingState();
  }
}