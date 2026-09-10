import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Impostazione stile scuro immersivo per barra di stato e di navigazione
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0A0B),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: GymApp(),
    ),
  );
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KINETIC — Black Performance Gym',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        // Garantisce che la scala del testo sia perfettamente leggibile su schermi mobile e browser Web
        final scaledScaler = mediaQuery.textScaler.clamp(
          minScaleFactor: 1.15,
          maxScaleFactor: 1.35,
        );
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: scaledScaler),
          child: child!,
        );
      },
      home: const MainLayout(),
    );
  }
}
