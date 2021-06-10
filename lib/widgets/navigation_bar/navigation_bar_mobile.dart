import 'package:flutter/material.dart';
import 'package:hr_relocation/widgets/navigation_bar/navbar_logo.dart';
import 'package:hr_relocation/widgets/navigation_drawer/navigation_drawer.dart';

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            NavBarLogo(),
          ],
        ));
  }
}
