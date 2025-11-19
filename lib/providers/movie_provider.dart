import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  final List<Movie> myList = [];
  final List<Movie> downloaded = [];

  /// ADD / REMOVE from My List
  void toggleMyList(Movie movie) {
    if (myList.contains(movie)) {
      myList.remove(movie);
    } else {
      myList.add(movie);
    }
    notifyListeners();
  }

  /// ADD / REMOVE from Download
  void toggleDownload(Movie movie) {
    if (downloaded.contains(movie)) {
      downloaded.remove(movie);
    } else {
      downloaded.add(movie);
    }
    notifyListeners();
  }
}
