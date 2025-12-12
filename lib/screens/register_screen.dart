import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ➤ Tambahkan import GoRouter

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  DateTime? selectedDate; // tanggal lahir tersimpan di sini

  // MEMBUKA DATE PICKER
  Future<void> pickDate() async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 1, 1),
      firstDate: DateTime(1950),
      lastDate: now,
      helpText: "Pilih tanggal lahir",
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.red.shade700,
              surface: Colors.grey.shade900,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Daftar Akun", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Bisa diganti GoRouter.of(context).pop()
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 360,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- NAMA LENGKAP ---
                buildInput("Nama Lengkap", nameCtrl),

                const SizedBox(height: 16),

                // --- TANGGAL LAHIR ---
                GestureDetector(
                  onTap: pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate == null
                              ? "Tanggal Lahir"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          style: TextStyle(
                            color: selectedDate == null
                                ? Colors.white54
                                : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.calendar_month,
                            color: Colors.white70),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // --- EMAIL ---
                buildInput("Email", emailCtrl),

                const SizedBox(height: 16),

                // --- NOMOR TELEPON ---
                buildInput("Nomor Telepon", phoneCtrl,
                    type: TextInputType.phone),

                const SizedBox(height: 16),

                // --- PASSWORD ---
                buildInput("Password", passCtrl, isPassword: true),

                const SizedBox(height: 30),

                // --- TOMBOL DAFTAR ---
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Mohon pilih tanggal lahir")),
                        );
                        return;
                      }

                      // ➤ DIGANTI MENGGUNAKAN GO ROUTER
                      GoRouter.of(context).go("/payment");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Lanjutkan ke Pembayaran",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET INPUT GENERAL
  Widget buildInput(String hint, TextEditingController ctrl,
      {bool isPassword = false, TextInputType type = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      obscureText: isPassword,
      keyboardType: type,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white24),
        ),
      ),
    );
  }
}
