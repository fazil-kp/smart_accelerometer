import 'package:flutter/material.dart';

late ThemeData theme;

void initTheme(ThemeData newTheme) {
  theme = newTheme;
}

Color get scaffoldColor => theme.colorScheme.surface;
Color get background => theme.colorScheme.primary;
Color get primary => theme.colorScheme.tertiary;
Color get secondary => theme.colorScheme.secondary;
Color get inactiveBorder => theme.colorScheme.outline;
Color get activeBorder => theme.colorScheme.outlineVariant;
Color get cardBackground => theme.colorScheme.onPrimary;
Color get cardColor => theme.colorScheme.onPrimaryContainer;
Color get ashColor => theme.colorScheme.primaryContainer;

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  surface: Color(0XFFFFFFFF),
  primary: Color(0XFFFFFFFF),
  secondary: Color.fromARGB(255, 0, 0, 0),
  outline: Color(0xFF202227),
  outlineVariant: Color(0xFF727a8e),
  tertiary: Colors.blueAccent,
  onTertiary: Color(0xFF8b91a8),
  onPrimary: Color(0xFF212227),
  primaryContainer: Color.fromARGB(255, 189, 189, 189),
  onPrimaryContainer: Color(0XFF1c1c1e),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  error: Color(0xFFEA1505),
  onError: Color(0xFFFFFFFF),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  surface: Color(0XFFFFFFFF),
  primary: Color(0XFFFFFFFF),
  secondary: Color(0xFF00286B),
  outline: Color(0xFF202227),
  outlineVariant: Color(0xFF727a8e),
  tertiary: Color(0xFFe1e5f0),
  onTertiary: Color(0xFF8b91a8),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFFFFF),
  onPrimaryContainer: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  error: Color(0xFFEA1505),
  onError: Color(0xFFFFFFFF),
);
