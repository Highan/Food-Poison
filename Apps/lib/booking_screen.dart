import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/booking_provider.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String foodId;
  final String foodName;

  const BookingScreen({
    super.key,
    required this.foodId,
    required this.foodName,
  });

  @override
  ConsumerState<BookingScreen> createState() =>
      _BookingScreenState();
}

class _BookingScreenState
    extends ConsumerState<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(bookingProvider.notifier).submitBooking(
          foodId: widget.foodId,
          customerName: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          quantity: int.parse(_quantityController.text),
        );

    if (!mounted) return;

    final state = ref.read(bookingProvider);

    if (state.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking berhasil!'),
        ),
      );

      Navigator.pop(context);
    }

    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.foodName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nomor telepon wajib diisi';
                  }

                  if (value.length < 10) {
                    return 'Nomor telepon tidak valid';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Jumlah wajib diisi';
                  }

                  final quantity = int.tryParse(value);

                  if (quantity == null || quantity <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      bookingState.isSubmitting
                          ? null
                          : _submit,
                  child: bookingState.isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}