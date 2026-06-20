import 'package:get/get.dart';

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

      return true;
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

      history.value = await _service.getHistory();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadWallet();
  }
}
