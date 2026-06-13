import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController auth = Get.find<AuthController>();

  Future<void> logout() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true) {
      await auth.logout();

      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Obx(() {
        final user = auth.user.value;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),

              const SizedBox(height: 16),

              Text(
                user?.name ?? 'Guest',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                user?.email ?? '',
                style: const TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              _menuTile(Icons.person_outline, "Edit Profile"),

              _menuTile(Icons.history, "Riwayat Donasi"),

              _menuTile(Icons.settings, "Pengaturan"),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Logout"),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _menuTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
