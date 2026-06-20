import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/services/donation_service.dart';
import '../../app/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/wallet_controller.dart';
import '../../models/streamer_model.dart';

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key});

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  String getPaymentMethodName(String code) {
    switch (code) {
      case 'wallet':
        return 'Wallet KAistream';
      case 'qris':
        return 'QRIS';
      case 'ovo':
        return 'OVO';
      case 'dana':
        return 'DANA';
      case 'gopay':
        return 'GoPay';
      case 'bca_va':
        return 'BCA Virtual Account';
      case 'bni_va':
        return 'BNI Virtual Account';
      case 'bri_va':
        return 'BRI Virtual Account';
      case 'mandiri_va':
        return 'Mandiri Virtual Account';
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("=== PAYMENT SUMMARY SCREEN BUILD ===");
    final data = Get.arguments as Map<String, dynamic>;
    print("Data: $data");

    final StreamerModel streamer = data['streamer'];
    final int nominal = data['nominal'] ?? 0;
    final int fitur = data['fitur'] ?? 0;
    final int subtotal = data['subtotal'] ?? 0;
    final int adminFee = data['admin_fee'] ?? 1500;
    final int grandTotal = data['total'] ?? 0;
    final String pesan = data['pesan'] ?? '';
    final String paymentMethod = data['payment_method'] ?? 'wallet';
    final bool voiceNote = data['voice_note'] ?? false;
    final bool video = data['video'] ?? false;
    final bool highlight = data['highlight'] ?? false;
    final bool pin = data['pin'] ?? false;

    final walletController = Get.find<WalletController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFF171533),
      appBar: AppBar(
        title: const Text(
          "Detail Pembayaran",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF171533), Color(0xFF24205A), Color(0xFF322C7A)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF25245E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.receipt_long,
                        color: Color(0xFF8B5CF6),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Detail Pembayaran",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Periksa kembali detail donasi sebelum melanjutkan pembayaran",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Streamer Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF25245E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xFF8B5CF6),
                      backgroundImage:
                          streamer.foto != null && streamer.foto!.isNotEmpty
                          ? NetworkImage(streamer.foto!)
                          : null,
                      child: streamer.foto == null || streamer.foto!.isEmpty
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            streamer.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            streamer.game ?? "Streamer",
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${streamer.followers} followers",
                        style: const TextStyle(
                          color: Color(0xFFB09EFF),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Rincian Donasi
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF25245E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rincian Donasi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _summaryRow("Nominal Donasi", "Rp ${rupiah(nominal)}"),
                    if (fitur > 0) ...[
                      const SizedBox(height: 8),
                      _summaryRow("Fitur Tambahan", "Rp ${rupiah(fitur)}"),
                    ],
                    if (voiceNote) ...[
                      const SizedBox(height: 8),
                      _summaryRow("Voice Note", "+ Rp 5.000"),
                    ],
                    if (video) ...[
                      const SizedBox(height: 8),
                      _summaryRow("Video Pendek", "+ Rp 10.000"),
                    ],
                    if (highlight) ...[
                      const SizedBox(height: 8),
                      _summaryRow("Highlight Donasi", "+ Rp 15.000"),
                    ],
                    if (pin) ...[
                      const SizedBox(height: 8),
                      _summaryRow("Pin Pesan", "+ Rp 20.000"),
                    ],
                    if (pesan.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _summaryRow("Pesan", pesan),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Metode Pembayaran
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF25245E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        paymentMethod == 'wallet'
                            ? Icons.account_balance_wallet
                            : paymentMethod == 'qris'
                            ? Icons.qr_code
                            : Icons.payment,
                        color: const Color(0xFF8B5CF6),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            getPaymentMethodName(paymentMethod),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      paymentMethod == 'wallet'
                          ? Icons.account_balance_wallet
                          : Icons.qr_code,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Ringkasan Pembayaran
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF25245E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ringkasan Pembayaran",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _summaryRow("Subtotal", "Rp ${rupiah(subtotal)}"),
                    const SizedBox(height: 8),
                    _summaryRow("Biaya Admin", "Rp ${rupiah(adminFee)}"),
                    const Divider(color: Colors.white24, height: 24),
                    Row(
                      children: [
                        const Text(
                          "Total Pembayaran",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Rp ${rupiah(grandTotal)}",
                          style: const TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Status Saldo Wallet
              if (paymentMethod == 'wallet') ...[
                Obx(
                  () => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: walletController.balance.value >= grandTotal
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: walletController.balance.value >= grandTotal
                            ? Colors.green.withOpacity(0.3)
                            : Colors.red.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          walletController.balance.value >= grandTotal
                              ? Icons.check_circle
                              : Icons.warning,
                          color: walletController.balance.value >= grandTotal
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            walletController.balance.value >= grandTotal
                                ? "Saldo wallet mencukupi"
                                : "Saldo wallet tidak mencukupi. Silahkan pilih metode pembayaran lain.",
                            style: TextStyle(
                              color:
                                  walletController.balance.value >= grandTotal
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // ── TOMBOL KONFIRMASI & BAYAR ──
              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D5BFF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final streamer = data["streamer"];
                      final pesan = data["pesan"] ?? '';

                      // ── WALLET ──
                      if (paymentMethod == 'wallet') {
                        final result = await DonationService().donate(
                          streamerId: streamer.id,
                          nominal: nominal,
                          pesan: pesan,
                        );

                        if (result['success'] != true) {
                          Get.snackbar(
                            'Gagal',
                            result['message'] ?? 'Donasi gagal',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        await walletController.loadWallet();
                        await authController.refreshUser();

                        Get.offAllNamed(
                          Routes.paymentSuccess,
                          arguments: {'donasi_id': result['data']['id']},
                        );
                        return;
                      }

                      // ── QRIS ──
                      if (paymentMethod == 'qris') {
                        final result = await DonationService().createQris(
                          streamerId: streamer.id,
                          nominal: nominal,
                          pesan: pesan,
                        );

                        if (result['success'] != true) {
                          Get.snackbar(
                            'Gagal',
                            result['message'] ?? 'Gagal membuat QRIS',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        final qris = result['data'];

                        Get.offNamed(
                          Routes.paymentQris,
                          arguments: {'donasi_id': qris['id']},
                        );
                        return;
                      }

                      Get.snackbar(
                        'Info',
                        'Metode pembayaran ini akan dibuat pada tahap berikutnya',
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        e.toString(),
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "KONFIRMASI & BAYAR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _summaryRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
