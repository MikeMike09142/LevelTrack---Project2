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
        print('Loading web audio from: $assetPath');
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
            print('Trying to fetch audio from: $path');
            final fetchPromise = web.window.fetch(path.toJS);
            response = await fetchPromise.toDart as web.Response;

            if (response.ok) {
              workingPath = path;
              print('Successfully fetched audio from: $path');
              break;
            }
          } catch (e) {
            print('Failed to fetch from $path');
          }
        }

        if (workingPath == null || response == null) {
          throw Exception('Could not fetch audio from any path');
        }

        final arrayBufferPromise = response.arrayBuffer();
        final arrayBuffer = await arrayBufferPromise.toDart;

        final decodePromise = _audioContext!.decodeAudioData(arrayBuffer as JSArrayBuffer);
        _audioBuffer = await decodePromise.toDart as web.AudioBuffer;
        
        // Setup backup element
        if (workingPath != null) {
          _backupElement = web.HTMLAudioElement();
          _backupElement!.src = workingPath;
          _backupElement!.preload = 'auto';
        }
        
        print('Web audio decoded successfully');
      } catch (e) {
        print('Error loading web audio: $e');
        web.window.alert('Audio Load Error: $e');
        rethrow;
      }
    }
  }

  Future<void> play() async {
    if (kIsWeb) {
      // Strategy 1: AudioContext (Primary)
      if (_audioContext != null && _audioBuffer != null) {
        try {
          print('Playing web audio via AudioContext...');
          
          if (_audioContext!.state == 'suspended') {
            await _audioContext!.resume().toDart;
          }

          final gainNode = _audioContext!.createGain();
          gainNode.gain.value = 1.0;
          gainNode.connect(_audioContext!.destination);

          // Store in class member to prevent GC
          _activeSource = _audioContext!.createBufferSource();
          _activeSource!.buffer = _audioBuffer;
          _activeSource!.connect(gainNode);
          
          _activeSource!.start(_audioContext!.currentTime + 0.01);
          print('Context playback scheduled');
        } catch (e) {
          print('Context play failed: $e');
        }
      }
      
      // Strategy 2: HTML Element (Backup)
      // This is often more reliable for simple "fire and forget" if Context fails
      if (_backupElement != null) {
        try {
          print('Playing backup audio element...');
          _backupElement!.currentTime = 0;
          _backupElement!.play();
        } catch (e) {
          print('Backup play failed: $e');
        }
      }
    }
  }

  void dispose() {
    _audioContext?.close();
    _audioContext = null;
    _audioBuffer = null;
  }
}
