import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/download_provider.dart';
import '../models/movie.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloads = ref.watch(downloadProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        // =========================
        //     TOMBOL BACK FIXED
        // =========================
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // KEMBALI KE HALAMAN SEBELUMNYA (HOME)
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Download",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      body: downloads.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film yang di-download",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: downloads.length,
              itemBuilder: (context, index) {
                Movie movie = downloads[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

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

                  // TOMBOL HAPUS
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
  //       DIALOG KONFIRMASI
  // =============================
  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, Movie movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,

        title: const Text(
          "Hapus Download",
          style: TextStyle(color: Colors.white),
        ),

        content: Text(
          'Apakah Anda yakin ingin menghapus download "${movie.title}"?',
          style: const TextStyle(color: Colors.white70),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.white)),
          ),

          TextButton(
            onPressed: () {
              ref.read(downloadProvider.notifier).removeDownload(movie);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    '"${movie.title}" telah dihapus dari Download',
                  ),
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
