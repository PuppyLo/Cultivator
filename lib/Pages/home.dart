import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultivator Web'),
        actions: [
          TextButton(onPressed: () => context.go('/'), child: const Text('Главная')),
          TextButton(onPressed: () => context.go('/about'), child: const Text('О нас')),
          TextButton(onPressed: () => context.go('/download'), child: const Text('Скачать')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Добро пожаловать в Cultivator!',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ).animate().fadeIn(duration: 600.ms).slide(),

          const SizedBox(height: 40),
          const Text(
            'Нажмите на раздел "Скачать", чтобы загрузить программу.',
            style: TextStyle(fontSize: 18),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
        ],
      ),
    );
  }
}