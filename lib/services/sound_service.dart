import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../widgets/web_audio_player.dart';

class SoundService {
  static final SoundService instance = SoundService._();
  SoundService._();

  AudioPlayer? _mobilePlayer;
  WebAudioPlayer? _webPlayer;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    
    try {
      if (kIsWeb) {
        _webPlayer = WebAudioPlayer();
        await _webPlayer!.load('assets/audio/wrong.wav');
      } else {
        _mobilePlayer = AudioPlayer();
        final session = await AudioSession.instance;
        await session.configure(const AudioSessionConfiguration.speech());
        // For local assets in app
        await _mobilePlayer!.setAsset('assets/audio/wrong.wav');
        await _mobilePlayer!.setVolume(0.20);
      }
      _initialized = true;
    } catch (e) {
      // print('Error initializing SoundService: $e');
    }
  }

  Future<void> playWrongSound() async {
    try {
      if (!_initialized) {
        await init();
      }
      
      if (kIsWeb) {
        await _webPlayer?.play(volume: 0.20);
      } else {
        // Reset to start for replaying
        await _mobilePlayer?.seek(Duration.zero);
        await _mobilePlayer?.play();
      }
    } catch (e) {
      // print('Error playing wrong sound: $e');
      // Try to re-init if it failed
      _initialized = false;
    }
  }
  
  void dispose() {
    _mobilePlayer?.dispose();
    _webPlayer?.dispose();
  }
}
