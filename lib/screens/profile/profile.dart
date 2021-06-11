import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';
import 'package:hr_relocation/utils/authentication.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStream(context);
    // return ResponsiveBuilder(
    //     builder: (context, sizingInformation) => Scaffold(
    //           backgroundColor: Colors.white,
    //           appBar:
    //               sizingInformation.deviceScreenType == DeviceScreenType.mobile
    //                   ? AppBar(
    //                       elevation: 0,
    //                       backgroundColor: Colors.white,
    //                       iconTheme: IconThemeData(
    //                         color: Colors.black, //change your color here.
    //                       ),
    //                     )
    //                   : null,
    //           body: SafeArea(
    //             child: Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 16.0,
    //                 right: 16.0,
    //                 bottom: 20.0,
    //               ),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Row(),
    //                   _user.photoURL != null
    //                       ? ClipOval(
    //                           child: Material(
    //                             color: Colors.grey,
    //                             child: Image.network(
    //                               _user.photoURL!,
    //                               fit: BoxFit.fitHeight,
    //                             ),
    //                           ),
    //                         )
    //                       : ClipOval(
    //                           child: Material(
    //                             color: Colors.grey,
    //                             child: Padding(
    //                               padding: const EdgeInsets.all(16.0),
    //                               child: Icon(
    //                                 Icons.person,
    //                                 size: 60,
    //                                 color: Colors.grey,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                   SizedBox(height: 16.0),
    //                   Text(
    //                     'Hello',
    //                     style: TextStyle(
    //                       color: Colors.grey,
    //                       fontSize: 26,
    //                     ),
    //                   ),
    //                   SizedBox(height: 8.0),
    //                   Text(
    //                     _user.displayName!,
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 26,
    //                     ),
    //                   ),
    //                   SizedBox(height: 8.0),
    //                   Text(
    //                     '( ${_user.email!} )',
    //                     style: TextStyle(
    //                       color: Colors.grey,
    //                       fontSize: 20,
    //                       letterSpacing: 0.5,
    //                     ),
    //                   ),
    //                   SizedBox(height: 24.0),
    //                   Text(
    //                     'You are now signed in using your Google account. To sign out of your account, click the "Sign Out" button below.',
    //                     style: TextStyle(
    //                         color: Colors.grey,
    //                         fontSize: 14,
    //                         letterSpacing: 0.2),
    //                   ),
    //                   SizedBox(height: 16.0),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ));
  }
  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .where('uid', isEqualTo:'${_user.uid}')
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.0 / 3.2, crossAxisCount: 2),
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data!.docs[index];
            return PostItem(
              uid: data['uid'],
              id: data.id,
              title: data['title'],
              position: data['position'],
              description: data['description'],
              level: data['level'],
              division: data['division'],
              approval: data['approval'],
              dutystation: data['dutystation'],
              documentSnapshot: data,
            );
          },
        );
      },
    );
  }
}
