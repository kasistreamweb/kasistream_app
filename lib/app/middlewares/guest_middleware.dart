import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();

    if (auth.isLoggedIn.value) {
      return const RouteSettings(name: Routes.main);
    }

    return null;
  }
}
