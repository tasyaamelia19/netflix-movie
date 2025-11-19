import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_settings_notifier.dart';

class NetflixAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const NetflixAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(95);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.2),
      elevation: 0,
      centerTitle: true,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
      ),

      // ====== BAGIAN LOGO + MENU ======
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // === LOGO DI TENGAH ===
          const Text(
            "Netflix",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // === MENU DI TENGAH ===
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Beranda", style: TextStyle(fontSize: 12)),
              SizedBox(width: 15),
              Text("Serial", style: TextStyle(fontSize: 12)),
              SizedBox(width: 15),
              Text("Film", style: TextStyle(fontSize: 12)),
              SizedBox(width: 15),
              Text("Baru & Populer", style: TextStyle(fontSize: 12)),
              SizedBox(width: 15),
              Text("Daftar Saya", style: TextStyle(fontSize: 12)),
              SizedBox(width: 15),
              Text("Help", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),

      // === SEARCH SEDERHANA DI KANAN ATAS ===
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.white, size: 22),
              const SizedBox(width: 6),
              Text(
                settings.search.isEmpty ? "Search" : settings.search,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
