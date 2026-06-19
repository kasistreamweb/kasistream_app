import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
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

  String rupiah(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final StreamerModel streamer = Get.arguments as StreamerModel;

    return Scaffold(
      backgroundColor: const Color(0xFF171533),
      appBar: AppBar(
        title: const Text("Donasi"),
        backgroundColor: Colors.transparent,
        elevation: 0,
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

              const SizedBox(height: 24),

              _buildNominalSection(),

              const SizedBox(height: 24),

              _buildPesanSection(),

              const SizedBox(height: 24),

              _buildFiturTambahan(),

              const SizedBox(height: 24),

              _buildRingkasan(),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      Routes.paymentMethod,
                      arguments: {
                        "nominal": selectedNominal,
                        "fitur": fiturTambahan,
                        "total": totalBayar,
                        "pesan": pesanController.text,
                        "voice_note": voiceNote,
                        "video": videoPendek,
                        "highlight": highlightDonasi,
                        "pin": pinPesan,
                        "streamer": Get.arguments,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "LANJUTKAN",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundImage: streamer.foto != null && streamer.foto!.isNotEmpty
                ? NetworkImage(streamer.foto!)
                : null,
            child: streamer.foto == null || streamer.foto!.isEmpty
                ? const Icon(Icons.person)
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

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: presets.map((nominal) {
              final selected = selectedNominal == nominal;

              return ChoiceChip(
                selected: selected,
                label: Text("Rp ${rupiah(nominal)}"),
                onSelected: (_) {
                  setState(() {
                    selectedNominal = nominal;
                    nominalController.clear();
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 18),

          TextField(
            controller: nominalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Nominal Lain",
              prefixText: "Rp ",
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
            decoration: const InputDecoration(
              hintText: "Tulis pesan untuk streamer...",
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
      ),
      child: Column(
        children: [
          _row("Nominal", "Rp ${rupiah(selectedNominal)}"),

          const SizedBox(height: 12),

          _row("Fitur Tambahan", "Rp ${rupiah(fiturTambahan)}"),

          const Divider(),

          _row("Total", "Rp ${rupiah(totalBayar)}", bold: true),
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
