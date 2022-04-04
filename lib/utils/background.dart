import 'package:flutter/material.dart';

Widget buildBackgroundImage() {
  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: Image.asset(
      'assets/images/background_image.jpg',
      fit: BoxFit.cover,
    ),
  );
}