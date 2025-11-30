import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;

  final firstname = TextEditingController();
  final lastname = TextEditingController();

  final updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  void initializeNames() {
    firstname.text = _userController.user.value.firstName;
    lastname.text = _userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      UFullScreenLoader.openLoadingDialog('we updating your info ...');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      await _userRepository.updateSingleField(
          {'firstName': firstname.text, 'lastName': lastname.text});

      _userController.user.value.firstName = firstname.text;
      _userController.user.value.lastName = lastname.text;

      UFullScreenLoader.stopLoading();

      Get.offAll(() => NavigationMenu());

      USnackBarHelpers.successSnackBar(
          title: 'Congatulations', message: 'Your name has been updated');
    } catch (e) {
       UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
          title: 'Update Name Failed', message: e.toString());
    }
  }
}
