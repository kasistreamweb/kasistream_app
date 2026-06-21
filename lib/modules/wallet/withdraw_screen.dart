import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../controllers/wallet_controller.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final WalletController controller = Get.find<WalletController>();

  final nominalController = TextEditingController();
  final rekeningController = TextEditingController();
  final namaController = TextEditingController();

  String? selectedBank;

  final List<String> banks = [
    'BCA',
    'BNI',
    'BRI',
    'Mandiri',
    'BSI',
    'CIMB Niaga',
    'Permata',
    'Dana',
    'OVO',
    'GoPay',
    'ShopeePay',
  ];

  int get nominal =>
      int.tryParse(nominalController.text.replaceAll('.', '')) ?? 0;

  String formatCurrency(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }

  Future<void> submitWithdraw() async {
    if (nominal < 10000) {
      Get.snackbar('Gagal', 'Minimal withdraw Rp 10.000');
      return;
    }

    if (selectedBank == null) {
      Get.snackbar('Gagal', 'Pilih bank atau e-wallet');
      return;
    }

    if (rekeningController.text.isEmpty) {
      Get.snackbar('Gagal', 'Nomor rekening wajib diisi');
      return;
    }

    if (namaController.text.isEmpty) {
      Get.snackbar('Gagal', 'Nama pemilik rekening wajib diisi');
      return;
    }

    final success = await controller.withdraw(
      nominal: nominal,
      bank: selectedBank!,
      rekening: rekeningController.text,
      namaRekening: namaController.text,
    );

    if (success) {
      await controller.loadWallet();

      // Redirect ke wallet screen dengan navbar
      Get.offAllNamed(Routes.main);

      Get.snackbar(
        'Berhasil',
        'Permintaan withdraw berhasil dikirim',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B26),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tarik Dana',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1738),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2147),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ℹ️ Ketentuan Withdraw',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '• Minimal withdraw Rp 10.000',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '• Permintaan akan diverifikasi admin',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '• Dana akan dikirim ke rekening atau e-wallet yang didaftarkan',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '• Pastikan data penerima benar',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _label('Nominal Withdraw'),

              _textField(
                controller: nominalController,
                hint: 'Minimal Rp 10.000',
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  setState(() {});
                },
              ),

              const SizedBox(height: 16),

              _label('Bank / E-Wallet'),

              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1C2147),
                value: selectedBank,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Pilih Bank / E-Wallet'),
                items: banks
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBank = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              _label('Nomor Rekening / E-Wallet'),

              _textField(
                controller: rekeningController,
                hint: 'Masukkan nomor rekening',
              ),

              const SizedBox(height: 16),

              _label('Nama Pemilik Rekening'),

              _textField(
                controller: namaController,
                hint: 'Masukkan nama pemilik rekening',
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF35255F), Color(0xFF31183F)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Jumlah yang Akan Ditarik',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rp ${formatCurrency(nominal)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : submitWithdraw,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7C3AED).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Kirim Permintaan Withdraw',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Info tambahan
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange[400],
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Pastikan data rekening benar. Proses verifikasi membutuhkan waktu 1x24 jam.',
                        style: TextStyle(color: Colors.orange, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: const Color(0xFF1C2147),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
