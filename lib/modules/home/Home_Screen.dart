import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient:
                      AppColors.mainGradient,
                  borderRadius:
                      BorderRadius.circular(
                          24),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang 👋",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Temukan streamer favoritmu",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              TextField(
                decoration:
                    InputDecoration(
                  hintText:
                      "Cari streamer...",
                  prefixIcon:
                      const Icon(Icons.search),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "🔥 Top Streamer",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              _streamerCard(
                "Aidil Gaming",
                "125 Followers",
              ),

              _streamerCard(
                "Mobile Legends Pro",
                "98 Followers",
              ),

              _streamerCard(
                "PUBG Master",
                "70 Followers",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _streamerCard(
    String name,
    String followers,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(Icons.person),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(followers),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Donate",
            ),
          ),
        ],
      ),
    );
  }
}