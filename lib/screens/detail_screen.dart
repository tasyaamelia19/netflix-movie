import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../providers/download_provider.dart';
import '../providers/my_list_provider.dart';
import '../data/movies_data.dart';
import '../widgets/simple_controller.dart';

// Tambahan impor fake video
import 'fake_video_screen.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  bool isPlaying = true; // untuk controller

  @override
  Widget build(BuildContext context) {
    final isSaved = ref.watch(myListProvider).contains(widget.movie);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Poster Film + Controller
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: Stack(
                    children: [
                      Image.asset(
                        widget.movie.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),

                      // === CONTROLLER NETFLIX YANG SUDAH BENAR ===
                      Positioned.fill(
                        child: SimpleController(
                          isPlaying: isPlaying,
                          onPlayPause: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // GRADIENT
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.4),
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                // Tombol Back
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // TEXT DETAIL
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul Film
                      Text(
                        widget.movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Genre & Rating
                      Text(
                        "${widget.movie.genre} • ⭐ ${widget.movie.rating}",
                        style: const TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 15),

                      // Description
                      Text(
                        widget.movie.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 20),

                      // BUTTONS
                      Row(
                        children: [
                          // PLAY
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FakeVideoScreen(
                                    title: widget.movie.title,
                                    image: widget.movie.imageUrl,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            icon: const Icon(Icons.play_arrow),
                            label: const Text("Play"),
                          ),

                          const SizedBox(width: 10),

                          // DAFTAR SAYA
                          OutlinedButton.icon(
                            onPressed: () {
                              final alreadySaved =
                                  ref.read(myListProvider).contains(widget.movie);

                              ref
                                  .read(myListProvider.notifier)
                                  .toggleMovie(widget.movie);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    alreadySaved
                                        ? "Dihapus dari Daftar Saya"
                                        : "Ditambahkan ke Daftar Saya",
                                  ),
                                  duration:
                                      const Duration(milliseconds: 900),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                            ),
                            icon: Icon(
                              isSaved ? Icons.check : Icons.add,
                              color: Colors.white,
                            ),
                            label: Text(
                              isSaved
                                  ? "Ada di Daftar Saya"
                                  : "Daftar Saya",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // DOWNLOAD
                          OutlinedButton.icon(
                            onPressed: () {
                              ref
                                  .read(downloadProvider.notifier)
                                  .addDownload(widget.movie);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Ditambahkan ke Download"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                            ),
                            icon: const Icon(Icons.download,
                                color: Colors.white),
                            label: const Text(
                              "Download",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Trending Now",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),

            // LIST TRENDING
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingMovies.length,
                itemBuilder: (context, index) {
                  final t = trendingMovies[index];

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 140,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              t.imageUrl,
                              width: 140,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            t.title,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
