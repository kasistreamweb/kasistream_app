import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/services/donation_service.dart';
import '../../controllers/auth_controller.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  Map<String, dynamic>? payment;
  bool isLoading = true;

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  // ── LOAD PAYMENT ──
  Future<void> loadPayment() async {
    try {
      final int donasiId =
          int.tryParse(Get.arguments['donasi_id'].toString()) ?? 0;

      final result = await DonationService().getPaymentDetail(donasiId);

      print('=== PAYMENT SUCCESS - LOAD PAYMENT ===');
      print('Result: $result');

      if (result['success'] == true) {
        setState(() {
          payment = result['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal memuat detail pembayaran',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadPayment();
  }

  Widget buildRow(
    String title,
    String value, {
    Color valueColor = Colors.white,
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: bold ? 18 : 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF070B24),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
        ),
      );
    }

    // ── DATA DARI payment ──
    final String trxId = "#TRX${payment!['id']}";
    final String streamer = payment!['streamer_name'].toString();
    final String paymentMethod = payment!['payment_method'].toString();

    final int nominal = int.tryParse(payment!['nominal'].toString()) ?? 0;

    final int fitur = int.tryParse(payment!['fitur_total'].toString()) ?? 0;

    final int adminFee = int.tryParse(payment!['admin_fee'].toString()) ?? 0;

    final int total = int.tryParse(payment!['grand_total'].toString()) ?? 0;

    final String paymentTime = payment!['created_at'].toString();

    final bool isWallet = paymentMethod.toLowerCase().contains('wallet');

    return Scaffold(
      backgroundColor: const Color(0xFF070B24),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 80, color: Colors.white),
              ),

              const SizedBox(height: 24),

              const Text(
                "Pembayaran Berhasil!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Terima kasih atas dukunganmu 🎉",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),

              const SizedBox(height: 6),

              const Text(
                "Donasimu sangat berarti bagi streamer.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B42),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Detail Transaksi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    buildRow("ID Transaksi", trxId),

                    buildRow("Streamer", streamer),

                    buildRow("Nominal Donasi", "Rp ${rupiah(nominal)}"),

                    buildRow("Fitur Tambahan", "Rp ${rupiah(fitur)}"),

                    buildRow("Biaya Admin", "Rp ${rupiah(adminFee)}"),

                    const Divider(color: Colors.white24, height: 35),

                    buildRow(
                      "Total Pembayaran",
                      "Rp ${rupiah(total)}",
                      valueColor: const Color(0xFF4ADE80),
                      bold: true,
                    ),

                    const SizedBox(height: 12),

                    buildRow("Metode Pembayaran", paymentMethod),

                    buildRow("Waktu Pembayaran", paymentTime),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── INFO WALLET ──
              if (isWallet)
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B42),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF8B5CF6).withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Color(0xFF8B5CF6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Saldo Wallet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Saldo telah dikurangi sesuai pembayaran",
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Total: Rp ${rupiah(total)}",
                              style: const TextStyle(
                                color: Color(0xFFA78BFA),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // ── TOMBOL DONASI LAGI ──
              SizedBox(
                width: double.infinity,
                height: 58,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF4F46E5)],
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.offAllNamed('/main');
                    },
                    icon: const Icon(Icons.card_giftcard, color: Colors.white),
                    label: const Text(
                      "Donasi Lagi",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ── TOMBOL RIWAYAT ──
              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.toNamed('/history');
                  },
                  icon: const Icon(Icons.history, color: Colors.white),
                  label: const Text(
                    "Lihat Riwayat Donasi",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.15)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
