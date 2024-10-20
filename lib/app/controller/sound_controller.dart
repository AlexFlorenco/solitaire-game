import 'package:audioplayers/audioplayers.dart';

class SoundController {
  static Future<void> playSound(String soundPath) async {
    await AudioPlayer().play(AssetSource(soundPath));
  }
}
