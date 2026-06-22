import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../profile/edit_profile_screen.dart';
import 'notification_settings_screen.dart';
import 'security_screen.dart';
import 'help_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Pengaturan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _settingCard(
              icon: Icons.person_outline,
              title: "Pengaturan Akun",
              subtitle: "Kelola informasi akun Anda",
              onTap: () {
                Get.to(
                  () => const EditProfileScreen(),
                );
              },
            ),

            _settingCard(
              icon: Icons.notifications_none,
              title: "Notifikasi",
              subtitle: "Atur notifikasi aplikasi",
              onTap: () {
                Get.to(
                  () => const NotificationSettingsScreen(),
                );
              },
            ),

            _settingCard(
              icon: Icons.lock_outline,
              title: "Keamanan",
              subtitle: "Password dan keamanan akun",
              onTap: () {
                Get.to(
                  () => const SecurityScreen(),
                );
              },
            ),

            _settingCard(
              icon: Icons.info_outline,
              title: "Tentang Aplikasi",
              subtitle: "Informasi KAistream",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColors.card,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "KAistream",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Versi 1.0.0",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Platform donasi untuk streamer yang memungkinkan pengguna memberikan dukungan finansial melalui QRIS dan Wallet.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "© 2026 KAistream",
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            _settingCard(
              icon: Icons.help_outline,
              title: "Bantuan",
              subtitle: "Pusat bantuan pengguna",
              onTap: () {
                Get.to(
                  () => const HelpScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.2),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.white70,
        ),
      ),
    );
  }
}