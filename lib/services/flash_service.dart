import 'package:torch_light/torch_light.dart';

class FlashService {
  static Future<void> setFlash(bool on) async {
    try {
      if (on) {
        await TorchLight.enableTorch();
      } else {
        await TorchLight.disableTorch();
      }
    } catch (_) {}
  }
}
