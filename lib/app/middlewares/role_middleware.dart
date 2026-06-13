import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleMiddleware extends GetMiddleware {
  final String role;

  RoleMiddleware(this.role);

  @override
  RouteSettings? redirect(String? route) {
    return null;
  }
}
