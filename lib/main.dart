import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'Pages/about.dart';
import 'Pages/download.dart';
import 'Pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/about', builder: (_, __) => const AboutPage()),
        GoRoute(path: '/download', builder: (_, __) => const DownloadPage()),
      ],
    );

    return MaterialApp.router(
      title: 'Cultivator Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      routerConfig: router,
    );
  }
}