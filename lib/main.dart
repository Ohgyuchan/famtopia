import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/home_screen.dart';
import 'screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hr_relocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        //brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}