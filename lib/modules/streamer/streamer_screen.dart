import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../controllers/streamer_controller.dart';
import '../../models/streamer_model.dart';
import '../../app/routes/app_routes.dart';

class StreamerScreen extends StatelessWidget {
  const StreamerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StreamerController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Set ke 0 agar AppBar tidak memakan ruang
        centerTitle: true,
      ),
      body: Container(
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF8B5CF6),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF8B5CF6),
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4F46E5),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4F46E5),
                      blurRadius: 280,
                      spreadRadius: 100,
                    ),
                  ],
                ),
              ),
            ),

            // Main content - tanpa SafeArea agar lebih rapat ke atas
            Obx(() {
              if (controller.isLoading.value && controller.streamers.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
                );
              }

              final List<StreamerModel> streamers = [
                ...controller.filteredStreamers,
              ];
              streamers.sort((a, b) => b.followers.compareTo(a.followers));

              return RefreshIndicator(
                color: const Color(0xFF8B5CF6),
                onRefresh: controller.loadStreamers,
                child: CustomScrollView(
                  slivers: [
                    // Hanya spacer kecil untuk status bar
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).padding.top + 8,
                      ),
                    ),

                    // ── Hero Banner ──────────────────────────────────────────
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF8B5CF6), Color(0xFF4F46E5)],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8B5CF6).withOpacity(0.4),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.local_fire_department,
                                color: Colors.orange,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "🔥 Top Streamers",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Dukung streamer favoritmu dengan donasi",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Search Box ───────────────────────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          onChanged: controller.search,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Cari streamer...",
                            hintStyle: const TextStyle(color: Colors.white38),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white38,
                            ),
                            suffixIcon: Obx(
                              () => controller.searchQuery.value.isEmpty
                                  ? const SizedBox()
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white38,
                                      ),
                                      onPressed: () => controller.search(''),
                                    ),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.08),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFF8B5CF6),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 16)),

                    // ── Leaderboard Header ───────────────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Top Streamers",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 10)),

                    // ── Leaderboard Horizontal List ──────────────────────────
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.topStreamers.length,
                          itemBuilder: (context, index) {
                            return _LeaderboardCard(
                              streamer: controller.topStreamers[index],
                              rank: index + 1,
                            );
                          },
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 16)),

                    // ── All Streamers List ───────────────────────────────────
                    if (streamers.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.search_off,
                                size: 60,
                                color: Colors.white24,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Streamer tidak ditemukan",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return _StreamerCard(streamer: streamers[index]);
                          }, childCount: streamers.length),
                        ),
                      ),

                    // Bottom padding
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Streamer Card ────────────────────────────────────────────────────────────

class _StreamerCard extends StatelessWidget {
  final StreamerModel streamer;

  const _StreamerCard({required this.streamer});

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3D2A7A), Color(0xFF2A1A5E)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withOpacity(0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // Avatar + name row
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: const Color(0xFF8B5CF6),
                  backgroundImage:
                      streamer.foto != null && streamer.foto!.isNotEmpty
                      ? NetworkImage(streamer.foto!)
                      : null,
                  child: streamer.foto == null || streamer.foto!.isEmpty
                      ? const Icon(Icons.person, color: Colors.white, size: 26)
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        streamer.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFF6D5BFF)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          streamer.game ?? "Streamer",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF8B5CF6).withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "${streamer.followers} followers",
                    style: const TextStyle(
                      color: Color(0xFFC8B5FF),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Stats row
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    title: "Followers",
                    value: streamer.followers.toString(),
                    icon: Icons.people_alt_outlined,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    title: "Donasi",
                    value: "Rp ${formatCurrency(streamer.totalDonasi)}",
                    icon: Icons.favorite_border,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Buttons row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Get.toNamed(Routes.streamerDetail, arguments: streamer),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: BorderSide(color: Colors.white.withOpacity(0.15)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text("Detail", style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF6D5BFF)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () =>
                          Get.toNamed(Routes.donate, arguments: streamer),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text(
                        "Donate",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat Item ────────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF8B5CF6), size: 18),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}

// ── Leaderboard Card ─────────────────────────────────────────────────────────

class _LeaderboardCard extends StatelessWidget {
  final StreamerModel streamer;
  final int rank;

  const _LeaderboardCard({required this.streamer, required this.rank});

  String get rankLabel => "#$rank";

  Color get rankColor {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFB0BEC5);
      case 3:
        return const Color(0xFFFF8C42);
      default:
        return const Color(0xFF8B5CF6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Get.toNamed(Routes.streamerDetail, arguments: streamer),
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5B2E9E), Color(0xFF7C3AED)],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: rankColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: rankColor.withOpacity(0.6),
                  width: 1.5,
                ),
              ),
              child: Text(
                rankLabel,
                style: TextStyle(
                  color: rankColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white.withOpacity(0.2),
                backgroundImage:
                    streamer.foto != null && streamer.foto!.isNotEmpty
                    ? NetworkImage(streamer.foto!)
                    : null,
                child: streamer.foto == null || streamer.foto!.isEmpty
                    ? const Icon(Icons.person, color: Colors.white, size: 24)
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              streamer.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "${streamer.followers} Followers",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
