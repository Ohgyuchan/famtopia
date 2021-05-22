import 'package:flutter/material.dart';

class NavBarLogo extends StatefulWidget {
  NavBarLogo({Key? key}) : super(key: key);

  @override
  _NavBarLogoState createState() => _NavBarLogoState();
}

class _NavBarLogoState extends State<NavBarLogo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Image.asset('assets/un_logo.png'),
    );
  }
}
