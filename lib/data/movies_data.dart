import '../models/movie.dart';

//  Trending Now
final List<Movie> trendingMovies = [
  Movie(
    title: "Norma",
    imageUrl: "assets/images/norma.jpeg",
    genre: "Horror",
    rating: 8.7,
    description: "Stranger Things is a sci-fi horror series...",
    subtitles: {
      "ID": [
        "Norma sedang berjalan sendirian di malam hari...",
        "Suara misterius terdengar di kejauhan...",
      ],
      "EN": [
        "Norma is walking alone at night...",
        "A mysterious sound appears from the distance...",
      ],
    },
  ),
  Movie(
    title: "Home Sweet Alone",
    imageUrl: "assets/images/home.jpeg",
    genre: "Action",
    rating: 7.3,
    description: "Action movie starring Chris Hemsworth...",
    subtitles: {
      "ID": [
        "Rumah itu tampak tenang dari luar...",
        "Namun ada seseorang yang sedang mengintai...",
      ],
      "EN": [
        "The house looked calm from the outside...",
        "But someone is secretly watching...",
      ],
    },
  ),
  Movie(
    title: "Wednesday",
    imageUrl: "assets/images/wednesday.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
    subtitles: {
      "ID": [
        "Wednesday menatap tajam ke arah kamera...",
        "Dia sedang merencanakan sesuatu...",
      ],
      "EN": [
        "Wednesday looks directly at the camera...",
        "She is planning something...",
      ],
    },
  ),
  Movie(
    title: "Woard Warz 2",
    imageUrl: "assets/images/woardwarz.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
    subtitles: {
      "ID": ["Para zombie mulai menyerang kota..."],
      "EN": ["The zombies start attacking the city..."],
    },
  ),
  Movie(
    title: "1 Kakak 7 Ponakan",
    imageUrl: "assets/images/kakak.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
    subtitles: {
      "ID": ["Satu kakak harus mengurus tujuh ponakan..."],
      "EN": ["One sister must take care of seven nieces..."],
    },
  ),
  Movie(
    title: "The Nun",
    imageUrl: "assets/images/thenunvalak.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
    subtitles: {
      "ID": ["Sosok biarawati gelap muncul di kegelapan..."],
      "EN": ["A dark nun figure appears in the shadows..."],
    },
  ),
  Movie(
    title: "Evil Dead Rise",
    imageUrl: "assets/images/evildeadrisehorror.jpeg",
    genre: "Romance",
    rating: 7.0,
    description: "Teen romance movie...",
    subtitles: {
      "ID": ["Kegelapan mulai menguasai gedung apartemen..."],
      "EN": ["Darkness begins to consume the apartment..."],
    },
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
    subtitles: {
      "ID": ["Pertarungan terakhir para Avenger dimulai!"],
      "EN": ["The final battle of the Avengers begins!"],
    },
  ),
  Movie(
    title: "The Witcher",
    imageUrl: "assets/images/witcher.jpg",
    genre: "Fantasy",
    rating: 8.1,
    description: "Geralt the monster hunter...",
    subtitles: {
      "ID": ["Geralt sedang memburu monster berbahaya..."],
      "EN": ["Geralt is hunting a dangerous monster..."],
    },
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
    subtitles: {
      "ID": ["Tim tersebut mulai merencanakan pencurian besar..."],
      "EN": ["The team begins planning the major heist..."],
    },
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
    subtitles: {
      "ID": ["Kisah epik Rebel Moon berlanjut..."],
      "EN": ["The epic story of Rebel Moon continues..."],
    },
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
    subtitles: {
      "ID": ["Enola sedang menyelidiki petunjuk misterius..."],
      "EN": ["Enola investigates a mysterious clue..."],
    },
  ),
];

// ⭐ All movies untuk MovieRow
final List<Movie> allMovies = [
  ...trendingMovies,
  ...popularMovies,
  ...newMovies,
  ...comingSoonMovies,
  ...downloadMovies,
];
