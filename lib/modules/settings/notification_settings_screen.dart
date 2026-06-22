import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool donationNotif = true;
  bool withdrawNotif = true;
  bool streamerNotif = true;
  bool promoNotif = false;
  bool emailNotif = true;

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
          'Notifikasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _item(
            title: "Notifikasi Donasi",
            subtitle: "Saat menerima atau mengirim donasi",
            value: donationNotif,
            onChanged: (v) {
              setState(() => donationNotif = v);
            },
          ),
          _item(
            title: "Notifikasi Withdraw",
            subtitle: "Status withdraw dan pencairan dana",
            value: withdrawNotif,
            onChanged: (v) {
              setState(() => withdrawNotif = v);
            },
          ),
          _item(
            title: "Streamer Diikuti",
            subtitle: "Aktivitas streamer yang Anda ikuti",
            value: streamerNotif,
            onChanged: (v) {
              setState(() => streamerNotif = v);
            },
          ),
          _item(
            title: "Promo & Event",
            subtitle: "Informasi promo dan event terbaru",
            value: promoNotif,
            onChanged: (v) {
              setState(() => promoNotif = v);
            },
          ),
          _item(
            title: "Email",
            subtitle: "Kirim pemberitahuan ke email",
            value: emailNotif,
            onChanged: (v) {
              setState(() => emailNotif = v);
            },
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}