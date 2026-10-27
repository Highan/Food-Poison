import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraState {
  final bool isLoading;
  final XFile? image;
  final String? error;

  const CameraState({
    this.isLoading = false,
    this.image,
    this.error,
  });
}

class CameraNotifier extends Notifier<CameraState> {
  final ImagePicker _picker = ImagePicker();

  @override
  CameraState build() {
    return const CameraState();
  }

  Future<void> takePhoto() async {
    state = const CameraState(isLoading: true);

    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
      );

      // User membatalkan kamera.
      if (image == null) {
        state = const CameraState();
        return;
      }

      state = CameraState(
        isLoading: false,
        image: image,
      );
    } catch (e) {
      state = const CameraState(
        error: 'Gagal mengambil foto',
      );
    }
  }

  void clearImage() {
    state = const CameraState();
  }
}

final cameraProvider =
    NotifierProvider<CameraNotifier, CameraState>(
  CameraNotifier.new,
);
