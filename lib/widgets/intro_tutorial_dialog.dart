import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class IntroTutorialDialog extends StatelessWidget {
  const IntroTutorialDialog({super.key});

  static Future<void> show(BuildContext context, {bool force = false}) async {
    // If forced (manual trigger), show immediately without waiting for prefs
    if (force) {
      if (context.mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const IntroTutorialDialog(),
        );
        // Attempt to mark as seen after closing, just in case
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('has_seen_tutorial', true);
        } catch (e) {
          // Ignore storage errors
        }
      }
      return;
    }

    // Automatic check logic
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasSeen = prefs.getBool('has_seen_tutorial') ?? false;

      if (!hasSeen) {
        if (context.mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const IntroTutorialDialog(),
          );
          await prefs.setBool('has_seen_tutorial', true);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking tutorial status: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFF1E293B),
      title: const Text(
        '¡Bienvenido a LevelUP English!',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.school_rounded,
              size: 64,
              color: Color(0xFF7C4DFF),
            ),
            const SizedBox(height: 20),
            _buildStep(Icons.touch_app, 'Selecciona un nivel para comenzar.'),
            const SizedBox(height: 12),
            _buildStep(Icons.auto_stories, 'Estudia las palabras y su pronunciación.'),
            const SizedBox(height: 12),
            _buildStep(Icons.quiz, 'Supera los desafíos para desbloquear el siguiente nivel.'),
            const SizedBox(height: 20),
            const Text(
              '¡Disfruta tu aprendizaje!',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C4DFF),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'COMENZAR',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildStep(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF0EA5E9), size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
