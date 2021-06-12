import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
              backgroundColor: Colors.white,
              appBar:
                  sizingInformation.deviceScreenType == DeviceScreenType.mobile
                      ? AppBar(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          iconTheme: IconThemeData(
                            color: Colors.black, //change your color here.
                          ),
                        )
                      : null,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(),
                      _user.photoURL != null
                          ? ClipOval(
                              child: Material(
                                color: Colors.grey,
                                child: Image.network(
                                  _user.photoURL!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : ClipOval(
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
                      SizedBox(height: 16.0),
                      Text(
                        'Hello',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _user.displayName!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '( ${_user.email!} )',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            ));
  }
 
}
