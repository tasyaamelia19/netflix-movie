import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// PROVIDERS
import '../providers/my_list_provider.dart';
import '../providers/download_provider.dart';

// MODEL
import '../models/movie.dart';

class HeroBanner extends ConsumerWidget {
  final Movie featuredMovie;

  const HeroBanner({
    super.key,
    required this.featuredMovie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(myListProvider).contains(featuredMovie);

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 500,
          child: Image.asset(
            featuredMovie.imageUrl,
            fit: BoxFit.cover,
          ),
        ),

        Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.85),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          bottom: 30,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                featuredMovie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "${featuredMovie.genre} • ☆ ${featuredMovie.rating}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                featuredMovie.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                    label: const Text("Play",
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    icon: Icon(
                      isSaved ? Icons.check : Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      isSaved ? "Ada di Daftar Saya" : "Daftar Saya",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                    ),
                    onPressed: () {
                      final alreadySaved = ref
                          .read(myListProvider)
                          .contains(featuredMovie);

                      ref
                          .read(myListProvider.notifier)
                          .toggleMovie(featuredMovie);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            alreadySaved
                                ? "Dihapus dari Daftar Saya"
                                : "Ditambahkan ke Daftar Saya",
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    icon:
                        const Icon(Icons.download, color: Colors.white),
                    label: const Text("Download",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                    ),
                    onPressed: () {
                      ref
                          .read(downloadProvider.notifier)
                          .addDownload(featuredMovie);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Ditambahkan ke Download"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
