import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/dashboard_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class DashboardService {
  Future<DashboardModel?> getSummary() async {
    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/dashboard-summary'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('====================');
      print('DASHBOARD STATUS: ${response.statusCode}');
      print('DASHBOARD BODY: ${response.body}');
      print('====================');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return DashboardModel.fromJson(data);
      }

      return null;
    } catch (e) {
      print('DASHBOARD ERROR: $e');

      return null;
    }
  }
}
