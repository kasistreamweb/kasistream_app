import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import 'streamer_wallet_screen.dart';
import 'user_wallet_screen.dart';

class WalletScreen extends GetView<AuthController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return user.isStreamer == true
        ? const StreamerWalletScreen()
        : const UserWalletScreen();
  }
}
