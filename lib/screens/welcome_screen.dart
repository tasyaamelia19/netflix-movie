import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedLanguage = "Bahasa Indonesia";

  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          color: Colors.black.withOpacity(0.65),

          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTopNavbar(context),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      const Text(
                        "Film dan serial TV\n"
                        "tanpa batas, dan lebih\n"
                        "banyak lagi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Harga mulai dari Rp54.000. Batalkan kapan pun.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Siap menonton? Masukkan email untuk membuat atau memulai lagi keanggotaanmu.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),

                      const SizedBox(height: 25),

                      TextField(
                        controller: emailCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black54,
                          hintText: "Alamat email",
                          hintStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white54),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // BUTTON MULAI — FIXED
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {
                            GoRouter.of(context).go("/register");
                          },
                          child: const Text(
                            "Mulai",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                      buildReasonSection(),
                      const SizedBox(height: 40),
                      buildFAQSection(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TOP NAVBAR
  Widget buildTopNavbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: const Border(bottom: BorderSide(color: Colors.white12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "NETFLIX",
            style: TextStyle(
              color: Colors.red,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            children: [
              GestureDetector(
                onTap: showLanguageDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.language, color: Colors.white, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        selectedLanguage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).go("/login");
                },
                child: const Text("Masuk", style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // LANGUAGE DIALOG
  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Pilih Bahasa",
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            height: 300,
            child: ListView(
              children: [
                buildLangItem("Bahasa Indonesia"),
                buildLangItem("English"),
                buildLangItem("한국어 (Korean)"),
                buildLangItem("日本語 (Japanese)"),
                buildLangItem("中文 (Chinese)"),
                buildLangItem("Español (Spanish)"),
                buildLangItem("Français (French)"),
                buildLangItem("Deutsch (German)"),
                buildLangItem("Português (Portuguese)"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLangItem(String lang) {
    return ListTile(
      title: Text(lang, style: const TextStyle(color: Colors.white)),
      onTap: () {
        setState(() => selectedLanguage = lang);
        Navigator.pop(context);
      },
    );
  }

  // REASON SECTION
  Widget buildReasonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Alasan Lainnya untuk Bergabung",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            buildCard(
              "Nikmati di TV-mu",
              "Tonton di Smart TV, Playstation, Xbox, Chromecast, Apple TV, dan lainnya.",
            ),
            buildCard(
              "Download serial offline",
              "Simpan favoritmu agar selalu bisa ditonton.",
            ),
            buildCard(
              "Tonton di mana pun",
              "Streaming tanpa batas di ponsel, laptop, tablet, dan TV.",
            ),
            buildCard(
              "Buat profil untuk anak",
              "Biarkan anak menikmati tontonan yang ramah anak.",
            ),
          ],
        ),
      ],
    );
  }

  // CARD UNTUK REASON
  Widget buildCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // FAQ SECTION
  Widget buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tanya Jawab Umum",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        buildFAQItem("Apa itu Netflix?"),
        buildFAQItem("Berapa biaya berlangganan Netflix?"),
        buildFAQItem("Di mana saya bisa menonton?"),
        buildFAQItem("Bagaimana cara membatalkannya?"),
        buildFAQItem("Apa yang bisa ditonton di Netflix?"),
        buildFAQItem("Apakah Netflix sesuai untuk anak-anak?"),
      ],
    );
  }

  // ITEM FAQ
  Widget buildFAQItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Icon(Icons.add, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}
