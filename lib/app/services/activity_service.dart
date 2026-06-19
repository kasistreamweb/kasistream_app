import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/activity_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class ActivityService {
  Future<List<ActivityModel>> getActivities() async {
    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/donation-history'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List list = data['data'] ?? [];

        return list.map((e) => ActivityModel.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      print('ACTIVITY ERROR: $e');

      return [];
    }
  }
}
