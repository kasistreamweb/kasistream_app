import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../controllers/auth_controller.dart'; // TAMBAHKAN IMPORT
import '../../controllers/donation_controller.dart';
import '../../models/streamer_model.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final DonationController controller = Get.find();

  final TextEditingController nominalController = TextEditingController();

  final TextEditingController pesanController = TextEditingController();

  // ── TAMBAHKAN INI ──
  final TextEditingController guestNameController = TextEditingController();

  final TextEditingController guestPhoneController = TextEditingController();

  final List<int> presets = [10000, 25000, 50000, 100000, 250000, 500000];

  int selectedNominal = 10000;

  bool voiceNote = false;
  bool videoPendek = false;
  bool highlightDonasi = false;
  bool pinPesan = false;

  int get fiturTambahan {
    int total = 0;

    if (voiceNote) total += 5000;
    if (videoPendek) total += 10000;
    if (highlightDonasi) total += 15000;
    if (pinPesan) total += 20000;

    return total;
  }

  int get totalBayar {
    return selectedNominal + fiturTambahan;
  }

  int get adminFee {
    return 1500;
  }

  int get grandTotal {
    return totalBayar + adminFee;
  }

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final StreamerModel streamer = Get.arguments as StreamerModel;
    final auth = Get.find<AuthController>();
    final isGuest = auth.user.value == null;

    return Scaffold(
      backgroundColor: const Color(0xFF171533),
      appBar: AppBar(
        title: const Text("Donasi"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF171533), Color(0xFF24205A), Color(0xFF322C7A)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildStreamerCard(streamer),

              // ── GUEST FORM ──
              if (isGuest) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25245E),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: guestNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Nama Donatur',
                          hintStyle: TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: Color(0xFF1C2147),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: guestPhoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Nomor OnoPay',
                          hintStyle: TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: Color(0xFF1C2147),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              _buildNominalSection(),

              const SizedBox(height: 24),

              _buildPesanSection(),

              const SizedBox(height: 24),

              _buildFiturTambahan(),

              const SizedBox(height: 24),

              _buildRingkasan(),

              const SizedBox(height: 30),

              // ── TOMBOL LANJUTKAN ──
              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D5BFF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // ── VALIDASI GUEST ──
                    if (isGuest) {
                      if (guestNameController.text.trim().isEmpty) {
                        Get.snackbar(
                          'Nama Donatur Kosong',
                          'Masukkan nama donatur terlebih dahulu',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }

                      if (guestPhoneController.text.trim().isEmpty) {
                        Get.snackbar(
                          'Nomor OnoPay Kosong',
                          'Masukkan nomor OnoPay terlebih dahulu',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                    }

                    print("MENUJU PAYMENT METHOD");

                    Get.toNamed(
                      Routes.paymentMethod,
                      arguments: {
                        "nominal": selectedNominal,
                        "fitur": fiturTambahan,
                        "subtotal": totalBayar,
                        "admin_fee": adminFee,
                        "total": grandTotal,
                        "pesan": pesanController.text,
                        "voice_note": voiceNote,
                        "video": videoPendek,
                        "highlight": highlightDonasi,
                        "pin": pinPesan,
                        "streamer": Get.arguments,
                        // ── DATA GUEST ──
                        "guest_name": guestNameController.text,
                        "guest_phone": guestPhoneController.text,
                        "is_guest": isGuest,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "LANJUTKAN",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreamerCard(StreamerModel streamer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF25245E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: const Color(0xFF8B5CF6),
            backgroundImage: streamer.foto != null && streamer.foto!.isNotEmpty
                ? NetworkImage(streamer.foto!)
                : null,
            child: streamer.foto == null || streamer.foto!.isEmpty
                ? const Icon(Icons.person, color: Colors.white)
                : null,
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
                const SizedBox(height: 6),
                Text(
                  streamer.game ?? "Content Creator",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${streamer.followers} followers",
              style: const TextStyle(
                color: Color(0xFFB09EFF),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNominalSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF25245E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nominal Donasi",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),

          // Grid nominal
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: presets.length,
            itemBuilder: (context, index) {
              final nominal = presets[index];
              final selected = selectedNominal == nominal;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedNominal = nominal;
                    nominalController.clear();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF1C2147),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF8B5CF6)
                          : Colors.white.withOpacity(0.05),
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rp ${rupiah(nominal)}",
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.white70,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      if (selected) const SizedBox(height: 4),
                      if (selected)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Dipilih',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          const Text(
            "Atau Masukkan Nominal Lainnya",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: nominalController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Masukkan nominal...",
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(
                Icons.monetization_on,
                color: Colors.white38,
              ),
              filled: true,
              fillColor: const Color(0xFF1C2147),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              final custom = int.tryParse(value);
              if (custom != null && custom > 0) {
                setState(() {
                  selectedNominal = custom;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPesanSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF25245E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pesan Dukungan",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: pesanController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Tulis pesan untuk streamer...",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF1C2147),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiturTambahan() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF25245E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          _fiturItem(
            "Voice Note",
            "+ Rp5.000",
            voiceNote,
            (v) => setState(() => voiceNote = v),
          ),
          _fiturItem(
            "Video Pendek",
            "+ Rp10.000",
            videoPendek,
            (v) => setState(() => videoPendek = v),
          ),
          _fiturItem(
            "Highlight Donasi",
            "+ Rp15.000",
            highlightDonasi,
            (v) => setState(() => highlightDonasi = v),
          ),
          _fiturItem(
            "Pin Pesan",
            "+ Rp20.000",
            pinPesan,
            (v) => setState(() => pinPesan = v),
          ),
        ],
      ),
    );
  }

  Widget _fiturItem(
    String title,
    String price,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF8B5CF6),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(price, style: const TextStyle(color: Colors.white70)),
    );
  }

  Widget _buildRingkasan() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF25245E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          _row("Nominal Donasi", "Rp ${rupiah(selectedNominal)}"),
          const SizedBox(height: 12),
          _row("Fitur Tambahan", "Rp ${rupiah(fiturTambahan)}"),
          const SizedBox(height: 12),
          _row("Admin Fee", "Rp ${rupiah(adminFee)}"),
          const Divider(color: Colors.white24, height: 24),
          _row("Total Bayar", "Rp ${rupiah(grandTotal)}", bold: true),
        ],
      ),
    );
  }

  Widget _row(String left, String right, {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
