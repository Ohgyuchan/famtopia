import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';

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
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .where('uid', isEqualTo: '${_user.uid}')
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3.0 / 3.2,
                    crossAxisCount: MediaQuery.of(context).size.width >= 949
                        ? 3
                        : MediaQuery.of(context).size.width >= 598
                            ? 2
                            : 1),
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  print(MediaQuery.of(context).size.width);
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
