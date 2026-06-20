import 'package:get/get.dart';

import '../app/services/donation_service.dart';

class DonationController extends GetxController {
  final DonationService _service = DonationService();

  RxBool isLoading = false.obs;

  Future<bool> donate({
    required int streamerId,
    required int nominal,
    required String pesan,
  }) async {
    try {
      isLoading.value = true;

      final result = await _service.donate(
        streamerId: streamerId,
        nominal: nominal,
        pesan: pesan,
      );

      return true;
    } finally {
      isLoading.value = false;
    }
  }

  // ── GUEST DONATE ──
  Future<Map<String, dynamic>> guestDonate({
    required int streamerId,
    required String guestName,
    required String guestPhone,
    required int nominal,
    required String pesan,
  }) async {
    try {
      isLoading.value = true;

      return await _service.guestCreateQris(
        streamerId: streamerId,
        guestName: guestName,
        guestPhone: guestPhone,
        nominal: nominal,
        pesan: pesan,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
