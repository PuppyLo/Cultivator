import 'package:flutter/material.dart';

void main() {
  runApp(CultivatorApp());
}

class CultivatorApp extends StatelessWidget {
  const CultivatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cultivator - Grow Your Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _heroAnimationController;
  late AnimationController _floatingController;
  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  double _featuresPosition = 0;
  double _contactPosition = 0;
  String _currentSection = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _heroFadeAnimation = Tween<double>(begin: -20.0, end: 20.0).animate(
      CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut),
    );
    _heroSlideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _heroAnimationController,
            curve: Curves.easeOut,
          ),
        );

    _heroAnimationController.forward();
    _floatingController.repeat(reverse: true);

    _scrollController.addListener(_updateCurrentSection);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _featuresPosition = getPositionFromKey(_featuresKey);
      _contactPosition = getPositionFromKey(_contactKey);
    });
  }

  double getPositionFromKey(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero).dy;
    return position;
  }

  void _updateCurrentSection() {
    final scrollOffset = _scrollController.offset;

    if (scrollOffset < _featuresPosition * 0.5) {
      _setCurrentSection('home');
    } else if (scrollOffset < _contactPosition * 0.9) {
      _setCurrentSection('features');
    } else {
      _setCurrentSection('contact');
    }
  }

  void _setCurrentSection(String section) {
    if (_currentSection != section) {
      setState(() {
        _currentSection = section;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    if (key == _homeKey) {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        // alignment: 0.3,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCurrentSection);
    _scrollController.dispose();
    _heroAnimationController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: _buildHeroSection()),
              SliverToBoxAdapter(child: _buildFeaturesSection()),
              SliverToBoxAdapter(child: _buildContactSection()),
              SliverToBoxAdapter(child: _buildFooter()),
            ],
          ),
          _buildFloatingNavigation(),
        ],
      ),
    );
  }

  Widget _buildFloatingNavigation() {
    return Positioned(
      top: 32,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedBuilder(
          animation: _scrollController.hasClients
              ? _scrollController
              : kAlwaysCompleteAnimation,
          builder: (context, child) {
            double offset = _scrollController.hasClients
                ? _scrollController.offset
                : 0;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ).withOpacity(offset > 100 ? 0.98 : 0.95),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      0,
                      0,
                      0,
                    ).withOpacity(offset > 100 ? 0.25 : 0.1),
                    blurRadius: offset > 100 ? 50 : 20,
                    offset: Offset(0, offset > 100 ? 25 : 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNavLink(
                    'Home',
                    () => _scrollToSection(_homeKey),
                    isActive: _currentSection == 'home',
                  ),
                  SizedBox(width: 32),
                  _buildNavLink(
                    'Features',
                    () => _scrollToSection(_featuresKey),
                    isActive: _currentSection == 'features',
                  ),
                  SizedBox(width: 32),
                  _buildNavLink(
                    'Contact',
                    () => _scrollToSection(_contactKey),
                    isActive: _currentSection == 'contact',
                  ),
                  SizedBox(width: 32),
                  _buildNavCTA(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavLink(
    String text,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Color(0xFF2563EB) : Color(0xFF475569),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildNavCTA() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        'Get Started',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      key: _homeKey,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8FAFC), Color(0xFF2563EB).withOpacity(0.05)],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _heroFadeAnimation,
              child: SlideTransition(
                position: _heroSlideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF2563EB)],
                      ).createShader(bounds),
                      child: Text(
                        'Cultivator',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 768
                              ? 64
                              : 128,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.05,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Grow your time, harvest success',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width < 768
                            ? 24
                            : 40,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF475569),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48),
                    _buildHeroCTA(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCTA() {
    return InkWell(
      onTap: () => _scrollToSection(_contactKey),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        decoration: BoxDecoration(
          color: Color(0xFF2563EB),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF2563EB).withOpacity(0.3),
              blurRadius: 25,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Start Growing',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 16),
            Text('→', style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      key: _featuresKey,
      padding: EdgeInsets.symmetric(vertical: 128, horizontal: 32),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Features that grow with you',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 768 ? 48 : 80,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 96),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth < 768
                  ? 1
                  : constraints.maxWidth < 1200
                  ? 2
                  : 3;
              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 64,
                mainAxisSpacing: 64,
                childAspectRatio: 1.2,
                children: [
                  _buildFeatureCard(
                    '🌱',
                    'Intuitive Scheduling',
                    'Plant your meetings and watch your productivity bloom. Our AI-powered scheduling adapts to your natural rhythms.',
                    Color(0xFF2563EB),
                  ),
                  _buildFeatureCard(
                    '🚀',
                    'Lightning Fast',
                    'No more waiting around. Instant syncing across all devices means your schedule is always up-to-date.',
                    Color(0xFF10B981),
                  ),
                  _buildFeatureCard(
                    '📊',
                    'Smart Analytics',
                    'Understand your time patterns with beautiful insights. See how you spend your time and optimize for growth.',
                    Color(0xFFF59E0B),
                  ),
                  _buildFeatureCard(
                    '🔗',
                    'Seamless Integration',
                    'Connect with all your favorite tools. From email to project management, everything works together.',
                    Color(0xFF2563EB),
                  ),
                  _buildFeatureCard(
                    '🎯',
                    'Goal Tracking',
                    'Set ambitious goals and track your progress. Watch as your daily actions compound into results.',
                    Color(0xFF10B981),
                  ),
                  _buildFeatureCard(
                    '🌟',
                    'Team Collaboration',
                    'Grow together with your team. Share schedules, coordinate meetings, and cultivate productivity.',
                    Color(0xFFF59E0B),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    String emoji,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(64),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 32))),
          ),
          SizedBox(height: 32),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF475569),
              height: 1.8,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      key: _contactKey,
      padding: EdgeInsets.symmetric(vertical: 128, horizontal: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Ready to grow?',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 768 ? 48 : 64,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Text(
                'Join thousands of professionals who\'ve transformed their time management',
                style: TextStyle(fontSize: 20, color: Color(0xFFCBD5E1)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 64),
              _buildContactForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: EdgeInsets.all(64),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildFormField('Full Name', 'Enter your name')),
              SizedBox(width: 32),
              Expanded(child: _buildFormField('Email', 'Enter your email')),
            ],
          ),
          SizedBox(height: 32),
          _buildFormField('Company', 'Enter your company name'),
          SizedBox(height: 32),
          _buildFormField(
            'Message',
            'Tell us about your scheduling needs...',
            maxLines: 5,
          ),
          SizedBox(height: 48),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFE2E8F0),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
            ),
            contentPadding: EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle form submission
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thank you! We\'ll be in touch soon 🌱'),
              backgroundColor: Color(0xFF10B981),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2563EB),
          padding: EdgeInsets.symmetric(vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'Start Your Growth Journey',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(64),
      color: Color(0xFF0F172A),
      child: Column(
        children: [
          Text(
            'Cultivator',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink('Privacy Policy'),
              SizedBox(width: 48),
              _buildFooterLink('Terms of Service'),
              SizedBox(width: 48),
              _buildFooterLink('Support'),
              SizedBox(width: 48),
              _buildFooterLink('Blog'),
            ],
          ),
          SizedBox(height: 48),
          Container(height: 1, color: Color(0xFF1E293B)),
          SizedBox(height: 32),
          Text(
            '© 2025 Cultivator. All rights reserved. Grow your time, harvest success.',
            style: TextStyle(color: Color(0xFFCBD5E1)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 16),
      ),
    );
  }
}
