import 'package:flutter/material.dart';
import 'tale_slider_page.dart';
import 'package:google_fonts/google_fonts.dart';

class TaleApp extends StatelessWidget {
  const TaleApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        //-------------------
        // Тема верхней панели
        //-------------------
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.spartan(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        //-------------------
        // Text Theme
        //-------------------
        textTheme: TextTheme(
          headline2: GoogleFonts.spartan(
            fontWeight: FontWeight.w600,
            letterSpacing: -3,
            height: 0.9,
            fontSize: 64,
          ),
          headline5: GoogleFonts.spartan(
            letterSpacing: -1,
            fontWeight: FontWeight.w500,
          ),
        ).apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
      ),
      home: const TaleSliderPage(),
    );
  }
}
