import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/bootstrap.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/init_app.dart';
import 'package:movie_app/feature/Home/Cubit/home_cubit.dart';
import 'package:movie_app/feature/Home/Repo/home_repo.dart';
import 'package:movie_app/feature/Splach/splach_screen.dart';
import 'package:movie_app/feature/comparison/Repo/comparison_repo.dart';
import 'package:movie_app/feature/comparison/cubit/comparison_cubit.dart';
import 'package:movie_app/feature/favourite/cubit/favourite_cubit.dart';

void main() {
  InitApp().init();
  bootstrap(() => const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeCubit(homerepo: HomeRepo(constant: Contsant()))..init(),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ComparisonCubit(ComparisonRepo(constant: Contsant())),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Colors.black,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                elevation: 0.0,
                actionsIconTheme: const IconThemeData(color: Colors.black)),
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const SplachScreen()),
    );
  }
}
