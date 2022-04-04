import 'package:flutter/material.dart';

Widget appBarGradient() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Colors.indigo,
          Colors.lightBlueAccent
        ],
      ),
    ),
  );
}