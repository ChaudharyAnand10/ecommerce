import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'my_app.dart';

void main() {
  /// widgets flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// flutter Native Splash
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
