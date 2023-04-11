import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/Model/movie_model.dart';

class InitApp {
  init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await initDataBase();
  }

  Future<void> initDataBase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    await Hive.openBox<Movie>('favourites');
  }
}
