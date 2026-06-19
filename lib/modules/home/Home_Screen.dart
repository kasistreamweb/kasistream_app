import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/activity_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/streamer_controller.dart';
import '../../models/streamer_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    final streamerController = Get.find<StreamerController>();

    final dashboardController = Get.find<DashboardController>();

    final activityController = Get.find<ActivityController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await streamerController.loadStreamers();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(auth),

                const SizedBox(height: 24),

                _buildWalletCard(auth),

                const SizedBox(height: 20),

                _buildDashboardStats(dashboardController),

                const SizedBox(height: 20),

                _buildSearch(),

                const SizedBox(height: 24),

                const Text(
                  "🔥 Top Streamer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Obx(() {
                  if (streamerController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (streamerController.streamers.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Belum ada streamer",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: streamerController.streamers
                        .map((streamer) => _streamerCard(streamer))
                        .toList(),
                  );
                }),

                const SizedBox(height: 30),

                _buildActivities(activityController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AuthController auth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo, ${auth.user.value?.name ?? 'User'} 👋",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Support streamer favoritmu",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard(AuthController auth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1E293B),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.account_balance_wallet,
            color: Colors.greenAccent,
            size: 32,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saldo Wallet",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 4),

                Text(
                  "Rp ${auth.user.value?.balance ?? 0}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardStats(DashboardController dashboard) {
    return Obx(() {
      final data = dashboard.dashboard.value;

      if (data == null) {
        return const SizedBox();
      }

      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
        children: [
          _statCard("Streamer", "${data.streamerCount}", Icons.live_tv),

          _statCard("Following", "${data.followingCount}", Icons.favorite),

          _statCard(
            "Donasi",
            "Rp ${data.totalDonasi}",
            Icons.volunteer_activism,
          ),

          _statCard(
            "Wallet",
            "Rp ${data.balance}",
            Icons.account_balance_wallet,
          ),
        ],
      );
    });
  }

  Widget _buildActivities(ActivityController activityController) {
    return Obx(() {
      if (activityController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (activityController.activities.isEmpty) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "⚡ Aktivitas Terbaru",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ...activityController.activities
              .take(5)
              .map(
                (activity) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.card_giftcard,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Donasi ke ${activity.streamerName}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              activity.pesan,
                              style: const TextStyle(color: Colors.white60),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Rp ${activity.nominal}",
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      );
    });
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF8B5CF6)),

          const SizedBox(height: 8),

          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(title, style: const TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Cari streamer...",
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF9333EA), Color(0xFF4F46E5)],
        ),
      ),
      child: const Center(
        child: Text(
          "KAistream Premium Support",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _streamerCard(StreamerModel streamer) {
    String fotoUrl = '';

    if (streamer.foto != null && streamer.foto!.isNotEmpty) {
      fotoUrl = 'https://kasistream.web.id/uploads/profile/${streamer.foto}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.deepPurple,
            child: ClipOval(
              child: fotoUrl.isNotEmpty
                  ? Image.network(
                      fotoUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, color: Colors.white),
                    )
                  : const Icon(Icons.person, color: Colors.white),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  streamer.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  streamer.game ?? 'Streamer',
                  style: const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 8),

                Text(
                  "${streamer.followers} Followers",
                  style: const TextStyle(color: Colors.white60),
                ),

                Text(
                  "Rp ${streamer.totalDonasi}",
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
            ),
            child: const Text("Donate", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
