import 'package:get/get.dart';

import '../app/services/streamer_service.dart';
import '../models/streamer_model.dart';

class StreamerController extends GetxController {
  final StreamerService _service = StreamerService();

  RxList<StreamerModel> streamers = <StreamerModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadStreamers();
  }

  Future<void> loadStreamers() async {
    try {
      isLoading.value = true;

      streamers.value = await _service.getStreamers();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> follow(int streamerId) async {
    await _service.follow(streamerId);

    await loadStreamers();
  }

  Future<void> unfollow(int streamerId) async {
    await _service.unfollow(streamerId);

    await loadStreamers();
  }
}
