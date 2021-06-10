import 'package:flutter/material.dart';

class NavBarLogo extends StatefulWidget {
  NavBarLogo({Key? key}) : super(key: key);

  @override
  _NavBarLogoState createState() => _NavBarLogoState();
}

class _NavBarLogoState extends State<NavBarLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/un_logo2.png'),
    );
  }
}
