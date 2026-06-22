import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Pusat Bantuan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.mainGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Pusat Bantuan KAistream",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Temukan jawaban atas pertanyaan yang sering ditanyakan pengguna.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _faq(
              "Bagaimana cara melakukan donasi?",
              "Pilih streamer yang ingin didukung, tekan tombol Donate, pilih metode pembayaran, lalu selesaikan pembayaran hingga status berhasil.",
            ),

            _faq(
              "Bagaimana cara melakukan withdraw?",
              "Masuk ke menu Wallet, pilih Withdraw, isi nominal dan rekening tujuan, kemudian tunggu proses verifikasi admin.",
            ),

            _faq(
              "Mengapa saldo belum masuk?",
              "Saldo akan otomatis masuk setelah pembayaran berhasil diverifikasi oleh sistem dan status transaksi berubah menjadi sukses.",
            ),

            _faq(
              "Mengapa withdraw masih pending?",
              "Withdraw yang berstatus pending sedang menunggu proses verifikasi dan pencairan dari admin KAistream.",
            ),

            _faq(
              "Bagaimana cara menjadi streamer?",
              "Hubungi admin KAistream untuk proses verifikasi akun streamer dan aktivasi fitur streamer.",
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: AppColors.primary,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Email Support",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "support@kaistream.web.id",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.language,
                    color: AppColors.primary,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Website",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "www.kaistream.web.id",
                    style: TextStyle(
                      color: Colors.white70,
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

  Widget _faq(
    String question,
    String answer,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: AppColors.primary,
        title: Text(
          question,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}