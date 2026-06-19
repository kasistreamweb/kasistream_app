import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../streamer/streamer_screen.dart';
import '../wallet/wallet_screen.dart';
import '../streamer/dashboard_streamer_screen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const StreamerScreen(),
      const DashboardStreamerScreen(),
      const WalletScreen(),
      ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        extendBody: true,
        body: SafeArea(
          child: IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1C2147), Color(0xFF0A1030)],
            ),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.06), width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: controller.changeTab,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            indicatorColor: const Color(0xFF8B5CF6).withOpacity(0.2),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            height: 65,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.live_tv_outlined),
                selectedIcon: Icon(Icons.live_tv),
                label: "Streamer",
              ),
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet),
                label: "Wallet",
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
