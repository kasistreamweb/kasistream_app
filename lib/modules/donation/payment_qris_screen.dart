import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/services/donation_service.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart'; // TAMBAHKAN IMPORT

class PaymentQrisScreen extends StatefulWidget {
  const PaymentQrisScreen({super.key});

  @override
  State<PaymentQrisScreen> createState() => _PaymentQrisScreenState();
}

class _PaymentQrisScreenState extends State<PaymentQrisScreen> {
  final DonationService _service = DonationService();

  Timer? timer;

  bool checking = false;
  bool loading = true;

  Map<String, dynamic>? payment;

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
  }

  @override
  void initState() {
    super.initState();
    loadPayment();
  }

  // ── LOAD PAYMENT DETAIL ──
  Future<void> loadPayment() async {
    try {
      final int donasiId =
          int.tryParse(Get.arguments['donasi_id'].toString()) ?? 0;

      final result = await DonationService().getPaymentDetail(donasiId);

      print('=== LOAD PAYMENT DETAIL ===');
      print('Result: $result');

      if (result['success'] == true) {
        setState(() {
          payment = result['data'];
          loading = false;
        });

        // Mulai cek setelah data dimuat
        startChecking();
      } else {
        setState(() {
          loading = false;
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
        loading = false;
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

  void startChecking() {
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await checkPayment();
    });
  }

  // ── CHECK PAYMENT ──
  Future<void> checkPayment() async {
    if (checking) return;

    checking = true;

    try {
      final int donasiId =
          int.tryParse(Get.arguments['donasi_id'].toString()) ?? 0;

      final result = await DonationService().checkPayment(donasiId);

      print('=== CHECK PAYMENT RESULT ===');
      print('Result: $result');

      if (result['status'] == 'success') {
        timer?.cancel();

        await Get.find<AuthController>().refreshUser();

        // ── TAMBAHKAN INI ──
        await Get.find<DashboardController>().loadDashboard();

        Get.offAllNamed(
          Routes.paymentSuccess,
          arguments: {'donasi_id': donasiId},
        );
      }
    } catch (e) {
      print('Error check payment: $e');
    }

    checking = false;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parse angka dari API
    final int nominal =
        int.tryParse(payment?['nominal']?.toString() ?? '0') ?? 0;

    final int adminFee =
        int.tryParse(payment?['admin_fee']?.toString() ?? '0') ?? 0;

    final int grandTotal =
        int.tryParse(payment?['grand_total']?.toString() ?? '0') ?? 0;

    final String status = payment?['status']?.toString() ?? 'pending';
    final String streamerName = payment?['streamer_name']?.toString() ?? '-';
    final String qrImage = payment?['qr_image']?.toString() ?? '';
    final int donasiId = int.tryParse(payment?['id']?.toString() ?? '0') ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFF171533),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Pembayaran QRIS',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ── QRIS CARD ──
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25245E),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.qr_code,
                          size: 70,
                          color: Color(0xFF8B5CF6),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Scan QRIS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── QR IMAGE ──
                        if (qrImage.isNotEmpty)
                          Image.network(
                            qrImage,
                            width: 260,
                            height: 260,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    'QR Code tidak tersedia',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                              );
                            },
                          )
                        else
                          Container(
                            width: 260,
                            height: 260,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner,
                                    size: 60,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'QR Code belum tersedia',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // ── TOTAL ──
                        Text(
                          'Rp ${rupiah(grandTotal)}',
                          style: const TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Silahkan scan QRIS menggunakan aplikasi pembayaran Anda',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),

                        const SizedBox(height: 16),

                        // ── STATUS ──
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: status == 'success'
                                ? Colors.green.withOpacity(0.15)
                                : Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              color: status == 'success'
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── DETAIL TRANSAKSI ──
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
                          'Detail Transaksi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _detailRow('ID Transaksi', '#TRX$donasiId'),
                        const SizedBox(height: 8),
                        _detailRow('Streamer', streamerName),
                        const SizedBox(height: 8),
                        _detailRow('Nominal', 'Rp ${rupiah(nominal)}'),
                        const SizedBox(height: 8),
                        _detailRow('Admin Fee', 'Rp ${rupiah(adminFee)}'),
                        const SizedBox(height: 8),
                        _detailRow('Metode', 'QRIS'),
                        const SizedBox(height: 8),
                        _detailRow(
                          'Status',
                          status.toUpperCase(),
                          status: true,
                        ),
                        const Divider(color: Colors.white24, height: 20),
                        _detailRow(
                          'Total',
                          'Rp ${rupiah(grandTotal)}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── TOMBOL CEK PEMBAYARAN ──
                  Container(
                    width: double.infinity,
                    height: 56,
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
                          final int donasiId =
                              int.tryParse(
                                Get.arguments['donasi_id'].toString(),
                              ) ??
                              0;

                          final result = await DonationService().checkPayment(
                            donasiId,
                          );

                          print('=== CEK PEMBAYARAN MANUAL ===');
                          print('Result: $result');

                          if (result['status'] == 'success') {
                            timer?.cancel();

                            await Get.find<AuthController>().refreshUser();

                            // ── TAMBAHKAN INI ──
                            await Get.find<DashboardController>()
                                .loadDashboard();

                            Get.offAllNamed(
                              Routes.paymentSuccess,
                              arguments: {'donasi_id': donasiId},
                            );
                          } else {
                            Get.snackbar(
                              'Pending',
                              'Pembayaran belum diterima',
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Gagal mengecek pembayaran: $e',
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
                        'Cek Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── TOMBOL BAYAR DENGAN ONOPAY ──
                  Container(
                    width: double.infinity,
                    height: 56,
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
                          final int donasiId =
                              int.tryParse(
                                Get.arguments['donasi_id'].toString(),
                              ) ??
                              0;

                          final result = await DonationService().payOnopay(
                            donasiId,
                          );

                          print('=== PAY ONOPAY RESULT ===');
                          print('Result: $result');

                          if (result['success'] == true) {
                            timer?.cancel();

                            await Get.find<AuthController>().refreshUser();

                            // ── TAMBAHKAN INI ──
                            await Get.find<DashboardController>()
                                .loadDashboard();

                            Get.offAllNamed(
                              Routes.paymentSuccess,
                              arguments: {'donasi_id': donasiId},
                            );
                          } else {
                            Get.snackbar(
                              'Gagal',
                              result['message'] ?? 'Pembayaran gagal',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(width: 8),
                          Text(
                            'Bayar dengan OnoPay',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── INFO ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.white54,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Halaman akan otomatis mengecek setiap 5 detik',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  Widget _detailRow(
    String label,
    String value, {
    bool bold = false,
    bool status = false,
  }) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.white60, fontSize: 13)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: status
                ? (value.toLowerCase() == 'success'
                      ? Colors.green
                      : Colors.orange)
                : Colors.white,
            fontSize: 13,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
