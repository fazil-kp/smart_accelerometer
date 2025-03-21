import 'package:accelerometer_example/config/colors.dart';
import 'package:accelerometer_example/view/accelerometer/accelerometer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(colorScheme: lightColorScheme);
    initTheme(themeData);
    return GetMaterialApp(
      title: 'Accelerometer',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
      themeMode: ThemeMode.light,
      theme: themeData,
      home: AccelerometerScreen(),
    );
  }
}
