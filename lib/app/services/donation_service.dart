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
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'streamer_id': streamerId.toString(),
        'nominal': nominal.toString(),
        'pesan': pesan,
      },
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> createQris({
    required int streamerId,
    required int nominal,
    required String pesan,
  }) async {
    final token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/donate-qris'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'streamer_id': streamerId.toString(),
        'nominal': nominal.toString(),
        'pesan': pesan,
      },
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> checkPayment(int donasiId) async {
    final token = await StorageService.getToken();

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/check-payment/$donasiId'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getPaymentDetail(int id) async {
    final token = await StorageService.getToken();

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/payment-detail/$id'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> payOnopay(int donasiId) async {
    final token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/pay-onopay/$donasiId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    return jsonDecode(response.body);
  }
}
