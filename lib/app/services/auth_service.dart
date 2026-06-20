import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      print('====================');
      print('LOGIN STATUS: ${response.statusCode}');
      print('LOGIN BODY: ${response.body}');
      print('====================');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'token': data['token'],
          'user': UserModel.fromJson(data['user']),
        };
      }

      return {'success': false, 'message': data['message'] ?? 'Login gagal'};
    } catch (e) {
      print('LOGIN ERROR: $e');

      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String onopayPhone,
    required String password,
    String? imagePath,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiService.baseUrl}/register'),
      );

      request.headers['Accept'] = 'application/json';

      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['onopay_phone'] = onopayPhone;
      request.fields['password'] = password;

      if (imagePath != null && imagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('foto', imagePath));
      }

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      print('====================');
      print('REGISTER STATUS: ${response.statusCode}');
      print('REGISTER BODY: ${response.body}');
      print('====================');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'token': data['token'],
          'user': UserModel.fromJson(data['user']),
        };
      }

      return {'success': false, 'message': data['message'] ?? 'Register gagal'};
    } catch (e) {
      print('REGISTER ERROR: $e');

      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> logout() async {
    try {
      final token = await StorageService.getToken();

      await http.post(
        Uri.parse('${ApiService.baseUrl}/logout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      print('LOGOUT ERROR: $e');
    }
  }

  // ── PROFILE ──
  Future<Map<String, dynamic>> profile_screen() async {
    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('====================');
      print('PROFILE STATUS: ${response.statusCode}');
      print('PROFILE BODY: ${response.body}');
      print('====================');

      return jsonDecode(response.body);
    } catch (e) {
      print('PROFILE ERROR: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
