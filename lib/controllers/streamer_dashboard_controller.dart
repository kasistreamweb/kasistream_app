import 'package:get/get.dart';

import '../app/services/streamer_dashboard_service.dart';

class StreamerDashboardController extends GetxController {
  final StreamerDashboardService _service = StreamerDashboardService();

  // ── STATE ──
  final RxInt totalDonasi = 0.obs;
  final RxInt totalDonatur = 0.obs;
  final RxInt totalTransaksi = 0.obs;
  final RxInt donasiTerbesar = 0.obs;
  final RxInt rataRata = 0.obs;
  final RxString topDonatur = '-'.obs;
  final RxList recentDonations = [].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  // ── LOAD DASHBOARD ──
  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      final result = await _service.getDashboard();

      print('DASHBOARD RESULT: $result');

      if (result['success'] == true) {
        final data = result['data'];

        totalDonasi.value = data['total_donasi'] ?? 0;
        totalDonatur.value = data['total_donatur'] ?? 0;
        totalTransaksi.value = data['total_transaksi'] ?? 0;
        donasiTerbesar.value = data['donasi_terbesar'] ?? 0;
        rataRata.value = data['rata_rata'] ?? 0;
        topDonatur.value = data['top_donatur'] ?? '-';
        recentDonations.value = List.from(data['recent_donations'] ?? []);

        update();
      }
    } catch (e) {
      print('LOAD DASHBOARD ERROR: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ── CLEAR DATA ──
  void clearData() {
    totalDonasi.value = 0;
    totalDonatur.value = 0;
    totalTransaksi.value = 0;
    donasiTerbesar.value = 0;
    rataRata.value = 0;
    topDonatur.value = '-';
    recentDonations.clear();
  }

  // ── REFRESH ──
  Future<void> refreshDashboard() async {
    await loadDashboard();
  }

  @override
  void onClose() {
    clearData();
    super.onClose();
  }
}
