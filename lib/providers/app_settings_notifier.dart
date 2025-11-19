import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingsNotifier extends ChangeNotifier {
  String genre = '';
  String search = '';
  String language = "ID";

  void setGenre(String value) {
    genre = value;
    notifyListeners();
  }

  void setSearch(String value) {
    search = value;
    notifyListeners();
  }

  void setLanguage(String value) {
    language = value;
    notifyListeners();
  }
}

final appSettingsProvider =
    ChangeNotifierProvider<AppSettingsNotifier>((ref) {
  return AppSettingsNotifier();
});
