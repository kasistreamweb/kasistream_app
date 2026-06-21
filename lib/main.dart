import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'controllers/auth_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/streamer_controller.dart';
import 'controllers/donation_controller.dart';
import 'controllers/wallet_controller.dart';
import 'controllers/main_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/activity_controller.dart';
import 'controllers/streamer_dashboard_controller.dart';

void main() {
  Get.put(AuthController());

  Get.put(MainController());

  Get.put(DashboardController());

  Get.put(ActivityController());

  Get.put(ProfileController());

  Get.put(StreamerController());

  Get.put(StreamerDashboardController());

  Get.put(DonationController());

  Get.put(WalletController());

  runApp(const KAistreamApp());
}

class KAistreamApp extends StatelessWidget {
  const KAistreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KAistream',
      theme: AppTheme.darkTheme,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
    );
  }
}
