import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  //const NavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('assets/un_logo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavBarItem('Home'),
              SizedBox(width:60,),
              _NavBarItem('Episode'),
              SizedBox(width:60,),
              _NavBarItem('Profile'),
            ],
          )
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'default value',
      style: TextStyle(fontSize: 18),
    );
  }
}
