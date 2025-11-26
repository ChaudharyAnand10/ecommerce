import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'my_app.dart';

void main() async {
  /// widgets flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// flutter Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();
  // FlutterNativeSplash.remove();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationRepository());
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
