import 'package:get/get.dart';

import '../../modules/auth/login_screen.dart';
import '../../modules/auth/register_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/streamer/streamer_screen.dart';
import '../../modules/wallet/wallet_screen.dart';
import '../../modules/main/main_screen.dart';
import '../../modules/donation/donate_screen.dart';
import '../../modules/streamer/streamer_detail_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.streamer,
      page: () => const StreamerScreen(),
    ),
    GetPage(
      name: Routes.wallet,
      page: () => const WalletScreen(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
    name: Routes.main,
    page: () => const MainScreen(),
  ),
  GetPage(
  name: Routes.streamerDetail,
  page: () => const StreamerDetailScreen(),
),

GetPage(
  name: Routes.donate,
  page: () => const DonateScreen(),
),
  ];
}