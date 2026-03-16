import 'package:ecommerce/common/widgets/loaders/circular_loader.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/data/repositories/address/address_repository.dart';
import 'package:ecommerce/features/personalization/models/address_model.dart';
import 'package:ecommerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  // Variables
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  RxBool refreshData = false.obs;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<void> addNewAddress() async {
    try {
      UFullScreenLoader.openLoadingDialog('Storing Address...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

// Create Address Model
      AddressModel address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
      );

      String addressId = await _repository.addAddress(address);
      address.id = addressId;

      selectAddress(address);

      UFullScreenLoader.stopLoading();
      USnackBarHelpers.successSnackBar(
          title: 'Congratulations',
          message: 'Your Address has been save successfully');

      refreshData.toggle();
      resetFormFields();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }

  Future<List<AddressModel>> getAllAddresses() async {
    try {
      List<AddressModel> addresses = await _repository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
          (address) => address.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }

  // Function to select address
  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      // start loading
      Get.defaultDialog(
          title: '',
          onWillPop: () async => false,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: UCircularLoader());

      if (selectedAddress.value.id.isNotEmpty) {
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await _repository.updateSelectedField(selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      Get.back();
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }


  Future<void> selectNewAddressBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(USizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Select Address', showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems),
            FutureBuilder(
              future: getAllAddresses(),
              builder: (context, snapshot) {
                // Handle Error, Loading, Empty States
                final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(widget != null) return widget;
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => USingleAddress(
                    address: snapshot.data![index],
                    onTap: () {
                      selectedAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ), // UsingLeAddress
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
} 




  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    addressFormKey.currentState!.reset();
  }
}
