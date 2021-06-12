import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/layout_template/layout_template.dart';
import 'package:hr_relocation/utils/authentication.dart';

late User currentUser;
late String hrUid;
late String hmUid;
late bool posted;
late bool approved;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/un_logo2.png',
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orangeAccent,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  currentUser = user;
                  hrUid = await _loadHrUid();
                  hmUid = await _loadHmUid();

                  if (currentUser.uid != hrUid && currentUser.uid != hmUid) {
                    await addApproved(currentUser.uid);
                    posted = await _loadPosted();
                    approved = await _loadApproved();
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LayoutTemplate(
                        user: user,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

Future<void> addApproved(
  String uid,
) async {
  String _uid = await _loadStaffUid(uid);
  if (_uid == uid) {
    return FirebaseFirestore.instance
        .collection('approved')
        .doc(uid)
        .update({
          'uid': uid,
        })
        .then((value) => print("Approved already exist."))
        .catchError((error) => print("Failed to update Approved: $error"));
  } else {
    return FirebaseFirestore.instance
        .collection('approved')
        .doc(uid)
        .set({
          'uid': uid,
          'approved': false,
          'posted': false,
        })
        .then((value) => print("Approved Added"))
        .catchError((error) => print("Failed to add Approved: $error"));
  }
}

Future<String> _loadStaffUid(String uid) async {
  var _uid;
  await FirebaseFirestore.instance
      .collection('approved')
      .doc(uid)
      .get()
      .then((DocumentSnapshot ds) async {
    if (ds.data() == null)
      _uid = 'N/A';
    else
      _uid = ds['uid'].toString();
    print('staff: ' + _uid);
  });
  return _uid;
}

Future<String> _loadHrUid() async {
  var uid;
  await FirebaseFirestore.instance
      .collection('admin')
      .doc('hr')
      .get()
      .then((DocumentSnapshot ds) async {
    uid = ds['uid'].toString();
    print('hr ' + uid);
  });
  return uid;
}

Future<String> _loadHmUid() async {
  var uid;
  await FirebaseFirestore.instance
      .collection('admin')
      .doc('hm')
      .get()
      .then((DocumentSnapshot ds) async {
    uid = ds['uid'].toString();
    print('hm ' + uid);
  });
  return uid;
}

Future<bool> _loadPosted() async {
  var posted;
  await FirebaseFirestore.instance
      .collection('approved')
      .doc(currentUser.uid)
      .get()
      .then((DocumentSnapshot ds) async {
    posted = ds['posted'];
  });
  if (posted == null) return Future.value(false);
  return posted;
}

Future<bool> _loadApproved() async {
  var approved;
  await FirebaseFirestore.instance
      .collection('approved')
      .doc(currentUser.uid)
      .get()
      .then((DocumentSnapshot ds) async {
    approved = ds['approved'];
  });
  if (approved == null) return Future.value(false);
  return approved;
}
