import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());

  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      final nameParts = UserModel.nameParts(userCredential.user!.displayName);

      final username = '${userCredential.user!.displayName}23451';

      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '');

      await _userRepository.saveUserRecord(userModel);
    } catch (e) {
      USnackBarHelpers.warningSnackBar(
          title: 'Data not saved',
          message: 'something went wrong while saving your info');
    }
  }
}
