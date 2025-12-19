import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // Animasi progress untuk memunculkan N bertahap
  late Animation<double> _leftBarProgress;
  late Animation<double> _diagonalBarProgress;
  late Animation<double> _rightBarProgress;
  
  late Animation<double> _zoomAnim;
  late Animation<double> _opacityAnim;
  late Animation<double> _spectrumOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    );

    // 1. Munculkan Tiang Kiri (0% - 20%)
    _leftBarProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2, curve: Curves.easeOut)),
    );

    // 2. Munculkan Tiang Diagonal (15% - 40%)
    _diagonalBarProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.4, curve: Curves.easeOut)),
    );

    // 3. Munculkan Tiang Kanan (35% - 55%)
    _rightBarProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.55, curve: Curves.easeOut)),
    );

    // Zoom Cinematic: Pelan di awal, lalu melesat masuk ke layar (60% - 100%)
    _zoomAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 65,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 120.0).chain(CurveTween(curve: Curves.easeInExpo)),
        weight: 35,
      ),
    ]).animate(_controller);

    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.1, curve: Curves.linear)),
    );

    _spectrumOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.85, 1.0, curve: Curves.linear)),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) context.go('/welcome');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow Merah tipis
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Opacity(
              opacity: (1.0 - _controller.value).clamp(0.0, 0.2),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0xFFE50914), Colors.transparent],
                    radius: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // Logo "N" Cinematic (Bertahap per Batang)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _zoomAnim.value,
                child: Opacity(
                  opacity: _opacityAnim.value,
                  child: CustomPaint(
                    size: const Size(120, 180),
                    painter: NetflixStepByStepPainter(
                      leftProgress: _leftBarProgress.value,
                      diagonalProgress: _diagonalBarProgress.value,
                      rightProgress: _rightBarProgress.value,
                    ),
                  ),
                ),
              );
            },
          ),

          // Layer Efek Spektrum Garis Vertikal (Akhir Animasi)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Opacity(
              opacity: _spectrumOpacity.value,
              child: CustomPaint(
                size: MediaQuery.of(context).size,
                painter: NetflixSpectrumPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NetflixStepByStepPainter extends CustomPainter {
  final double leftProgress;
  final double diagonalProgress;
  final double rightProgress;

  NetflixStepByStepPainter({
    required this.leftProgress,
    required this.diagonalProgress,
    required this.rightProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double barWidth = w * 0.33;

    const Color redMain = Color(0xFFE50914);
    const Color redDark = Color(0xFFB9090B);

    final Paint sidePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [redDark, redMain],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final Paint centerPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [redMain, Color(0xFF8B0000)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    // 1. Batang Kiri
    canvas.drawRect(
      Rect.fromLTWH(0, h * (1 - leftProgress), barWidth, h * leftProgress),
      sidePaint,
    );

    // 2. Batang Kanan (Muncul setelah sedikit delay)
    if (rightProgress > 0) {
      canvas.drawRect(
        Rect.fromLTWH(w - barWidth, h * (1 - rightProgress), barWidth, h * rightProgress),
        sidePaint,
      );
    }

    // 3. Batang Diagonal (Muncul menimpa tiang kiri dan kanan)
    if (diagonalProgress > 0) {
      Path diagonalPath = Path()
        ..moveTo(0, 0)
        ..lineTo(barWidth, 0)
        ..lineTo(barWidth + (w - barWidth) * diagonalProgress, h * diagonalProgress)
        ..lineTo((w - barWidth) * diagonalProgress, h * diagonalProgress)
        ..close();

      canvas.drawShadow(diagonalPath, Colors.black, 10.0, true);
      canvas.drawPath(diagonalPath, centerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant NetflixStepByStepPainter oldDelegate) => true;
}

class NetflixSpectrumPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    const double barCount = 100;
    final double barWidth = size.width / barCount;

    final List<Color> colors = [
      const Color(0xFFE50914),
      const Color(0xFFB1060F),
      const Color(0xFF430354), // Ungu
      const Color(0xFF0D1B4E), // Biru gelap
      Colors.black,
    ];

    for (int i = 0; i < barCount; i++) {
      paint.color = Color.lerp(colors[i % colors.length], Colors.black, (i % 7) / 10)!;
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
      canvas.drawRect(Rect.fromLTWH(i * barWidth, 0, barWidth + 0.5, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}