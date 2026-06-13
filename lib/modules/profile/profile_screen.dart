import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 50,
              backgroundColor:
                  AppColors.primary,
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Kaisar Raja Agung",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Text(
              "user@email.com",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 30),

            _menuTile(
              Icons.person_outline,
              "Edit Profile",
            ),

            _menuTile(
              Icons.history,
              "Riwayat Donasi",
            ),

            _menuTile(
              Icons.settings,
              "Pengaturan",
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red,
                  foregroundColor:
                      Colors.white,
                ),
                child:
                    const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(
    IconData icon,
    String title,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing:
            const Icon(Icons.chevron_right),
      ),
    );
  }
}