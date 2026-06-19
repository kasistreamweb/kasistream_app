// lib/app/modules/dashboard_streamer/dashboard_streamer_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/streamer_controller.dart';
import '../../models/streamer_model.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';

class DashboardStreamerScreen extends StatelessWidget {
  const DashboardStreamerScreen({super.key});

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0,
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

              // Main content with TabBar
              SafeArea(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "📊 Streamer Center",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Pantau performa donasi dan aktivitas pendukung Anda",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // TabBar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C2147),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFF6D5BFF)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        tabs: const [
                          Tab(text: "Dashboard"),
                          Tab(text: "Donasi Masuk"),
                          Tab(text: "Statistik"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // TabBarView
                    Expanded(
                      child: TabBarView(
                        children: [
                          _DashboardTab(),
                          _DonasiMasukTab(),
                          _StatistikTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── DASHBOARD TAB ────────────────────────────────────────────────────────────

class _DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StreamerController>();
    final totalDonasi = controller.streamers.fold<int>(
      0,
      (sum, s) => sum + s.totalDonasi,
    );
    final totalDonatur = controller.streamers.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Stats Row
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.monetization_on,
                  title: "Total Donasi",
                  value: "Rp ${formatCurrency(totalDonasi)}",
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.people,
                  title: "Total Donatur",
                  value: totalDonatur.toString(),
                  color: const Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.receipt_long,
                  title: "Total Transaksi",
                  value: "1",
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.trending_up,
                  title: "Rata-rata",
                  value: "Rp ${formatCurrency(totalDonasi)}",
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Riwayat Donasi Terbaru
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2D1B69), Color(0xFF1A1A4E)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "📋 Riwayat Donasi Terbaru",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2147),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFF8B5CF6),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Del",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Hebat",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Rp 100.000",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "15 Jun 2026",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

// ── DONASI MASUK TAB ─────────────────────────────────────────────────────────

class _DonasiMasukTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2D1B69), Color(0xFF1A1A4E)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "💰 Donasi Masuk",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Semua dukungan yang diterima dari para penonton dan penggemar",
                  style: TextStyle(color: Colors.white60, fontSize: 13),
                ),
                const SizedBox(height: 16),

                // Donasi Item
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2147),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFF8B5CF6),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Del",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Hebat",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Rp 100.000",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "15 Jun 2026 11:51",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ── STATISTIK TAB ────────────────────────────────────────────────────────────

class _StatistikTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StreamerController>();
    final totalDonasi = controller.streamers.fold<int>(
      0,
      (sum, s) => sum + s.totalDonasi,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2D1B69), Color(0xFF1A1A4E)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "📊 Statistik Streamer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Analisis performa donasi dan aktivitas pendukung Anda",
                  style: TextStyle(color: Colors.white60, fontSize: 13),
                ),
                const SizedBox(height: 16),

                // Grid Stats
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: [
                    _StatistikItem(
                      title: "Donasi Terbesar",
                      value: "Rp 100.000",
                      icon: Icons.emoji_events,
                      color: Colors.amber,
                    ),
                    _StatistikItem(
                      title: "Rata-rata Donasi",
                      value: "Rp ${formatCurrency(totalDonasi)}",
                      icon: Icons.trending_up,
                      color: Colors.blue,
                    ),
                    _StatistikItem(
                      title: "Top Donatur",
                      value: "Del",
                      icon: Icons.person,
                      color: Colors.pink,
                    ),
                    _StatistikItem(
                      title: "Donasi Masuk",
                      value: "Rp 100.000",
                      icon: Icons.monetization_on,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

// ── STAT CARD ────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D1B69), Color(0xFF1A1A4E)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.white60)),
        ],
      ),
    );
  }
}

// ── STATISTIK ITEM ───────────────────────────────────────────────────────────

class _StatistikItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatistikItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2147),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(fontSize: 11, color: Colors.white60),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
