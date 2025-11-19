import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/my_list_provider.dart';
import '../models/movie.dart';

class MyListScreen extends ConsumerWidget {
  MyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myList = ref.watch(myListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: const Text(
          "My List",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      body: myList.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film di daftar kamu",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Movie movie = myList[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),

                  // POSTER
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      movie.imageUrl,
                      width: 60,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // JUDUL
                  title: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

                  // TOMBOL HAPUS (X MERAH)
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 28),
                    onPressed: () {
                      _showDeleteDialog(context, ref, movie);
                    },
                  ),
                );
              },
            ),
    );
  }

  // =============================
  //        DIALOG HAPUS
  // =============================
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
            child: const Text("Batal",
                style: TextStyle(color: Colors.white)),
          ),

          TextButton(
            onPressed: () {
              ref.read(myListProvider.notifier).removeMovie(movie);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('"${movie.title}" telah dihapus'),
                ),
              );
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
