import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/streamer_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class StreamerService {
  Future<List<StreamerModel>> getStreamers() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/streamers'),
    );

    final data = jsonDecode(response.body);

    return List<StreamerModel>.from(data.map((e) => StreamerModel.fromJson(e)));
  }

  Future<void> follow(int streamerId) async {
    final token = await StorageService.getToken();

    await http.post(
      Uri.parse('${ApiService.baseUrl}/follow/$streamerId'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<void> unfollow(int streamerId) async {
    final token = await StorageService.getToken();

    await http.post(
      Uri.parse('${ApiService.baseUrl}/unfollow/$streamerId'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
