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

import '../middlewares/auth_middleware.dart';
import '../middlewares/guest_middleware.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),

    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      middlewares: [GuestMiddleware()],
    ),

    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      middlewares: [GuestMiddleware()],
    ),

    GetPage(
      name: Routes.main,
      page: () => const MainScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.streamer,
      page: () => const StreamerScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.wallet,
      page: () => const WalletScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.profile,
      page: () => ProfileScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.streamerDetail,
      page: () => const StreamerDetailScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.donate,
      page: () => const DonateScreen(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
