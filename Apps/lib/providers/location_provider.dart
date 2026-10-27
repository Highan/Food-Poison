import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationState {
  final bool isLoading;
  final Position? position;
  final String? error;

  const LocationState({
    this.isLoading = false,
    this.position,
    this.error,
  });
}

class LocationNotifier extends Notifier<LocationState> {
  @override
  LocationState build() {
    return const LocationState();
  }

  Future<void> getCurrentLocation() async {
    state = const LocationState(isLoading: true);

    try {
      bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        state = const LocationState(
          error: 'GPS/Lokasi sedang tidak aktif',
        );
        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        state = const LocationState(
          error: 'Izin lokasi ditolak',
        );
        return;
      }

      if (permission ==
          LocationPermission.deniedForever) {
        state = const LocationState(
          error: 'Izin lokasi ditolak permanen',
        );
        return;
      }

      final position =
          await Geolocator.getCurrentPosition();

      state = LocationState(
        isLoading: false,
        position: position,
      );
    } catch (e) {
      state = const LocationState(
        error: 'Gagal mendapatkan lokasi',
      );
    }
  }
}

final locationProvider =
    NotifierProvider<LocationNotifier, LocationState>(
  LocationNotifier.new,
);
