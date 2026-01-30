import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroTutorialDialog extends StatelessWidget {
  const IntroTutorialDialog({super.key});

  static Future<void> show(BuildContext context) async {
    print('DEBUG: IntroTutorialDialog.show called');
    try {
      final prefs = await SharedPreferences.getInstance();
      print('DEBUG: SharedPreferences instance obtained');
      
      // Force reset for debugging if needed, but for now just read
      // await prefs.setBool('has_seen_tutorial', false); 

      // Force show for testing
      // final hasSeen = prefs.getBool('has_seen_tutorial') ?? false;
      final hasSeen = false; 
      print('DEBUG: has_seen_tutorial forced to $hasSeen');

      if (!hasSeen) {
        print('DEBUG: Showing dialog...');
        if (context.mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const IntroTutorialDialog(),
          );
          await prefs.setBool('has_seen_tutorial', true);
          print('DEBUG: Tutorial marked as seen');
        } else {
          print('DEBUG: Context not mounted, skipping dialog');
        }
      } else {
        print('DEBUG: Tutorial already seen, skipping');
      }
    } catch (e) {
      print('DEBUG: Error checking tutorial status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFF1E293B),
      title: const Text(
        '¡Bienvenido a LevelTrack!',
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
