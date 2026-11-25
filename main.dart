import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(const PlayedApp());
}

class PlayedApp extends StatelessWidget {
  const PlayedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Played',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
          0xFF2C0016,
        ), // Koyu bordo background
      ),
      home: const WelcomeScreen(),
    );
  }
}

// 1. EKRAN: WELCOME (Delay + 800ms Spring Smart Animate)
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const spring = SpringDescription(
                    mass: 1.0,
                    stiffness: 100.0,
                    damping: 15.0,
                  );
                  final simulation = SpringSimulation(spring, 0.0, 1.0, 0.0);

                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      final double t = animation.value * 0.8;
                      final double springValue = simulation.x(t);

                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: const Interval(
                            0.0,
                            0.6,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Transform.translate(
                          offset: Offset(0, (1 - springValue) * 40),
                          child: child,
                        ),
                      );
                    },
                  );
                },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Hero(
          tag: 'played_logo',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'played',
              style: TextStyle(
                color: Color(0xFFE4CBBF),
                fontSize: 42,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. EKRAN: LOGIN (450x917 - No scrolling)
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Hero(
                    tag: 'played_logo',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'played',
                        style: TextStyle(
                          color: Color(0xFFE4CBBF),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  _buildInputBox('Username / Email'),
                  const SizedBox(height: 18),
                  _buildInputBox('Password', isPassword: true),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Color(0xFF938282),
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              color: Color(0xFFE4CBBF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  _buildSubmitButton('Submit', () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationScreen(),
                      ),
                    );
                  }),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 3. EKRAN: SIGN UP (412x917 - No scrolling)
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 412),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Text(
                    'played',
                    style: TextStyle(
                      color: Color(0xFFE4CBBF),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(flex: 2),
                  _buildInputBox('Username'),
                  const SizedBox(height: 15),
                  _buildInputBox('Email'),
                  const SizedBox(height: 15),
                  _buildInputBox('Password', isPassword: true),
                  const SizedBox(height: 15),
                  _buildInputBox('Confirm Password', isPassword: true),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreed,
                          activeColor: const Color(0xFF4F4E80),
                          side: const BorderSide(
                            color: Color(0xFF938282),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (val) =>
                              setState(() => _agreed = val ?? false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(
                              color: Color(0xFF938282),
                              fontSize: 10.5,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Services',
                                style: TextStyle(
                                  color: Color(0xFFE4CBBF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Color(0xFFE4CBBF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildSubmitButton('Submit', () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationScreen(),
                      ),
                    );
                  }),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 4. EKRAN: FEED / HOME (412x917 - Trending ve Reviews from friends: Overflow Horizontal)
class FeedHomeScreen extends StatelessWidget {
  const FeedHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'played',
                  style: TextStyle(
                    color: Color(0xFFE4CBBF),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Trending',
                  style: TextStyle(
                    color: Color(0xFF938282),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 165,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildPosterCard(
                      context: context,
                      title: 'FORTNITE',
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF3A7BD5), Color(0xFF00D2FF)],
                      ),
                      hasLabel: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameDetailScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                  ],
                ),
              ),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Reviews from friends',
                  style: TextStyle(
                    color: Color(0xFF938282),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 165,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                    const SizedBox(width: 12),
                    _buildPosterCard(context: context),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPosterCard({
    required BuildContext context,
    String? title,
    Gradient? gradient,
    bool hasLabel = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 112,
        height: 165,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          gradient: gradient,
          borderRadius: BorderRadius.circular(4),
        ),
        child: hasLabel && title != null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  color: Colors.black.withOpacity(0.45),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFFD54F),
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

// 5. EKRAN: SEARCH (412x917 - No scrolling)
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F4E80),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Color(0xFFE4CBBF), fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF938282),
                        size: 20,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color(0xFF938282),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 11),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Recently searched',
                  style: TextStyle(
                    color: Color(0xFF938282),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 6. EKRAN: GAME DETAIL (412x1436 - Vertical Scrolling)
class GameDetailScreen extends StatelessWidget {
  const GameDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C0016),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 240,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF2B5876),
                            Color(0xFF4E4376),
                            Color(0xFF2C0016),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFFE4CBBF),
                                size: 20,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      right: 24,
                      bottom: -28,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fortnite',
                                style: TextStyle(
                                  color: Color(0xFFE4CBBF),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '2017 · Epic Games',
                                style: TextStyle(
                                  color: Color(0xFF938282),
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 88,
                            height: 126,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF3A7BD5), Color(0xFF00D2FF)],
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.55),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                color: Colors.black.withOpacity(0.5),
                                child: const Text(
                                  'FORTNITE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFFFD54F),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 56),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Game Details',
                        style: TextStyle(
                          color: Color(0xFFE4CBBF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Fortnite is the completely free multiplayer game where you and your friends collaborate to create your dream Fortnite world or battle to be the last one standing. Play both Battle Royale and Fortnite Creative for FREE. Download now and jump into the action.',
                        style: TextStyle(
                          color: Color(0xFF938282),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F4E80),
                              foregroundColor: const Color(0xFFE4CBBF),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Rate or log',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      const Text(
                        'User Reviews',
                        style: TextStyle(
                          color: Color(0xFFE4CBBF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      _buildReviewItem(
                        username: 'user1',
                        rating: 5,
                        comment: 'I love this game so much! Best multiplayer game to play with friends.',
                      ),
                      _buildReviewItem(
                        username: 'user2',
                        rating: 4,
                        comment: 'Good game! I would play this game for hours with my squad.',
                      ),
                      _buildReviewItem(
                        username: 'user3',
                        rating: 5,
                        comment: 'Really fun game with friends. New updates keep it fresh and exciting!',
                      ),
                      _buildReviewItem(
                        username: 'user4',
                        rating: 4,
                        comment: 'Great graphics and fast paced action. Definitely worth playing.',
                      ),
                      _buildReviewItem(
                        username: 'user5',
                        rating: 5,
                        comment: 'Zero Build mode brought me back to the game, having a blast every night.',
                      ),
                      _buildReviewItem(
                        username: 'user6',
                        rating: 4,
                        comment: 'Classic battle royale experience, always fun with a full party.',
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2C0016),
        selectedItemColor: const Color(0xFFE4CBBF),
        unselectedItemColor: const Color(0xFF938282),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: 0,
        onTap: (index) {
          Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String username,
    required int rating,
    required String comment,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Color(0xFFE4CBBF),
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFFE4CBBF),
                      size: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  comment,
                  style: const TextStyle(
                    color: Color(0xFF938282),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 7. EKRAN: LOG SCREEN (412x917 - No scrolling, Played / Like / Wishlist)
class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  bool _isPlayed = false;
  bool _isLiked = false;
  bool _isWishlist = false;
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C0016),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF2B5876),
                          Color(0xFF4E4376),
                          Color(0xFF2C0016),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFFE4CBBF),
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: -24,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fortnite',
                              style: TextStyle(
                                color: Color(0xFFE4CBBF),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '2017 · Epic Games',
                              style: TextStyle(
                                color: Color(0xFF938282),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 82,
                          height: 118,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF3A7BD5), Color(0xFF00D2FF)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.55),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              color: Colors.black.withOpacity(0.5),
                              child: const Text(
                                'FORTNITE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFFD54F),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionIcon(
                      icon: _isPlayed
                          ? Icons.sports_esports
                          : Icons.sports_esports_outlined,
                      label: 'Played',
                      isActive: _isPlayed,
                      activeColor: const Color(0xFF4CAF50),
                      onTap: () => setState(() => _isPlayed = !_isPlayed),
                    ),
                    _buildActionIcon(
                      icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                      label: 'Like',
                      isActive: _isLiked,
                      activeColor: const Color(0xFFFF6B35),
                      onTap: () => setState(() => _isLiked = !_isLiked),
                    ),
                    _buildActionIcon(
                      icon: _isWishlist
                          ? Icons.check_circle
                          : Icons.add_circle_outline,
                      label: 'Wishlist',
                      isActive: _isWishlist,
                      activeColor: const Color(0xFF64B5F6),
                      onTap: () => setState(() => _isWishlist = !_isWishlist),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Divider(
                color: Color(0xFF4F4E80),
                thickness: 0.6,
                indent: 24,
                endIndent: 24,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final isFilled = starIndex <= _selectedRating;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = (_selectedRating == starIndex)
                            ? 0
                            : starIndex;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(
                        isFilled ? Icons.star : Icons.star_border,
                        color: isFilled
                            ? const Color(0xFFFFD54F)
                            : const Color(0xFFE4CBBF),
                        size: 32,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 6),
              const Text(
                'Rate',
                style: TextStyle(color: Color(0xFF938282), fontSize: 11),
              ),
              const SizedBox(height: 14),
              const Divider(
                color: Color(0xFF4F4E80),
                thickness: 0.6,
                indent: 24,
                endIndent: 24,
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  maxLines: 4,
                  style: TextStyle(color: Color(0xFFE4CBBF), fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Add review...',
                    hintStyle: TextStyle(
                      color: Color(0xFF938282),
                      fontSize: 12.5,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              _buildSubmitButton('Submit', () {
                Navigator.pop(context);
              }),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2C0016),
        selectedItemColor: const Color(0xFFE4CBBF),
        unselectedItemColor: const Color(0xFF938282),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: 0,
        onTap: (index) {
          Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: isActive ? activeColor : const Color(0xFFE4CBBF),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isActive ? activeColor : const Color(0xFF938282),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// 8. EKRAN: PROFILE (412x1319 - Vertical Scrolling, Favorite games & Played recently: Horizontal)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 112,
                        height: 112,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'username',
                        style: TextStyle(
                          color: Color(0xFFE4CBBF),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Add a short bio about your gaming journey...',
                        style: TextStyle(
                          color: Color(0xFF938282),
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatChip('120 games'),
                          const SizedBox(width: 24),
                          _buildStatChip('56 reviews'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Favorite games',
                    style: TextStyle(
                      color: Color(0xFF938282),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 165,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      _buildProfilePosterCard(),
                      const SizedBox(width: 12),
                      _buildProfilePosterCard(),
                      const SizedBox(width: 12),
                      _buildProfilePosterCard(),
                      const SizedBox(width: 12),
                      _buildProfilePosterCard(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Played recently',
                    style: TextStyle(
                      color: Color(0xFF938282),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 165,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      _buildProfilePosterCard(),
                      const SizedBox(width: 12),
                      _buildProfilePosterCard(),
                      const SizedBox(width: 12),
                      _buildProfilePosterCard(),
                      const SizedBox(width: 12),
                      _buildProfilePosterCard(),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                const Divider(
                  color: Color(0xFF938282),
                  thickness: 0.5,
                  height: 1,
                ),
                _buildMenuRow('My Games', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyGamesScreen(),
                    ),
                  );
                }),
                const Divider(
                  color: Color(0xFF938282),
                  thickness: 0.5,
                  height: 1,
                ),
                _buildMenuRow('Followers', () {}),
                const Divider(
                  color: Color(0xFF938282),
                  thickness: 0.5,
                  height: 1,
                ),
                _buildMenuRow('Following', () {}),
                const Divider(
                  color: Color(0xFF938282),
                  thickness: 0.5,
                  height: 1,
                ),
                _buildMenuRow('Reviews', () {}),
                const Divider(
                  color: Color(0xFF938282),
                  thickness: 0.5,
                  height: 1,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF4F4E80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF938282),
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProfilePosterCard() {
    return Container(
      width: 112,
      height: 165,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildMenuRow(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Color(0xFF938282), fontSize: 13.5),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF938282), size: 20),
          ],
        ),
      ),
    );
  }
}

// 9. EKRAN: MY GAMES (412x917 - No scrolling, Played / Wishlist / Likes: Overflow Horizontal)
class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C0016),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 412),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFFE4CBBF),
                            size: 18,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    const Text(
                      'My Games',
                      style: TextStyle(
                        color: Color(0xFFE4CBBF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 1),

                // 1. Kategori: Played (Overflow: Horizontal)
                _buildGameCategorySection('Played'),
                const Spacer(flex: 1),

                // 2. Kategori: Wishlist (Overflow: Horizontal)
                _buildGameCategorySection('Wishlist'),
                const Spacer(flex: 1),

                // 3. Kategori: Likes (Overflow: Horizontal)
                _buildGameCategorySection('Likes'),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2C0016),
        selectedItemColor: const Color(0xFFE4CBBF),
        unselectedItemColor: const Color(0xFF938282),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: 2,
        onTap: (index) {
          Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildGameCategorySection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF938282),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              _buildSmallPosterCard(),
              const SizedBox(width: 12),
              _buildSmallPosterCard(),
              const SizedBox(width: 12),
              _buildSmallPosterCard(),
              const SizedBox(width: 12),
              _buildSmallPosterCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallPosterCard() {
    return Container(
      width: 104,
      height: 145,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// ALT NAVİGASYON VE SAYFA GEÇİŞLERİ
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const FeedHomeScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2C0016),
        selectedItemColor: const Color(0xFFE4CBBF),
        unselectedItemColor: const Color(0xFF938282),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}

// ORTAK KUTU VE BUTON TASARIMLARI
Widget _buildInputBox(String hint, {bool isPassword = false}) {
  return Container(
    height: 46,
    decoration: BoxDecoration(
      color: const Color(0xFF4F4E80),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Color(0xFFE4CBBF), fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF938282), fontSize: 13),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
  );
}

Widget _buildSubmitButton(String text, VoidCallback onPressed) {
  return SizedBox(
    height: 36,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4F4E80),
        foregroundColor: const Color(0xFFE4CBBF),
        padding: const EdgeInsets.symmetric(horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    ),
  );
}