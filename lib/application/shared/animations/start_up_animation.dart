import 'package:flutter/material.dart';

class StartUpAnimation {
  final AnimationController controller;
  late Animation<double> startUp;

  StartUpAnimation({required this.controller}) {
    startUp = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
  }
}
