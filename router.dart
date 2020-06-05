import 'package:flutter/material.dart';
import 'package:hello/introCarousel.dart';
import 'package:hello/main.dart';
import 'package:intro_slider/intro_slider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/second':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => MyApp(),
          );
        }
    }
  }
}
