import 'dart:async';
import 'package:flutter/material.dart';

class SimpleController extends StatefulWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const SimpleController({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  State<SimpleController> createState() => _SimpleControllerState();
}

class _SimpleControllerState extends State<SimpleController>
    with SingleTickerProviderStateMixin {
  bool _showControls = false;
  Timer? _hideTimer;

  bool _tapLeft = false;
  bool _tapRight = false;

  Duration current = const Duration(seconds: 10);
  Duration total = const Duration(minutes: 2);

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() => _showControls = false);
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) _startHideTimer();
  }

  void _skipLeft() {
    setState(() {
      _tapLeft = true;
      current -= const Duration(seconds: 10);
      if (current < Duration.zero) current = Duration.zero;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _tapLeft = false);
    });
  }

  void _skipRight() {
    setState(() {
      _tapRight = true;
      current += const Duration(seconds: 10);
      if (current > total) current = total;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _tapRight = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      onDoubleTapDown: (details) {
        final width = MediaQuery.of(context).size.width;
        final dx = details.globalPosition.dx;

        if (dx < width * 0.4) {
          _skipLeft();
        } else if (dx > width * 0.6) {
          _skipRight();
        }
      },
      child: Stack(
        children: [
          // =============================
          // DARK OVERLAY WHEN ACTIVE
          // =============================
          AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _showControls ? 1 : 0,
            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),

          // =============================
          // CENTER CONTROLS (PLAY/PAUSE)
          // =============================
          AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _showControls ? 1 : 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  widget.onPlayPause();
                  _startHideTimer();
                },
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    widget.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // =============================
          // LEFT SKIP RIPPLE
          // =============================
          if (_tapLeft)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.replay_10,
                    size: 75, color: Colors.white.withOpacity(0.9)),
              ),
            ),

          // =============================
          // RIGHT SKIP RIPPLE
          // =============================
          if (_tapRight)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.forward_10,
                    size: 75, color: Colors.white.withOpacity(0.9)),
              ),
            ),

          // =============================
          // BOTTOM PROGRESS BAR
          // =============================
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showControls ? 1 : 0,
              child: Column(
                children: [
                  Slider(
                    value: current.inSeconds.toDouble(),
                    min: 0,
                    max: total.inSeconds.toDouble(),
                    onChanged: (_) {},
                    activeColor: Colors.red,
                    inactiveColor: Colors.white38,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_format(current),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                        Text(_format(total),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, "0");
    final s = (d.inSeconds % 60).toString().padLeft(2, "0");
    return "$m:$s";
  }
}
