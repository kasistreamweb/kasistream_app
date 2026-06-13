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
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/register'),
        headers: {'Accept': 'application/json'},
        body: {'name': name, 'email': email, 'password': password},
      );

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
}
