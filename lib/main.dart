import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colosseum/tale_app_main.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const TaleProjectsApp());
}

class TaleProjectsApp extends StatelessWidget {
  const TaleProjectsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: const TaleApp(),
    );
  }
}
