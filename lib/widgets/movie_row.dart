import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/detail_screen.dart'; // PENTING: import DetailScreen
import 'movie_card.dart';

class MovieRow extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final String genreFilter;
  final String searchFilter;

  const MovieRow({
    super.key,
    required this.title,
    required this.movies,
    required this.genreFilter,
    required this.searchFilter,
  });

  @override
  Widget build(BuildContext context) {
    // --- FILTER ---
    List<Movie> list = movies;

    if (genreFilter != "All") {
      list = list.where((m) =>
        m.genre.toLowerCase().contains(genreFilter.toLowerCase())
      ).toList();
    }

    if (searchFilter.isNotEmpty) {
      list = list.where((m) =>
        m.title.toLowerCase().contains(searchFilter.toLowerCase())
      ).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // MOVIE LIST
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemBuilder: (_, i) => MovieCard(
              movie: list[i],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(movie: list[i]),
                  ),
                );
              },
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: list.length,
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
