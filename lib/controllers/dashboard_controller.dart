import 'package:get/get.dart';

import '../app/services/dashboard_service.dart';
import '../models/dashboard_model.dart';

class DashboardController extends GetxController {
  final DashboardService _service = DashboardService();

  RxBool isLoading = false.obs;

  RxInt streamerCount = 0.obs;

  RxInt followingCount = 0.obs;

  RxInt totalDonasi = 0.obs;

  RxInt balance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      final DashboardModel? result = await _service.getSummary();

      if (result != null) {
        streamerCount.value = result.streamerCount;

        followingCount.value = result.followingCount;

        totalDonasi.value = result.totalDonasi;

        balance.value = result.balance;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
