import 'package:flutter/material.dart';
import 'package:hello/introCarousel.dart';
import 'package:hello/main.dart';
import 'routingConstants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => ListDisplay());

    case IntroScreenViewRoute:
      return MaterialPageRoute(builder: (context) => IntroScreen());

    default:
      return MaterialPageRoute(builder: (context) => ListDisplay());
  }
}
