import 'package:flutter/material.dart';
import 'login_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPlan;

  final List<Map<String, String>> plans = [
    {
      "title": "3 Bulan",
      "price": "Rp79.000",
      "note": "Akses premium selama 3 bulan",
    },
    {
      "title": "6 Bulan",
      "price": "Rp139.000",
      "note": "Hemat 10% dibanding bulanan",
    },
    {
      "title": "1 Tahun",
      "price": "Rp259.000",
      "note": "Hemat 25% dan bebas iklan",
    },
  ];

  void confirmPayment() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget buildPlanCard(Map<String, String> plan) {
    final bool isSelected = selectedPlan == plan["title"];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = plan["title"];
        });
      },
      child: Container(
        width: 300, 
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18), // lebih kecil
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              plan["title"]!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              plan["price"]!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              plan["note"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12, 
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Pilih Paket Langganan",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              ...plans.map((plan) => buildPlanCard(plan)).toList(),

              const SizedBox(height: 20),

              // === TOMBOL KONFIRMASI ===
              SizedBox(
                width: 260, 
                height: 48,
                child: ElevatedButton(
                  onPressed: selectedPlan == null ? null : confirmPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    disabledBackgroundColor: Colors.white12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Konfirmasi Pembayaran",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
