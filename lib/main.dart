import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyLandingApp());
}

class MyLandingApp extends StatelessWidget {
  const MyLandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P2P Arbitrage Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  void scrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // HERO SECTION
            Container(
              padding: EdgeInsets.symmetric(
                vertical: width < 900 ? 60 : 100,
                horizontal: 24,
              ),
              color: Colors.black,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 120,
                  ).animate().fadeIn(duration: 800.ms),
                  const SizedBox(height: 32),
                  Text(
                    'P2P Arbitrage Assistant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width < 900 ? 36 : 54,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 200.ms, duration: 900.ms),
                  const SizedBox(height: 16),
                  Text(
                    'Мониторинг P2P-стаканов и помощник арбитражника.\nМаксимальная скорость, удобство и стиль.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: width < 900 ? 18 : 24,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 400.ms, duration: 900.ms),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => scrollTo(650),
                    child: const Text('Попробовать бесплатно'),
                  ).animate().fadeIn(delay: 600.ms, duration: 700.ms),
const SizedBox(height: 24),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 48)
                      .animate().fadeIn(delay: 900.ms, duration: 700.ms)
                      .moveY(begin: -20, end: 0, duration: 700.ms),
                ],
              ),
            ),

            // FEATURES SECTION
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Почему выбирают нас?',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: [
                      _FeatureTile(
                        icon: Icons.speed,
                        title: 'Молниеносный мониторинг',
                        description: 'Обновление данных в реальном времени без задержек.',
                      ),
                      _FeatureTile(
                        icon: Icons.security,
                        title: 'Безопасность',
                        description: 'Ваши данные не хранятся на сервере, только локально.',
                      ),
                      _FeatureTile(
                        icon: Icons.design_services,
                        title: 'Apple-стиль',
                        description: 'Современный минималистичный дизайн и плавные анимации.',
                      ),
                      _FeatureTile(
                        icon: Icons.support_agent,
                        title: 'Поддержка 24/7',
                        description: 'Быстрая обратная связь и помощь в Telegram.',
                      ),
                    ].animate(interval: 200.ms).fadeIn(duration: 600.ms),
                  ),
                ],
              ),
            ),

            // SCREENSHOTS SECTION
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Скриншоты',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ).animate().fadeIn(),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _ScreenshotTile(imagePath: 'assets/screen1.png'),
                      _ScreenshotTile(imagePath: 'assets/screen2.png'),
                    ].animate(interval: 200.ms).fadeIn(duration: 700.ms),
                  ),
                ],
              ),
            ),

            // REVIEWS SECTION
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Отзывы пользователей',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ).animate().fadeIn(),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _ReviewTile(
                        avatar: Icons.person,
                        name: 'Андрей',
                        review: 'Лучший инструмент для арбитража! Всё быстро, удобно и понятно.',),
                      _ReviewTile(
                        avatar: Icons.person,
                        name: 'Екатерина',
                        review: 'Очень стильный интерфейс, поддержка отвечает мгновенно!',
                      ),
                      _ReviewTile(
                        avatar: Icons.person,
                        name: 'Иван',
                        review: 'Пользуюсь каждый день, экономит массу времени.',
                      ),
                    ].animate(interval: 200.ms).fadeIn(duration: 700.ms),
                  ),
                ],
              ),
            ),

            // CONTACTS & PAYMENT SECTION
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      // Заменить на ссылку на оплату (например, ЮKassa/Stripe/PayPal)
                      await launchUrl(Uri.parse('https://your-payment-link.com'));
                    },
                    child: const Text('Купить сейчас'),
                  ).animate().fadeIn(),
                  const SizedBox(height: 16),
                  Text(
                    'Есть вопросы? Напишите нам: support@yourdomain.com',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.telegram),
                    label: const Text('Чат поддержки в Telegram'),
                    onPressed: () async {
                      await launchUrl(Uri.parse('https://t.me/your_support_chat'));
                    },
                  ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),

            // FOOTER
            Container(
              color: Colors.black,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                '© 2025 P2P Arbitrage Assistant. Все права защищены.',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.black),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ScreenshotTile extends StatelessWidget {
  final String imagePath;

  const _ScreenshotTile({required this.imagePath});
@override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        width: 320,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final IconData avatar;
  final String name;
  final String review;

  const _ReviewTile({
    required this.avatar,
    required this.name,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(avatar, size: 40, color: Colors.blueGrey),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            review,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
