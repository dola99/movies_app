import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class InitApp {
  call() {
    print('called');
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
}
