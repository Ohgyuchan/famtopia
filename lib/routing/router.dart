import 'package:flutter/widgets.dart';
import 'package:hr_relocation/screens/episode/episode_screen.dart';
import 'package:hr_relocation/screens/home/home_screen.dart';
import 'package:hr_relocation/screens/profile/profile.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';
import 'route_names.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomeScreen());
    case EpisodeRoute:
      return _getPageRoute(EpisodeScreen());
    case ProfileRoute:
      return _getPageRoute(ProfileScreen(user: currentUser));
    default:
      return _getPageRoute(HomeScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child:child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({required this.child}):
  super(
    pageBuilder: (
      BuildContext context, 
      Animation<double> animation, 
      Animation<double> secondaryAnimation,
     ) => child,
     transitionsBuilder: (
       BuildContext context,
       Animation<double> animation,
       Animation<double> secondaryAnimation,
       Widget child, 
     ) => FadeTransition(opacity:animation, child:child)); 
}
