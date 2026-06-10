import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabPageSelector Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B3A6B)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

/// A simple app onboarding flow: the user swipes through a few welcome
/// pages, and the dots at the bottom (the TabPageSelector) show which
/// page they are currently on.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}


class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  
  late final TabController _tabController;

  // The content for each onboarding page.
  final List<_Page> _pages = const [
    _Page(
      icon: Icons.eco,
      title: 'Welcome to FarmWise',
      body: 'Smart insights for every season, right in your pocket.',
      color: Color(0xFF2E7D32),
    ),
    _Page(
      icon: Icons.cloud,
      title: 'Weather Alerts',
      body: 'Get rain and drought warnings before they reach your farm.',
      color: Color(0xFF1565C0),
    ),
    _Page(
      icon: Icons.trending_up,
      title: 'Better Prices',
      body: 'Know the best market prices before you sell your harvest.',
      color: Color(0xFFEF6C00),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // length = how many tabs/pages; vsync = this State (the ticker).
    _tabController = TabController(length: _pages.length, vsync: this);
    // Rebuild the screen whenever the page changes so the "Next/Done"
    // button can update its label.
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose(); // Always free the controller.
    super.dispose();
  }

  bool get _isLastPage => _tabController.index == _pages.length - 1;

  void _onNextPressed() {
    if (_isLastPage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Onboarding finished! 🎉')),
      );
    } else {
      // Animate to the next tab; the dots follow automatically.
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // The swipeable pages. It shares the SAME _tabController,
            // so swiping here moves the dots below.
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _pages.map((p) => _PageView(page: p)).toList(),
              ),
            ),

          
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TabPageSelector(
                controller: _tabController,            // 1) links it to the pages
                selectedColor: const Color(0xFF1B3A6B), // 2) active dot color
                color: Colors.grey.shade300,           // 3) inactive dot color
                indicatorSize: 16,                     // diameter of each dot
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _onNextPressed,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(_isLastPage ? 'Get Started' : 'Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single onboarding page's visual content.
class _PageView extends StatelessWidget {
  const _PageView({required this.page});
  final _Page page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(page.icon, size: 120, color: page.color),
          const SizedBox(height: 40),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            page.body,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

/// Plain data holder for one page.
class _Page {
  const _Page({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;
}
