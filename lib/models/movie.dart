class Movie {
  final String title;
  final String imageUrl;
  final String genre;
  final double rating;
  final String description;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.rating,
    required this.description,
  });

  // Tambahkan ini agar .contains() bisa bekerja
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.genre == genre &&
        other.rating == rating &&
        other.description == description;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      imageUrl.hashCode ^
      genre.hashCode ^
      rating.hashCode ^
      description.hashCode;
}
