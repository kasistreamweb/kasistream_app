import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'storage_service.dart';

class DonationService {
  Future<Map<String, dynamic>> donate({
    required int streamerId,
    required int nominal,
    required String pesan,
  }) async {
    final token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/donate'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'streamer_id': streamerId.toString(),
        'nominal': nominal.toString(),
        'pesan': pesan,
      },
    );

    return jsonDecode(response.body);
  }
}
