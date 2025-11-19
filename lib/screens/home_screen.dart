import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/netflix_appbar.dart';
import '../widgets/genre_filter.dart';
import '../widgets/hero_banner.dart';
import '../widgets/movie_row.dart';
import '../widgets/bottom_navbar.dart';

// DATA
import '../data/movies_trending.dart';
import '../data/movies_popular.dart';
import '../data/movies_new_releases.dart';
import '../data/movies_coming_soon.dart';
import '../data/movies_downloads.dart';

import '../providers/app_settings_notifier.dart';

import 'my_list_screen.dart';
import 'download_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);

    //  ==========================
    //      LIST SCREEN NAVBAR
    //  ==========================
    final screens = [
      // BERANDA
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroBanner(featuredMovie: trendingMovies[0]),

            const SizedBox(height: 10),
            const GenreFilter(),

            MovieRow(
              title: "Trending Now",
              movies: trendingMovies,
              genreFilter: settings.genre,
              searchFilter: settings.search,
            ),
            MovieRow(
              title: "Popular",
              movies: popularMovies,
              genreFilter: settings.genre,
              searchFilter: settings.search,
            ),
            MovieRow(
              title: "New Releases",
              movies: newReleases,
              genreFilter: settings.genre,
              searchFilter: settings.search,
            ),
            MovieRow(
              title: "Coming Soon",
              movies: comingSoon,
              genreFilter: settings.genre,
              searchFilter: settings.search,
            ),
            MovieRow(
              title: "Downloads For You",
              movies: downloadForYou,
              genreFilter: settings.genre,
              searchFilter: settings.search,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // DAFTAR SAYA
      MyListScreen(),

      // DOWNLOAD
      const DownloadScreen(),

      // PROFIL (sementara kosong)
      const Center(
        child: Text("Halaman Profil",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,

      // AppBar hanya tampil saat index = 0 (Beranda)
      appBar: navIndex == 0 ? const NetflixAppBar() : null,

      bottomNavigationBar: BottomNavBar(
        index: navIndex,
        onTap: (i) {
          setState(() {
            navIndex = i;
          });
        },
      ),

      body: screens[navIndex],
    );
  }
}
