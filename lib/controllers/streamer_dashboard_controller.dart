import 'package:get/get.dart';

import '../app/services/streamer_dashboard_service.dart';

class StreamerDashboardController extends GetxController {
  final StreamerDashboardService _service = StreamerDashboardService();

  RxBool isLoading = false.obs;

  RxInt totalDonasi = 0.obs;
  RxInt totalDonatur = 0.obs;
  RxInt totalTransaksi = 0.obs;
  RxInt donasiTerbesar = 0.obs;
  RxInt rataRata = 0.obs;
  RxString topDonatur = ''.obs;

  RxList recentDonations = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      final result = await _service.getDashboard();

      print('=== STREAMER DASHBOARD RESULT ===');
      print('Result: $result');

      if (result['success'] == true) {
        final data = result['data'];

        // ── PARSE DENGAN AMAN ──
        totalDonasi.value = int.tryParse(data['total_donasi'].toString()) ?? 0;

        totalDonatur.value =
            int.tryParse(data['total_donatur'].toString()) ?? 0;

        totalTransaksi.value =
            int.tryParse(data['total_transaksi'].toString()) ?? 0;

        donasiTerbesar.value =
            int.tryParse(data['donasi_terbesar'].toString()) ?? 0;

        rataRata.value = int.tryParse(data['rata_rata'].toString()) ?? 0;

        topDonatur.value = data['top_donatur']?.toString() ?? '-';

        recentDonations.value = data['recent_donations'] ?? [];
      }
    } catch (e) {
      print('ERROR load dashboard: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
