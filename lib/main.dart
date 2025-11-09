import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/onboarding_screen.dart';
import 'firebase_options.dart';
import 'screens/auth_wrapper.dart';

Future<void> main() async {
  // Asegurarse de que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  // Buscamos el valor 'showOnboarding'. Si no existe, devolvemos 'true' por defecto.
  final showOnboarding = prefs.getBool('showOnboarding') ?? true;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: BuenBajeApp(showOnboarding: showOnboarding),
    ),
  );
}

class BuenBajeApp extends StatelessWidget {
  final bool showOnboarding;
  const BuenBajeApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'BuenBaje',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          home: showOnboarding ? const OnboardingScreen() : const AuthWrapper(),
        );
      },
    );
  }
}