import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';

final myListProvider = StateNotifierProvider<MyListNotifier, List<Movie>>(
  (ref) => MyListNotifier(),
);

class MyListNotifier extends StateNotifier<List<Movie>> {
  MyListNotifier() : super([]);

  bool isSaved(Movie movie) {
    return state.contains(movie);
  }

  // Toggle: add/remove otomatis
  void toggleMovie(Movie movie) {
    if (isSaved(movie)) {
      removeMovie(movie);
    } else {
      addMovie(movie);
    }
  }

  // ADD MOVIE (WAJIB ADA)
  void addMovie(Movie movie) {
    if (!state.contains(movie)) {
      state = [...state, movie];
    }
  }

  // REMOVE MOVIE (WAJIB ADA)
  void removeMovie(Movie movie) {
    state = state.where((m) => m != movie).toList();
  }
}
