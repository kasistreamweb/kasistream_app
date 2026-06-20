import 'package:get/get.dart';

import '../app/services/auth_service.dart';
import '../app/services/storage_service.dart';
import '../models/user_model.dart';

// ── IMPORT ──
import 'main_controller.dart';
import 'dashboard_controller.dart';
import 'activity_controller.dart';
import 'profile_controller.dart';
import 'streamer_controller.dart';
import 'donation_controller.dart';
import 'wallet_controller.dart';

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

        // ── LOAD DATA ──
        if (Get.isRegistered<DashboardController>()) {
          await Get.find<DashboardController>().loadDashboard();
        }

        if (Get.isRegistered<WalletController>()) {
          await Get.find<WalletController>().loadWallet();
        }

        if (Get.isRegistered<ActivityController>()) {
          await Get.find<ActivityController>().loadActivities();
        }

        // ── INIT CONTROLLERS ──
        if (!Get.isRegistered<MainController>()) {
          Get.put(MainController());
        }

        if (!Get.isRegistered<DashboardController>()) {
          Get.put(DashboardController());
        }

        if (!Get.isRegistered<ActivityController>()) {
          Get.put(ActivityController());
        }

        if (!Get.isRegistered<ProfileController>()) {
          Get.put(ProfileController());
        }

        if (!Get.isRegistered<StreamerController>()) {
          Get.put(StreamerController());
        }

        if (!Get.isRegistered<DonationController>()) {
          Get.put(DonationController());
        }

        if (!Get.isRegistered<WalletController>()) {
          Get.put(WalletController());
        }

        Get.offAllNamed('/main');

        return true;
      }

      return false;
    } catch (e) {
      print('LOGIN ERROR: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String onopayPhone,
    required String password,
    String? imagePath,
  }) async {
    try {
      isLoading.value = true;

      final result = await _authService.register(
        name: name,
        email: email,
        onopayPhone: onopayPhone,
        password: password,
        imagePath: imagePath,
      );

      if (result['success']) {
        await StorageService.saveToken(result['token']);

        await StorageService.saveUser(result['user']);

        user.value = result['user'];

        isLoggedIn.value = true;

        // ── LOAD DATA ──
        if (Get.isRegistered<DashboardController>()) {
          await Get.find<DashboardController>().loadDashboard();
        }

        if (Get.isRegistered<WalletController>()) {
          await Get.find<WalletController>().loadWallet();
        }

        if (Get.isRegistered<ActivityController>()) {
          await Get.find<ActivityController>().loadActivities();
        }

        // ── INIT CONTROLLERS ──
        if (!Get.isRegistered<MainController>()) {
          Get.put(MainController());
        }

        if (!Get.isRegistered<DashboardController>()) {
          Get.put(DashboardController());
        }

        if (!Get.isRegistered<ActivityController>()) {
          Get.put(ActivityController());
        }

        if (!Get.isRegistered<ProfileController>()) {
          Get.put(ProfileController());
        }

        if (!Get.isRegistered<StreamerController>()) {
          Get.put(StreamerController());
        }

        if (!Get.isRegistered<DonationController>()) {
          Get.put(DonationController());
        }

        if (!Get.isRegistered<WalletController>()) {
          Get.put(WalletController());
        }

        Get.offAllNamed('/main');

        return true;
      }

      return false;
    } catch (e) {
      print('REGISTER ERROR: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── LOGOUT ──
  Future<void> logout() async {
    await StorageService.clearAll();

    user.value = null;

    isLoggedIn.value = false;

    if (Get.isRegistered<MainController>()) {
      Get.find<MainController>().currentIndex.value = 0;
    }

    Get.offAllNamed('/login');
  }

  // ── REFRESH USER ──
  Future<void> refreshUser() async {
    try {
      final result = await _authService.profile_screen();

      final userData = UserModel.fromJson(result);

      user.value = userData;

      await StorageService.saveUser(userData);
    } catch (e) {
      print('REFRESH USER ERROR: $e');
    }
  }
}
