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

  Future<Map<String, dynamic>> guestCreateQris({
    required int streamerId,
    required String guestName,
    required String guestPhone,
    required int nominal,
    required String pesan,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/guest/donate-qris'),
      headers: {'Accept': 'application/json'},
      body: {
        'streamer_id': streamerId.toString(),
        'guest_name': guestName,
        'guest_phone': guestPhone,
        'nominal': nominal.toString(),
        'pesan': pesan,
      },
    );

    print('=== GUEST CREATE QRIS ===');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

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

  // ── GUEST PAYMENT DETAIL ──
  Future<Map<String, dynamic>> guestPaymentDetail(int id) async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/guest/payment-detail/$id'),
      headers: {'Accept': 'application/json'},
    );

    print('=== GUEST PAYMENT DETAIL ===');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    return jsonDecode(response.body);
  }

  // ── GUEST CHECK PAYMENT ──
  Future<Map<String, dynamic>> guestCheckPayment(int id) async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/guest/check-payment/$id'),
      headers: {'Accept': 'application/json'},
    );

    print('=== GUEST CHECK PAYMENT ===');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    return jsonDecode(response.body);
  }

  // ── GUEST PAY ONOPAY ──
  Future<Map<String, dynamic>> guestPayOnopay(int id) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/guest/pay-onopay/$id'),
      headers: {'Accept': 'application/json'},
    );

    print('=== GUEST PAY ONOPAY ===');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    return jsonDecode(response.body);
  }
}
