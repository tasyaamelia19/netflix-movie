import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';

final downloadProvider =
    StateNotifierProvider<DownloadNotifier, List<Movie>>(
  (ref) => DownloadNotifier(),
);

class DownloadNotifier extends StateNotifier<List<Movie>> {
  DownloadNotifier() : super([]);

  void addDownload(Movie movie) {
    if (!state.contains(movie)) {
      state = [...state, movie];
    }
  }

  void removeDownload(Movie movie) {
    state = state.where((m) => m != movie).toList();
  }
}
