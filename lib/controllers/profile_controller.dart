import 'package:get/get.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  final Rxn<UserModel> profile = Rxn<UserModel>();

  final RxBool isLoading = false.obs;
}
