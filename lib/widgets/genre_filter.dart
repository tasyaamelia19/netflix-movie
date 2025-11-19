import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_settings_notifier.dart';

class GenreFilter extends ConsumerWidget {
  const GenreFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);  // ✔ DIBENARKAN

    final genres = [
      "All", "Action", "Romance", "Horror",
      "Comedy", "Drama", "Adventure", "Thriller",
      "Sci-Fi", "Fantasy", "Mystery", "Anime",
      "Documentary", "Family", "Crime"
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (_, i) {
          final g = genres[i];
          final active = g == settings.genre;

          return GestureDetector(
            onTap: () => ref.read(appSettingsProvider.notifier).setGenre(g),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: active
                    ? Colors.red
                    : Colors.white.withOpacity(0.2),
              ),
              child: Text(
                g,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
