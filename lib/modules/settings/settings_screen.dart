import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _settingCard(
              Icons.person_outline,
              "Pengaturan Akun",
              "Kelola informasi akun Anda",
            ),
            _settingCard(
              Icons.notifications_none,
              "Notifikasi",
              "Atur notifikasi aplikasi",
            ),
            _settingCard(
              Icons.lock_outline,
              "Keamanan",
              "Password dan keamanan akun",
            ),
            _settingCard(
              Icons.info_outline,
              "Tentang Aplikasi",
              "Informasi KAistream",
            ),
            _settingCard(
              Icons.help_outline,
              "Bantuan",
              "Pusat bantuan pengguna",
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
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