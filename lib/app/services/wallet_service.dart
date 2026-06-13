import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'storage_service.dart';

class WalletService {
  Future<Map<String, dynamic>> withdraw({
    required int nominal,
    required String bank,
    required String rekening,
    required String namaRekening,
  }) async {
    final token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/withdraw'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'nominal': nominal.toString(),
        'bank': bank,
        'rekening': rekening,
        'nama_rekening': namaRekening,
      },
    );

    return jsonDecode(response.body);
  }
}
