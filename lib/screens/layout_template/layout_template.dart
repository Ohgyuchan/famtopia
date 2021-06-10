import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/locator.dart';
import 'package:hr_relocation/routing/route_names.dart';
import 'package:hr_relocation/routing/router.dart';
import 'package:hr_relocation/screens/add_screen.dart';
import 'package:hr_relocation/services/navigation_service.dart';
import 'package:hr_relocation/utils/authentication.dart';
import 'package:hr_relocation/widgets/centered_view.dart';
import 'package:hr_relocation/widgets/navigation_bar/navigation_bar.dart';
import 'package:hr_relocation/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../sign_in_screen.dart';

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
  late User _user;

  static const String ProfileRoute = 'profile';

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

    _user = widget._user;

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  _user.photoURL != null
                      ? SizedBox(
                          height: 40,
                          width: 40,
                          child: GestureDetector(
                            onTap: () {
                              locator<NavigationService>()
                                  .navigateTo(ProfileRoute);
                            },
                            child: ClipOval(
                              child: Material(
                                color: Colors.grey,
                                child: Image.network(
                                  _user.photoURL!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            locator<NavigationService>()
                                .navigateTo(ProfileRoute);
                          },
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: ClipOval(
                              child: Material(
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(width: 20),
                  Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () async {
                            await Authentication.signOut(context: context);

                            Navigator.of(context)
                                .pushReplacement(_routeToSignInScreen());
                          },
                          child: Text('Sign Out'))),
                ]),
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
          floatingActionButton: buttonAdd()),
    );
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
