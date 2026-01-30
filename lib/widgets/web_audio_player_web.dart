import 'dart:html' as html;
import 'dart:web_audio' as web_audio;
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class WebAudioPlayer {
  // Use AudioContext for more reliable playback of short sounds
  web_audio.AudioContext? _audioContext;
  web_audio.AudioBuffer? _audioBuffer;
  
  // Keep reference to prevent Garbage Collection (Critical!)
  web_audio.AudioBufferSourceNode? _activeSource;
  
  // Backup HTML element
  html.AudioElement? _backupElement;

  Future<void> load(String assetPath) async {
    if (kIsWeb) {
      try {
        print('Loading web audio from: $assetPath');
        _audioContext = web_audio.AudioContext();
        
        // Try multiple paths
        final paths = [
          assetPath,
          'assets/$assetPath',
          'assets/assets/audio/congratulations.mp3',
          'assets/audio/congratulations.mp3', 
        ];

        html.HttpRequest? response;
        String? workingPath;

        for (final path in paths) {
          try {
            print('Trying to fetch audio from: $path');
            response = await html.HttpRequest.request(
              path,
              responseType: 'arraybuffer',
            );
            if (response != null && response.status == 200) {
              workingPath = path;
              print('Successfully fetched audio from: $path');
              break;
            }
          } catch (e) {
            print('Failed to fetch from $path');
          }
        }

        if (response == null || response.response == null) {
          throw Exception('Could not fetch audio from any path');
        }

        _audioBuffer = await _audioContext!.decodeAudioData(response.response);
        
        // Setup backup element
        if (workingPath != null) {
          _backupElement = html.AudioElement(workingPath);
          _backupElement!.preload = 'auto';
        }
        
        print('Web audio decoded successfully');
      } catch (e) {
        print('Error loading web audio: $e');
        html.window.alert('Audio Load Error: $e');
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
            await _audioContext!.resume();
          }

          final gainNode = _audioContext!.createGain();
          gainNode.gain!.value = 1.0;
          gainNode.connectNode(_audioContext!.destination!);

          // Store in class member to prevent GC
          _activeSource = _audioContext!.createBufferSource();
          _activeSource!.buffer = _audioBuffer;
          _activeSource!.connectNode(gainNode);
          
          _activeSource!.start(_audioContext!.currentTime! + 0.01);
          print('Context playback scheduled');
        } catch (e) {
          print('Context play failed: $e');
        }
      }
      
      // Strategy 2: HTML Element (Backup)
      // This is often more reliable for simple "fire and forget" if Context fails
      if (_backupElement != null) {
        try {
          print('Playing web audio via Backup Element...');
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
