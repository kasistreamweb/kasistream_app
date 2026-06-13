import 'package:get/get.dart';

import '../app/services/auth_service.dart';
import '../app/services/storage_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;

  final RxBool isLoggedIn = false.obs;

  final Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();

    loadSession();
  }

  Future<void> loadSession() async {
    final token = await StorageService.getToken();

    final savedUser = await StorageService.getUser();

    if (token != null && savedUser != null) {
      isLoggedIn.value = true;
      user.value = savedUser;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final result = await _authService.login(email: email, password: password);

      if (result['success']) {
        await StorageService.saveToken(result['token']);

        await StorageService.saveUser(result['user']);

        user.value = result['user'];

        isLoggedIn.value = true;

        return true;
      }

      return false;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final result = await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      if (result['success']) {
        await StorageService.saveToken(result['token']);

        await StorageService.saveUser(result['user']);

        user.value = result['user'];

        isLoggedIn.value = true;

        return true;
      }

      return false;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await StorageService.clearAll();

    user.value = null;

    isLoggedIn.value = false;

    Get.offAllNamed('/login');
  }
}
