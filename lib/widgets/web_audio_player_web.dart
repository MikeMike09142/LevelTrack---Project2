import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart';

class WebAudioPlayer {
  // Use AudioContext for more reliable playback of short sounds
  web.AudioContext? _audioContext;
  web.AudioBuffer? _audioBuffer;
  
  // Keep reference to prevent Garbage Collection (Critical!)
  web.AudioBufferSourceNode? _activeSource;
  
  // Backup HTML element
  web.HTMLAudioElement? _backupElement;

  Future<void> load(String assetPath) async {
    if (kIsWeb) {
      try {
        _audioContext = web.AudioContext();
        
        // Try multiple paths
        final paths = [
          assetPath,
          'assets/$assetPath',
          'assets/assets/audio/congratulations.mp3',
          'assets/audio/congratulations.mp3', 
        ];

        web.Response? response;
        String? workingPath;

        for (final path in paths) {
          try {
            final fetchPromise = web.window.fetch(path.toJS);
            response = await fetchPromise.toDart;

            if (response.ok) {
              workingPath = path;
              break;
            }
          } catch (e) {
            // Continue to next path
          }
        }

        if (workingPath == null || response == null) {
          throw Exception('Could not fetch audio from any path');
        }

        final arrayBufferPromise = response.arrayBuffer();
        final arrayBuffer = await arrayBufferPromise.toDart;

        final decodePromise = _audioContext!.decodeAudioData(arrayBuffer);
        _audioBuffer = await decodePromise.toDart;
        
        // Setup backup element
        _backupElement = web.HTMLAudioElement();
        _backupElement!.src = workingPath;
        _backupElement!.preload = 'auto';
        
      } catch (e) {
        // Silent fail in production
      }
    }
  }

  Future<void> play({double volume = 1.0}) async {
    if (kIsWeb) {
      // Strategy 1: AudioContext (Primary)
      if (_audioContext != null && _audioBuffer != null) {
        try {
          if (_audioContext!.state == 'suspended') {
            await _audioContext!.resume().toDart;
          }

          final gainNode = _audioContext!.createGain();
          gainNode.gain.value = volume;
          gainNode.connect(_audioContext!.destination);

          // Store in class member to prevent GC
          _activeSource = _audioContext!.createBufferSource();
          _activeSource!.buffer = _audioBuffer;
          _activeSource!.connect(gainNode);
          
          _activeSource!.start(_audioContext!.currentTime + 0.01);
        } catch (e) {
          // Ignore
        }
      }
      
      // Strategy 2: HTML Element (Backup)
      // This is often more reliable for simple "fire and forget" if Context fails
      if (_backupElement != null) {
        try {
          _backupElement!.volume = volume;
          _backupElement!.currentTime = 0;
          _backupElement!.play();
        } catch (e) {
          // Ignore
        }
      }
    }
  }

  void dispose() {
    if (kIsWeb) {
      try {
        _activeSource?.stop();
        _activeSource = null;
        _audioContext?.close();
        _audioContext = null;
        _backupElement = null;
      } catch (e) {
        // Ignore errors during disposal
      }
    }
  }
}
