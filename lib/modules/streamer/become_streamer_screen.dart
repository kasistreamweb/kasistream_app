import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Tambahkan import ini
import '../../app/services/become_streamer_service.dart';
import '../../controllers/auth_controller.dart';

class BecomeStreamerScreen extends StatefulWidget {
  const BecomeStreamerScreen({super.key});

  @override
  State<BecomeStreamerScreen> createState() => _BecomeStreamerScreenState();
}

class _BecomeStreamerScreenState extends State<BecomeStreamerScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final bioController = TextEditingController();
  final gameController = TextEditingController();
  final instagramController = TextEditingController();
  final youtubeController = TextEditingController();
  final tiktokController = TextEditingController();
  final discordController = TextEditingController();

  bool isLoading = false;

  // Tambahkan service
  final _service = BecomeStreamerService();

  @override
  void dispose() {
    bioController.dispose();
    gameController.dispose();
    instagramController.dispose();
    youtubeController.dispose();
    tiktokController.dispose();
    discordController.dispose();
    super.dispose();
  }

  // Ganti seluruh method submitBecomeStreamer dengan yang baru
  Future<void> submitBecomeStreamer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final success = await _service.submit(
        bio: bioController.text,
        game: gameController.text,
        instagram: instagramController.text,
        youtube: youtubeController.text,
        tiktok: tiktokController.text,
        discord: discordController.text,
      );

      if (success) {
        await Get.find<AuthController>().refreshUser();

        Get.snackbar(
          'Berhasil',
          'Selamat, Anda sekarang menjadi streamer',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        Get.offAllNamed('/main');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E2A),
      body: Stack(
        children: [
          // Background glow - Pink/Red (energetic)
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEC4899).withOpacity(0.25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEC4899).withOpacity(0.3),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          // Background glow - Orange/Gold (warm)
          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF59E0B).withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withOpacity(0.25),
                    blurRadius: 80,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),

          // Background glow - Purple (main theme)
          Positioned(
            bottom: 200,
            right: -120,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8B5CF6).withOpacity(0.15),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── HEADER CARD ──
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF8B5CF6).withOpacity(0.3),
                            const Color(0xFFEC4899).withOpacity(0.2),
                            const Color(0xFFF59E0B).withOpacity(0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF8B5CF6),
                                      Color(0xFFEC4899),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF8B5CF6,
                                      ).withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.live_tv_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Text(
                                  'Mulai Streaming Sekarang!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.06),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFEC4899),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Terima Donasi',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFF59E0B),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Bangun Komunitas',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF8B5CF6),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Dapatkan Penghasilan',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFEC4899),
                                        Color(0xFFF59E0B),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'POPULAR',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── FORM CARD ──
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lengkapi Data Diri',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Isi informasi berikut untuk menjadi streamer',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Bio Field
                          TextFormField(
                            controller: bioController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Bio',
                              hintText: 'Ceritakan tentang dirimu',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Poppins',
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Bio wajib diisi';
                              }
                              if (value.length < 10) {
                                return 'Bio minimal 10 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Game Field
                          TextFormField(
                            controller: gameController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Game Utama',
                              hintText: 'Game apa yang akan kamu stream?',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Poppins',
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Game utama wajib diisi';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Media Sosial (Opsional)',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Instagram
                          TextFormField(
                            controller: instagramController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Instagram',
                              hintText: '@username',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Poppins',
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              prefixIcon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white38,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // YouTube
                          TextFormField(
                            controller: youtubeController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                              labelText: 'YouTube',
                              hintText: 'URL Channel atau handle',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Poppins',
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              prefixIcon: const Icon(
                                Icons.play_circle,
                                color: Colors.white38,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // TikTok
                          TextFormField(
                            controller: tiktokController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                              labelText: 'TikTok',
                              hintText: '@username',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Poppins',
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              prefixIcon: const Icon(
                                Icons.music_note,
                                color: Colors.white38,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Discord
                          TextFormField(
                            controller: discordController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Discord',
                              hintText: 'Discord tag atau server invite',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Poppins',
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              prefixIcon: const Icon(
                                Icons.chat,
                                color: Colors.white38,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // ── SUBMIT BUTTON ──
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF8B5CF6,
                                  ).withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : submitBecomeStreamer,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.rocket_launch,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Daftar Jadi Streamer',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
