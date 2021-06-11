import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

class HomeContentDesktop extends StatefulWidget {
  const HomeContentDesktop({Key? key}) : super(key: key);

  @override
  _HomeContentDesktopState createState() => _HomeContentDesktopState();
}

class _HomeContentDesktopState extends State<HomeContentDesktop> {
  @override
  Widget build(BuildContext context) {
    return currentUser.uid != '6fR2eH8V7pfagW6qpKPfsqNuUWK2'
        ? _buildStream(context)
        : _hrHmBuildStream(context);
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .where('approval', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3.0 / 3.2, crossAxisCount: 3),
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

  Widget _hrHmBuildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .orderBy('approval')
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3.0 / 3.2, crossAxisCount: 3),
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
