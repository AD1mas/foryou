import 'package:flutter/material.dart';
import 'package:foryou/core/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeMode = AppTheme.darkTheme;

  ThemeData get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == AppTheme.darkTheme;

  void toggleTheme(bool value) {
    _themeMode = value ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }
}
