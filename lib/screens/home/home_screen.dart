import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/home/home_content_desktop.dart';
import 'package:hr_relocation/screens/home/home_content_mobile.dart';
import 'package:hr_relocation/screens/home/home_content_tablet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_relocation/models/posts_repository.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  //HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeContentMobile(),
      desktop: HomeContentDesktop(),
      tablet: HomeContentTablet(),
    );
  }
}
