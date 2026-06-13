import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

class StreamerScreen extends StatelessWidget {
  const StreamerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streamer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Cari streamer...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildStreamerCard(
              "Aidil Gaming",
              "125 Followers",
            ),

            _buildStreamerCard(
              "Mobile Legends Pro",
              "98 Followers",
            ),

            _buildStreamerCard(
              "PUBG Master",
              "70 Followers",
            ),

            _buildStreamerCard(
              "Free Fire Elite",
              "55 Followers",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamerCard(
    String name,
    String followers,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primary,
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  followers,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Get.toNamed(
                Routes.streamerDetail,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primary,
              foregroundColor:
                  Colors.white,
            ),
            child: const Text(
              "Donate",
            ),
          ),
        ],
      ),
    );
  }
}