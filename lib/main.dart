import 'package:flutter/material.dart';
import 'package:hr_relocation/locator.dart';
import 'screens/sign_in_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hr_relocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff009EDB),
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
      home: SignInScreen(),
    );
  }
}
