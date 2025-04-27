import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recordatorio_aap/screens/home_screen.dart';
import 'package:recordatorio_aap/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return const MaterialApp(home: HomeScreen());
  }
}
