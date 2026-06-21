import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/streamer_controller.dart';
import '../../models/streamer_model.dart';

class StreamerDetailScreen extends StatelessWidget {
  const StreamerDetailScreen({super.key});

  static const Color bgDark = Color(0xFF050B22);
  static const Color cardDark = Color(0xFF0C1738);
  static const Color blueGlow = Color(0xFF356DFF);
  static const Color purpleGlow = Color(0xFF8F52FF);

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    if (args == null) {
      return Scaffold(
        backgroundColor: bgDark,
        body: const Center(
          child: Text(
            'Streamer tidak ditemukan',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final StreamerModel streamer = args as StreamerModel;
    final controller = Get.find<StreamerController>();
    final auth = Get.find<AuthController>();
    final bool isGuest = !auth.isLoggedIn.value;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF171533), Color(0xFF24205A), Color(0xFF322C7A)],
          ),
        ),
        child: Stack(
          children: [
            // Purple glow top-left
            Positioned(
              top: -150,
              left: -120,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8B5CF6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6),
                      blurRadius: 250,
                      spreadRadius: 80,
                    ),
                  ],
                ),
              ),
            ),

            // Indigo glow bottom-right
            Positioned(
              bottom: -180,
              right: -150,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF4F46E5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4F46E5),
                      blurRadius: 280,
                      spreadRadius: 100,
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  // Spacer untuk AppBar
                  SliverToBoxAdapter(child: SizedBox(height: kToolbarHeight)),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Avatar Profile
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF356DFF), Color(0xFF8F52FF)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF8F52FF,
                                  ).withOpacity(0.45),
                                  blurRadius: 25,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  streamer.foto != null &&
                                      streamer.foto!.isNotEmpty
                                  ? NetworkImage(streamer.foto!)
                                  : null,
                              backgroundColor: const Color(0xFF0C1738),
                              child:
                                  streamer.foto == null ||
                                      streamer.foto!.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 50,
                                    )
                                  : null,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Nama Streamer
                          Text(
                            streamer.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Game Chip
                          if (streamer.game != null &&
                              streamer.game!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF8B5CF6),
                                    Color(0xFF6D5BFF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                streamer.game!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                          const SizedBox(height: 30),

                          // Stats Row
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.people_alt,
                                  title: "Followers",
                                  value: streamer.followers.toString(),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.favorite,
                                  title: "Donasi",
                                  value:
                                      "Rp ${formatCurrency(streamer.totalDonasi)}",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Tentang Streamer
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF25245E),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Tentang Streamer",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  streamer.bio ?? "Belum ada bio.",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Media Sosial
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF25245E),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Media Sosial",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _SocialItem(
                                  icon: Icons.camera_alt,
                                  title: "Instagram",
                                  value: streamer.instagram?.isNotEmpty == true
                                      ? streamer.instagram!
                                      : "-",
                                ),
                                _SocialItem(
                                  icon: Icons.play_circle_fill,
                                  title: "YouTube",
                                  value: streamer.youtube?.isNotEmpty == true
                                      ? streamer.youtube!
                                      : "-",
                                ),
                                _SocialItem(
                                  icon: Icons.music_note,
                                  title: "TikTok",
                                  value: streamer.tiktok?.isNotEmpty == true
                                      ? streamer.tiktok!
                                      : "-",
                                ),
                                _SocialItem(
                                  icon: Icons.discord,
                                  title: "Discord",
                                  value: streamer.discord?.isNotEmpty == true
                                      ? streamer.discord!
                                      : "-",
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ── BUTTONS ROW ──
                          if (isGuest)
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Get.toNamed(
                                    Routes.donate,
                                    arguments: streamer,
                                  );
                                },
                                icon: const Icon(Icons.favorite),
                                label: const Text("Donate"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B5CF6),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => ElevatedButton.icon(
                                      onPressed: () async {
                                        try {
                                          if (controller.isFollowing.value) {
                                            await controller.unfollow(
                                              streamer.id,
                                            );
                                            await controller.loadStreamers();
                                            controller.isFollowing.value =
                                                false;
                                            Get.snackbar(
                                              "Berhasil",
                                              "Berhasil unfollow streamer",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          } else {
                                            await controller.follow(
                                              streamer.id,
                                            );
                                            await controller.loadStreamers();
                                            controller.isFollowing.value = true;
                                            Get.snackbar(
                                              "Berhasil",
                                              "Streamer berhasil diikuti",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          }
                                        } catch (e) {
                                          Get.snackbar(
                                            "Error",
                                            e.toString(),
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        controller.isFollowing.value
                                            ? Icons.check
                                            : Icons.person_add,
                                      ),
                                      label: Text(
                                        controller.isFollowing.value
                                            ? "Following"
                                            : "Follow",
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF8B5CF6,
                                        ),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Get.toNamed(
                                        Routes.donate,
                                        arguments: streamer,
                                      );
                                    },
                                    icon: const Icon(Icons.favorite),
                                    label: const Text("Donate"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8B5CF6),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF25245E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: AppColors.primary),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FittedBox(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SocialItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          value,
          style: const TextStyle(color: Colors.white60),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
