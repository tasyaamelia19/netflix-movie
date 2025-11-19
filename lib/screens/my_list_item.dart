import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../providers/my_list_provider.dart';

class MyListItem extends ConsumerWidget {
  final Movie movie;

  const MyListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      // POSTER
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          movie.imageUrl,
          width: 60,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),

      // JUDUL
      title: Text(
        movie.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),

      // GENRE
      subtitle: Text(
        movie.genre,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
      ),

      // TOMBOL CENTANG (HAPUS)
      trailing: IconButton(
        icon: const Icon(Icons.check, color: Colors.redAccent, size: 28),
        onPressed: () {
          _showDeleteDialog(context, ref, movie);
        },
      ),
    );
  }

  // DIALOG KONFIRMASI HAPUS
  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, Movie movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,

        title: const Text(
          "Hapus Film",
          style: TextStyle(color: Colors.white),
        ),

        content: Text(
          'Apakah Anda yakin ingin menghapus "${movie.title}" dari daftar saya?',
          style: const TextStyle(color: Colors.white70),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              ref.read(myListProvider.notifier).toggleMovie(movie);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${movie.title}" dihapus dari daftar saya'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
