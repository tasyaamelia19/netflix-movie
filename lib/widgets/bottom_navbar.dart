import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: onTap,

      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,

      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),

      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        color: Colors.transparent, // agar label tersembunyi
      ),

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Beranda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Daftar Saya",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download),
          label: "Download",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Profil",
        ),
      ],
    );
  }
}
