import 'package:flutter/material.dart';

class NavigationDrawerHeader extends StatelessWidget {
  const NavigationDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:150,
      color: Theme.of(context).accentColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('United Nations',
          style:TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white),
          ),
          Text('Relocation System',
          style: TextStyle(color:Colors.white))
      ],),
    );
  }
}