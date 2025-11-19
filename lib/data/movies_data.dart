import '../models/movie.dart';

//  Trending Now
final List<Movie> trendingMovies = [
  Movie(
    title: "Norma",
    imageUrl: "assets/images/norma.jpeg",
    genre: "Horror",
    rating: 8.7,
    description: "Stranger Things is a sci-fi horror series...",
  ),
  Movie(
    title: "Home Sweet Alone",
    imageUrl: "assets/images/home.jpeg",
    genre: "Action",
    rating: 7.3,
    description: "Action movie starring Chris Hemsworth...",
  ),
  Movie(
    title: "Wednesday",
    imageUrl: "assets/images/wednesday.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
  ),
   Movie(
    title: "Woard Warz 2",
    imageUrl: "assets/images/woardwarz.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
  ),
  Movie(
    title: "1 Kakak 7 Ponakan",
    imageUrl: "assets/images/kakak.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
  ),
  Movie(
    title: "The Nun",
    imageUrl: "assets/images/thenunvalak.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
  ),
  Movie(
    title: "Evil Dead Rise",
    imageUrl: "assets/images/evildeadrisehorror.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
  ),
];

// ⭐ Popular
final List<Movie> popularMovies = [
  Movie(
    title: "Avengers Endgame",
    imageUrl: "assets/images/endgame.jpg",
    genre: "Action",
    rating: 8.4,
    description: "The final battle of Avengers...",
  ),
  Movie(
    title: "The Witcher",
    imageUrl: "assets/images/witcher.jpg",
    genre: "Fantasy",
    rating: 8.1,
    description: "Geralt the monster hunter...",
  ),
];

// ⭐ New Releases
final List<Movie> newMovies = [
  Movie(
    title: "Lift",
    imageUrl: "assets/images/lift.jpg",
    genre: "Action",
    rating: 7.1,
    description: "Heist movie starring Kevin Hart...",
  ),
];

// ⭐ Coming Soon
final List<Movie> comingSoonMovies = [
  Movie(
    title: "Rebel Moon 2",
    imageUrl: "assets/images/rebelmoon2.jpg",
    genre: "Sci-fi",
    rating: 7.9,
    description: "Coming soon on Netflix...",
  ),
];

// ⭐ Downloads For You
final List<Movie> downloadMovies = [
  Movie(
    title: "Enola Holmes",
    imageUrl: "assets/images/enola.jpg",
    genre: "Mystery",
    rating: 7.2,
    description: "Movie about Sherlock Holmes' sister...",
  ),
];

// ⭐ All movies untuk MovieRow — gabung semua
final List<Movie> allMovies = [
  ...trendingMovies,
  ...popularMovies,
  ...newMovies,
  ...comingSoonMovies,
  ...downloadMovies,
];
