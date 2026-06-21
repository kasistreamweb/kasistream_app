import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../controllers/wallet_controller.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = "wallet";

  int get adminFee => 1500;

  final List<PaymentMethod> methods = [
    PaymentMethod.withCode(
      'wallet',
      'Wallet KAistream',
      Icons.account_balance_wallet,
    ),
    PaymentMethod.withCode('qris', 'QRIS', Icons.qr_code),
    PaymentMethod.withCode('ovo', 'OVO', Icons.account_balance_wallet),
    PaymentMethod.withCode('dana', 'DANA', Icons.account_balance_wallet),
    PaymentMethod.withCode('gopay', 'GoPay', Icons.account_balance_wallet),
    PaymentMethod.withCode('bca_va', 'BCA VA', Icons.account_balance),
    PaymentMethod.withCode('bni_va', 'BNI VA', Icons.account_balance),
    PaymentMethod.withCode('bri_va', 'BRI VA', Icons.account_balance),
    PaymentMethod.withCode('mandiri_va', 'Mandiri VA', Icons.account_balance),
  ];

  String getSubtitle(String title) {
    switch (title) {
      case 'Wallet KAistream':
        return 'Gunakan saldo wallet';
      case 'QRIS':
        return 'Scan QR menggunakan aplikasi pembayaran';
      case 'OVO':
        return 'Bayar dengan OVO';
      case 'DANA':
        return 'Bayar dengan DANA';
      case 'GoPay':
        return 'Bayar dengan GoPay';
      case 'BCA VA':
        return 'Transfer Virtual Account BCA';
      case 'BNI VA':
        return 'Transfer Virtual Account BNI';
      case 'BRI VA':
        return 'Transfer Virtual Account BRI';
      case 'Mandiri VA':
        return 'Transfer Virtual Account Mandiri';
      default:
        return '';
    }
  }

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map<String, dynamic>;

    // ── AMBIL STATUS GUEST ──
    final bool isGuest = data['is_guest'] == true;

    // Ambil data dari WalletController
    final walletController = Get.find<WalletController>();

    final int subtotal = int.tryParse(data["subtotal"].toString()) ?? 0;

    final int adminFee = int.tryParse(data["admin_fee"].toString()) ?? 1500;

    final int grandTotal = int.tryParse(data["total"].toString()) ?? 0;

    // Ambil saldo wallet dari controller
    final int walletBalance = walletController.balance.value;

    final bool walletEnough = walletBalance >= grandTotal;

    // Auto pindah metode jika saldo tidak cukup
    if (!walletEnough && selectedMethod == "wallet") {
      selectedMethod = "qris";
    }

    return Scaffold(
      backgroundColor: const Color(0xFF171533),
      appBar: AppBar(
        title: const Text("Metode Pembayaran"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // ── INFO SALDO WALLET ── (Hanya untuk User Login)
          if (!isGuest)
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF25245E),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xFF8B5CF6),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Saldo Wallet",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const Spacer(),
                  Obx(
                    () => Text(
                      "Rp ${rupiah(walletController.balance.value)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];
                final selected = selectedMethod == method.code;

                // ── DISABLE WALLET UNTUK GUEST ──
                final bool walletDisabled = isGuest
                    ? method.code == "wallet"
                    : method.code == "wallet" && !walletEnough;

                // ── HIDE WALLET UNTUK GUEST ──
                if (isGuest && method.code == "wallet") {
                  return const SizedBox.shrink();
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: walletDisabled
                        ? Colors.grey.shade800
                        : selected
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF25245E),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF8B5CF6)
                          : Colors.white.withOpacity(0.05),
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    value: method.code,
                    groupValue: selectedMethod,
                    activeColor: Colors.white,
                    onChanged: walletDisabled
                        ? null
                        : (value) {
                            setState(() {
                              selectedMethod = value!;
                            });
                          },
                    title: Text(
                      method.title,
                      style: TextStyle(
                        color: walletDisabled
                            ? Colors.grey
                            : selected
                            ? Colors.white
                            : Colors.white,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      walletDisabled
                          ? "Saldo wallet tidak mencukupi"
                          : getSubtitle(method.title),
                      style: TextStyle(
                        color: walletDisabled
                            ? Colors.grey
                            : selected
                            ? Colors.white70
                            : Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    secondary: Icon(
                      method.icon,
                      color: walletDisabled
                          ? Colors.grey
                          : selected
                          ? Colors.white
                          : const Color(0xFF8B5CF6),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Bottom Section ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1C2147),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.05)),
              ),
            ),
            child: Column(
              children: [
                // Rincian Fee
                Column(
                  children: [
                    // Subtotal
                    Row(
                      children: [
                        const Text(
                          "Subtotal",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          "Rp ${rupiah(subtotal)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Admin Fee
                    Row(
                      children: [
                        const Text(
                          "Admin Fee",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          "Rp ${rupiah(adminFee)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    const Divider(color: Colors.white24, height: 24),

                    // Total Bayar
                    Row(
                      children: [
                        const Text(
                          "Total Bayar",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const Spacer(),
                        Text(
                          "Rp ${rupiah(grandTotal)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

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
                    onPressed: () {
                      try {
                        data["payment_method"] = selectedMethod;
                        data["admin_fee"] = adminFee;
                        data["grand_total"] = grandTotal;

                        print("=== NAVIGASI KE PAYMENT SUMMARY ===");
                        print("Route: ${Routes.paymentSummary}");
                        print("Data: $data");

                        Get.toNamed(Routes.paymentSummary, arguments: data);

                        print("Navigasi berhasil dipanggil");
                      } catch (e) {
                        print("Error: $e");
                        Get.snackbar(
                          "Error",
                          "Terjadi kesalahan: $e",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
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
                      "LANJUTKAN",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethod {
  final String code;
  final String title;
  final IconData icon;

  PaymentMethod.withCode(this.code, this.title, this.icon);
}
