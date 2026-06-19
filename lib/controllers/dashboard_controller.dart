import 'package:get/get.dart';

import '../app/services/dashboard_service.dart';
import '../models/dashboard_model.dart';

class DashboardController extends GetxController {
  final DashboardService _service = DashboardService();

  final RxBool isLoading = false.obs;

  final Rxn<DashboardModel> dashboard = Rxn<DashboardModel>();

  @override
  void onInit() {
    super.onInit();

    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      final result = await _service.getSummary();

      if (result != null) {
        dashboard.value = result;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
