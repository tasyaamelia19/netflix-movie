import 'package:flutter/material.dart';
import 'dart:async';

class FakeVideoScreen extends StatefulWidget {
  final String title;
  final String image;

  const FakeVideoScreen({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  State<FakeVideoScreen> createState() => _FakeVideoScreenState();
}

class _FakeVideoScreenState extends State<FakeVideoScreen> {
  bool isPlaying = true;
  bool showController = true;
  bool muted = false;

  bool subtitleOn = true;
  String subtitleLang = "ID";

  double progress = 0.0;
  double volume = 50;
  bool showVolumeSlider = false; // muncul slider ketika tombol volume ditekan

  Timer? timer;

  @override
  void initState() {
    super.initState();
    startFakeTimer();
    autoHideController();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startFakeTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!isPlaying) return;
      setState(() {
        progress += 0.01;
        if (progress >= 1.0) {
          progress = 1.0;
          isPlaying = false;
          timer.cancel();
        }
      });
    });
  }

  void autoHideController() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && isPlaying) setState(() => showController = false);
    });
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      showController = true;
    });
    startFakeTimer();
    autoHideController();
  }

  void skipForward() {
    setState(() {
      progress += 0.1;
      if (progress > 1) progress = 1;
    });
  }

  void skipBackward() {
    setState(() {
      progress -= 0.1;
      if (progress < 0) progress = 0;
    });
  }

  Widget buildNetflixSkipButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
        setState(() => showController = true);
        autoHideController();
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 40)),
      ),
    );
  }

  Widget buildSubtitle() {
    if (!subtitleOn) return const SizedBox();
    return Positioned(
      bottom: 150, // agar muat tombol bawah
      left: 0,
      right: 0,
      child: Text(
        subtitleLang == "ID"
            ? "Ini hanya subtitle ilustrasi..."
            : "This is just a sample subtitle...",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 6)],
        ),
      ),
    );
  }

  Widget buildController() {
    if (!showController) return const SizedBox();

    return Positioned.fill(
      child: Container(
        color: Colors.black45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Skip – Play/Pause – Skip
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNetflixSkipButton(Icons.replay_10_rounded, skipBackward),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: togglePlayPause,
                  child: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                buildNetflixSkipButton(Icons.forward_10_rounded, skipForward),
              ],
            ),

            // Progress bar
            Slider(
              value: progress,
              activeColor: Colors.red,
              inactiveColor: Colors.white38,
              onChanged: (v) => setState(() => progress = v),
            ),

            const SizedBox(height: 10),

            // Tombol bawah: Volume + Subtitle + Bahasa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Volume tunggal
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showVolumeSlider = !showVolumeSlider;
                        });
                        autoHideController();
                      },
                      child: Icon(
                        muted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    if (showVolumeSlider)
                      Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: Slider(
                              value: volume,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: volume.round().toString(),
                              activeColor: Colors.red,
                              inactiveColor: Colors.white24,
                              onChanged: (v) {
                                setState(() {
                                  volume = v;
                                  muted = v == 0;
                                });
                                autoHideController();
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                // Subtitle toggle
                IconButton(
                  icon: Icon(
                    subtitleOn ? Icons.subtitles : Icons.subtitles_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => subtitleOn = !subtitleOn);
                  },
                ),

                // Bahasa toggle
                TextButton(
                  onPressed: () {
                    setState(() {
                      subtitleLang = subtitleLang == "ID" ? "EN" : "ID";
                    });
                  },
                  child: Text(
                    subtitleLang,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => showController = !showController);
        if (showController) autoHideController();
      },
      onDoubleTap: togglePlayPause,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            buildSubtitle(),
            buildController(),
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
