import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.red.shade700, // Rojo principal
      secondary: Colors.amber.shade600, // Amarillo bajo
      background: const Color(0xFFF5F5F5), // Un blanco un poco gris
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.red.shade400, // Un rojo más suave para modo oscuro
      secondary: Colors.amber.shade400, // Un amarillo más suave
      onPrimary: Colors.black,
      onSecondary: Colors.black,
    ),
  );
}