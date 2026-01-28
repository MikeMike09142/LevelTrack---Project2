import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'state/app_state.dart';
import 'screens/learning_path_screen.dart';
import 'state/ads_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.init();
  await AdsService.instance.initialize();
  await AdsService.instance.preloadRewarded();
  // Do not reset to samples in development; preserve persisted user progress.
  runApp(const VocabMasterApp());
}

class VocabMasterApp extends StatelessWidget {
  const VocabMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF7C4DFF);
    return MaterialApp(
      title: 'Vocab Master',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardColor: const Color(0xFF1E293B),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white70,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          subtitleTextStyle: TextStyle(color: Colors.white70),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: seed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: seed,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF243447),
          selectedColor: seed.withOpacity(0.35),
          secondarySelectedColor: seed.withOpacity(0.35),
          labelStyle: const TextStyle(color: Colors.white),
          checkmarkColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
      ),
      home: const LearningPathScreen(),
    );
  }
}
