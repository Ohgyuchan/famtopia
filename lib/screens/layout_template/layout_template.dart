import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/locator.dart';
import 'package:hr_relocation/routing/route_names.dart';
import 'package:hr_relocation/routing/router.dart';
import 'package:hr_relocation/screens/add_screen.dart';
import 'package:hr_relocation/services/navigation_service.dart';
import 'package:hr_relocation/widgets/centered_view.dart';
import 'package:hr_relocation/widgets/navigation_bar/navigation_bar.dart';
import 'package:hr_relocation/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatefulWidget {
  LayoutTemplate({Key? key, required User user})
      : _user = user,
  super(key: key);

  final User _user;

  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate>
    with SingleTickerProviderStateMixin {
  Query query = FirebaseFirestore.instance.collection('posts');

  // Future<void> refreshPosts() async {
  //   /// delete all docs
  //   await FirebaseFirestore.instance
  //       .collection('posts')
  //       .get()
  //       .then((qs) => qs.docs.forEach((element) {
  //             FirebaseFirestore.instance
  //                 .collection('posts')
  //                 .doc(element.id)
  //                 .delete();
  //           }));
  //
  //   posts.forEach((element) {
  //     FirebaseFirestore.instance.collection('posts').add({
  //       'title': element.title,
  //       'level': element.level,
  //       'post': element.post,
  //       'division': element.division,
  //       'branch': element.branch,
  //       'dutystation': element.dutystation,
  //       'description': element.description,
  //     });
  //   });
  // }

  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animationIcon;
  late Animation<double> _translateButton;

  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

//Widgets

  // Widget buttonRefresh() {
  //   return Container(
  //     child: FloatingActionButton(
  //       heroTag: "refresh_button",
  //       onPressed: () => refreshPosts(),
  //       tooltip: "Refresh",
  //       child: Icon(Icons.refresh),
  //     ),
  //   );
  // }

  Widget buttonAdd() {
    return Container(
      child: FloatingActionButton(
        heroTag: "add_button",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        tooltip: "Add",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buttonEdit() {
    return Container(
      child: FloatingActionButton(
        heroTag: "edit_button",
        onPressed: () {},
        tooltip: "Edit",
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget buttonDelete() {
    return Container(
      child: FloatingActionButton(
        heroTag: "delete_button",
        onPressed: () {},
        tooltip: "Delete",
        child: Icon(Icons.delete),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "toggle_button",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Toggle",
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
      ),
    );
  }

  animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
          drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? NavigationDrawer()
              : null,
          backgroundColor: Colors.white,
          body: CenteredView(
            child: Column(
              children: [
                NavigationBar(),
                Expanded(
                    child: Navigator(
                  key: locator<NavigationService>().navigatorKey,
                  onGenerateRoute: generateRoute,
                  initialRoute: HomeRoute,
                )),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Transform(
              //   transform: Matrix4.translationValues(
              //       0.0, _translateButton.value * 4.0, 0.0),
              //   child: buttonRefresh(),
              // ),
              Transform(
                transform: Matrix4.translationValues(
                    0.0, _translateButton.value * 3.0, 0.0),
                child: buttonAdd(),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    0.0, _translateButton.value * 2.0, 0.0),
                child: buttonEdit(),
              ),
              Transform(
                transform:
                    Matrix4.translationValues(0.0, _translateButton.value, 0.0),
                child: buttonDelete(),
              ),
              buttonToggle(),
            ],
          )),
    );
  }
}
