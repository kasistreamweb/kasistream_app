import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
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

  String formatCurrency(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B22),
      body: Obx(() {
        final user = auth.user.value;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF060B22), Color(0xFF0A1030), Color(0xFF111A45)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 40),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF9A6BFF), Color(0xFF6F63FF)],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              user?.foto != null && user!.foto!.isNotEmpty
                              ? NetworkImage(user.foto!)
                              : null,
                          child: user?.foto == null || user!.foto!.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Color(0xFF8B5CF6),
                                )
                              : null,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          user?.name ?? 'Guest',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          user?.email ?? '',
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user?.role.toUpperCase() ?? 'USER',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C2147),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _statItem(
                              "Saldo",
                              "Rp ${formatCurrency(user?.balance ?? 0)}",
                            ),
                          ),

                          Container(
                            width: 1,
                            height: 50,
                            color: Colors.white10,
                          ),

                          Expanded(
                            child: _statItem(
                              "Donasi",
                              "Rp ${formatCurrency(user?.totalDonasi ?? 0)}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  _sectionTitle("Akun"),

                  _menuTile(Icons.person_outline, "Edit Profil", () {
                    Get.toNamed(Routes.editProfile);
                  }),

                  _menuTile(Icons.account_balance_wallet, "Wallet", () {
                    Get.toNamed(Routes.wallet);
                  }),

                  _menuTile(Icons.favorite_border, "Following", () {}),

                  _menuTile(Icons.history, "Riwayat Donasi", () {}),

                  if (user?.isStreamer == true) ...[
                    _sectionTitle("Streamer"),

                    _menuTile(Icons.dashboard, "Dashboard Streamer", () {}),

                    _menuTile(Icons.payments, "Withdraw", () {}),

                    _menuTile(Icons.account_balance, "Rekening", () {}),
                  ],

                  _sectionTitle("Lainnya"),

                  _menuTile(Icons.settings, "Pengaturan", () {
                    Get.toNamed(Routes.settings);
                  }),

                  _menuTile(Icons.help_outline, "Bantuan", () {}),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: logout,
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _statItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback? onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2147),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF8B5CF6)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      ),
    );
  }
}
