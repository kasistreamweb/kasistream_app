import 'package:get/get.dart';

import '../app/services/activity_service.dart';
import '../models/activity_model.dart';

class ActivityController extends GetxController {
  final ActivityService _service = ActivityService();

  final RxBool isLoading = false.obs;

  final RxList<ActivityModel> activities = <ActivityModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadActivities();
  }

  Future<void> loadActivities() async {
    try {
      isLoading.value = true;

      final result = await _service.getActivities();

      activities.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}
