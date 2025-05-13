import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О проекте')),
      body: Center(
        child: const Text('Cultivator — это ваше новое решение для анализа торговли.')
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(),
      ),
    );
  }
}