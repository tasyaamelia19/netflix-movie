import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    // 4 detik total cinematic
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // skala dari sangat kecil ke normal lalu sedikit overshoot
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.2, end: 1.05).chain(CurveTween(curve: Curves.easeOut)), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 40),
    ]).animate(_controller);

    // opacity: muncul lalu bertahan lalu menghilang
    _opacityAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 30),
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 20),
    ]).animate(_controller);

    _controller.forward();

    // setelah 4 detik, pindah ke welcome
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/welcome');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _netflixLogoLarge() {
    // Logo sederhana hanya teks merah NETFLIX dengan font tebal
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'NETFLIX',
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.w900,
            letterSpacing: 6,
            fontSize: 64,
            shadows: [
              Shadow(
                offset: const Offset(0, 8),
                blurRadius: 30,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // cinematic background gradient + vignette
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // background: dark + subtle image effect (here gradient)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D0D0D), Color(0xFF050505)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // slightly blurred background decoration (cinematic bar)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // centered animated logo
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnim.value,
                  child: Transform.scale(
                    scale: _scaleAnim.value,
                    child: child,
                  ),
                );
              },
              child: _netflixLogoLarge(),
            ),
          ),

          // subtle cinematic horizontal bar sweep
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final progress = _controller.value;
                  // create a sweeping glare that moves across
                  final dx = (progress * 2) - 0.5; // -0.5 -> 1.5
                  return Opacity(
                    opacity: (1.0 - progress) * 0.6,
                    child: Align(
                      alignment: Alignment(0, -0.3),
                      child: Transform.translate(
                        offset: Offset(MediaQuery.of(context).size.width * dx, 0),
                        child: Container(
                          width: 220,
                          height: 18,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white.withOpacity(0.08),
                                Colors.white.withOpacity(0.0)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
