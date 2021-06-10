import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_relocation/models/post.dart';

class HomeContentDesktop extends StatefulWidget {
  const HomeContentDesktop({Key? key}) : super(key: key);

  @override
  _HomeContentDesktopState createState() => _HomeContentDesktopState();
}

class _HomeContentDesktopState extends State<HomeContentDesktop> {
  @override
  Widget build(BuildContext context) {
    return _buildStream(context);
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 6.5 / 7.0, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  if(data['approval'] == true)
                    return PostItem(
                      uid: data['uid'],
                      id: data.id,
                      title: data['title'],
                      position: data['position'],
                      description: data['description'],
                      level: data['level'],
                      //post: data['post'],
                      division: data['division'],
                      approval: data['approval'],
                      //branch: data['branch'],
                      dutystation: data['dutystation'],
                      // option1: data['option1'],
                      // option2: data['option2'],
                      // option3: data['option3'],
                      // option4: data['option4'],
                      // option5: data['option5'],
                      documentSnapshot: data,
                    );
                  else
                    return PostItem(
                      uid: 'Waiting for Approval',
                      id: 'Waiting for Approval',
                      title: 'Waiting for Approval',
                      position: 'Waiting for Approval',
                      description: 'Waiting for Approval',
                      level: 'Waiting for Approval',
                      division: 'Waiting for Approval',
                      approval: data['approval'],
                      dutystation: 'Waiting for Approval',
                      documentSnapshot: data,
                    );
                },
              );
      },
    );
  }
}
