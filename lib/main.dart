import 'package:flutter/material.dart';
import 'state/app_state.dart';
import 'screens/learning_path_screen.dart';
import 'state/ads_service.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await AppState.instance.init();
  } catch (e) {
    debugPrint('AppState init error: $e');
  }

  try {
    await AdsService.instance.initialize();
    await AdsService.instance.preloadRewarded();
  } catch (e) {
    debugPrint('AdsService init error: $e');
  }
  
  // Do not reset to samples in development; preserve persisted user progress.
  runApp(const VocabMasterApp());
}

class VocabMasterApp extends StatelessWidget {
  const VocabMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppState.instance.currentThemeId,
      builder: (context, themeId, _) {
        final ThemeData theme = _getTheme(themeId);
        return MaterialApp(
          title: 'LevelUP English',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: theme,
          navigatorObservers: [routeObserver],
          home: const LearningPathScreen(),
        );
      },
    );
  }

  ThemeData _getTheme(String themeId) {
    Color seed;
    Color scaffoldBg;
    Color cardBg;
    
    switch (themeId) {
      case 'gold':
        seed = Colors.amber;
        scaffoldBg = const Color(0xFF2D2416);
        cardBg = const Color(0xFF453823);
        break;
      case 'ocean':
        seed = Colors.tealAccent;
        scaffoldBg = const Color(0xFF001F24);
        cardBg = const Color(0xFF00363D);
        break;
      case 'dark_neon':
        seed = Colors.purpleAccent;
        scaffoldBg = const Color(0xFF120024);
        cardBg = const Color(0xFF2A0045);
        break;
      case 'default':
      default:
        seed = const Color(0xFF7C4DFF);
        scaffoldBg = const Color(0xFF0F172A);
        cardBg = const Color(0xFF1E293B);
        break;
    }

    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
      scaffoldBackgroundColor: scaffoldBg,
      cardColor: cardBg,
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
          foregroundColor: Colors.white, // For readability on any seed
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
        backgroundColor: cardBg.withValues(alpha: 0.8), // Slightly lighter than card
        selectedColor: seed.withValues(alpha: 0.35),
        secondarySelectedColor: seed.withValues(alpha: 0.35),
        labelStyle: const TextStyle(color: Colors.white),
        checkmarkColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
    );
  }
}
