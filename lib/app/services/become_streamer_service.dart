import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'storage_service.dart';

class BecomeStreamerService {
  Future<bool> submit({
    required String bio,
    required String game,
    String? instagram,
    String? youtube,
    String? tiktok,
    String? discord,
  }) async {
    final token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/become-streamer'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {
        'bio': bio,
        'game': game,
        'instagram': instagram ?? '',
        'youtube': youtube ?? '',
        'tiktok': tiktok ?? '',
        'discord': discord ?? '',
      },
    );

    final data = jsonDecode(response.body);

    return data['success'] == true;
  }
}
