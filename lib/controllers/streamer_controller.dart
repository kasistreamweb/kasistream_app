import 'package:get/get.dart';

import '../app/services/streamer_service.dart';
import '../models/streamer_model.dart';

class StreamerController extends GetxController {
  final StreamerService _service = StreamerService();

  RxList<StreamerModel> streamers = <StreamerModel>[].obs;

  RxList<StreamerModel> filteredStreamers = <StreamerModel>[].obs;

  RxBool isLoading = false.obs;

  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadStreamers();
  }

  Future<void> loadStreamers() async {
    try {
      isLoading.value = true;

      final result = await _service.getStreamers();

      streamers.value = result;

      filteredStreamers.value = result;
    } finally {
      isLoading.value = false;
    }
  }

  void search(String keyword) {
    searchQuery.value = keyword;

    if (keyword.trim().isEmpty) {
      filteredStreamers.value = List.from(streamers);
      return;
    }

    filteredStreamers.value = streamers
        .where(
          (streamer) =>
              streamer.name.toLowerCase().contains(keyword.toLowerCase()) ||
              (streamer.game ?? '').toLowerCase().contains(
                keyword.toLowerCase(),
              ),
        )
        .toList();
  }

  Future<void> follow(int streamerId) async {
    await _service.follow(streamerId);

    await loadStreamers();
  }

  Future<void> unfollow(int streamerId) async {
    await _service.unfollow(streamerId);

    await loadStreamers();
  }

  List<StreamerModel> get topStreamers {
    final list = [...streamers];

    list.sort((a, b) => b.followers.compareTo(a.followers));

    return list.take(3).toList();
  }
}
