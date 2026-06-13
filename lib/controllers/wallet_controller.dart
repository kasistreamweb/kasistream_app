import 'package:get/get.dart';

import '../app/services/wallet_service.dart';

class WalletController extends GetxController {
  final WalletService _service = WalletService();

  RxBool isLoading = false.obs;

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
}
