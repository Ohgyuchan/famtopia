import 'package:flutter/material.dart';
import 'package:hr_relocation/routing/route_names.dart';
import 'package:hr_relocation/widgets/navigation_bar/navbar_item.dart';
import 'package:hr_relocation/widgets/navigation_bar/navbar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavBarItem('Home',HomeRoute),
              SizedBox(width:60,),
              // NavBarItem('Episode',EpisodeRoute),
              // SizedBox(width:60,),
              NavBarItem('My page',ProfileRoute),
              
            ],
          )
        ],
      ),
    );
  }
}

class EpsiodeRoute {
}