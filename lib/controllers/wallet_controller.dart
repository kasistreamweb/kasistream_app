import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Tambahkan import ini
import '../controllers/auth_controller.dart';
import '../app/services/wallet_service.dart';

class WalletController extends GetxController {
  final WalletService _service = WalletService();

  RxBool isLoading = false.obs;

  // Properties
  RxInt balance = 0.obs;
  RxInt totalDonasi = 0.obs;
  RxInt totalWithdraw = 0.obs;
  RxInt pendingWithdraw = 0.obs;
  RxList history = [].obs;

  Future<bool> withdraw({
    required int nominal,
    required String bank,
    required String rekening,
    required String namaRekening,
  }) async {
    try {
      isLoading.value = true;

      final result = await _service.withdraw(
        nominal: nominal,
        bank: bank,
        rekening: rekening,
        namaRekening: namaRekening,
      );

      if (result['success'] == true) {
        await loadWallet();
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Withdraw berhasil',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      }

      Get.snackbar(
        'Gagal',
        result['message'] ?? 'Withdraw gagal',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── METHOD LOAD WALLET ──
  Future<void> loadWallet() async {
    try {
      isLoading.value = true;

      final summary = await _service.getSummary();

      balance.value = int.tryParse(summary['balance'].toString()) ?? 0;

      totalDonasi.value = int.tryParse(summary['total_donasi'].toString()) ?? 0;

      totalWithdraw.value =
          int.tryParse(summary['total_withdraw'].toString()) ?? 0;

      pendingWithdraw.value =
          int.tryParse(summary['pending_withdraw'].toString()) ?? 0;

      // ── PERUBAHAN: Pilih history berdasarkan role user ──
      final auth = Get.find<AuthController>();

      if (auth.user.value?.isStreamer == true) {
        // Streamer: ambil history withdraw
        history.value = await _service.getHistory();
      } else {
        // User biasa: ambil history donasi
        history.value = await _service.getDonationHistory();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data wallet: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ── CLEAR DATA ──
  void clearData() {
    balance.value = 0;
    totalDonasi.value = 0;
    totalWithdraw.value = 0;
    pendingWithdraw.value = 0;
    history.clear();
  }

  @override
  void onInit() {
    super.onInit();
    loadWallet();
  }

  @override
  void onClose() {
    clearData();
    super.onClose();
  }
}
