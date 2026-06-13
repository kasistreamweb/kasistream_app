import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';

class StreamerDetailScreen extends StatelessWidget {
  const StreamerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.mainGradient,
              ),
              child: const Center(
                child: Icon(
                  Icons.live_tv,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -40),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),

            const Text(
              "Aidil Gaming",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "125 Followers",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child:
                          const Text("Follow"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          Routes.donate,
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primary,
                        foregroundColor:
                            Colors.white,
                      ),
                      child:
                          const Text("Donate"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Streamer gaming yang aktif melakukan live streaming setiap hari dan menerima dukungan dari komunitas.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}