import 'package:flutter/material.dart';
import 'package:game_search/views/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.notoSans(fontSize: 18.0, color: Colors.white),
          bodyText2: GoogleFonts.notoSans(fontSize: 16.0, color: Colors.white),
        )
      ),
      home: const HomePage(),
    );
  }
}