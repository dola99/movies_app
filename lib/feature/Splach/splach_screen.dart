import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/Home/home_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushReplacement(
              ThisIsFadeRoute(route: HomeScreen(), page: HomeScreen()));
          Timer(const Duration(milliseconds: 300), () {
            animationController.reset();
          });
        }
      });
    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(animationController);
    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        animationController.forward();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: AnimatedOpacity(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 6),
                  opacity: _opacity,
                  child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(
                      seconds: 2,
                    ),
                    height: _value ? 50 : 200,
                    width: _value ? 50 : 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 100,
                              spreadRadius: 10)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/logo_light.png')),
                            color: Colors.white,
                            shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) => Transform.scale(
                            scale: animationController.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder<Widget> {
  final Widget page;
  final Widget route;
  ThisIsFadeRoute({required this.page, required this.route})
      : super(
          pageBuilder: (context, animation, anotheAnimation) => page,
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: route,
            );
          },
        );
}
