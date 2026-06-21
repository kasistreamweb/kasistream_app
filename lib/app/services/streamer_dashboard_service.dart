import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'storage_service.dart';

class StreamerDashboardService {
  Future<Map<String, dynamic>> getDashboard() async {
    final token = await StorageService.getToken();

    print('=== STREAMER DASHBOARD ===');
    print('TOKEN: $token');

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/streamer-dashboard'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    print('==========================');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Gagal mengambil dashboard: ${response.statusCode}');
  }
}
