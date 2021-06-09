import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:hr_relocation/models/post.dart';

class HomeContentMobile extends StatelessWidget {
  const HomeContentMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildStream(context);
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          // .orderBy('level')
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 6.5 / 7.0, crossAxisCount: 1),
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return PostItem(
                    uid: data['uid'],
                    id: data.id,
                    title: data['title'],
                    position: data['position'],
                    description: data['description'],
                    level: data['level'],
                    //post: data['post'],
                    division: data['division'],
                    //branch: data['branch'],
                    dutystation: data['dutystation'],
                    // option1: data['option1'],
                    // option2: data['option2'],
                    // option3: data['option3'],
                    // option4: data['option4'],
                    // option5: data['option5'],
                    documentSnapshot: data,
                  );
                },
              );
      },
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import "package:flutter/material.dart";
// import 'package:hr_relocation/models/post.dart';

// class HomeContentMobile extends StatelessWidget {
//   const HomeContentMobile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return _buildStream(context);
//   }

//   Widget _buildStream(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection("posts")
//           // .orderBy('level')
//           .snapshots(),
//       builder: (context, snapshot) {
//         return !snapshot.hasData
//             ? Center(child: CircularProgressIndicator())
//             : GridView.builder(
//                 padding: EdgeInsets.all(16.0),
//                 itemCount: snapshot.data!.docs.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     childAspectRatio: 6.5 / 7.0, crossAxisCount: 1),
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot data = snapshot.data!.docs[index];
//                   return PostItem(
//                     uid: data['uid'],
//                     id: data.id,
//                     title: data['title'],
//                     position: data['position'],
//                     description: data['description'],
//                     level: data['level'],
//                     post: data['post'],
//                     division: data['division'],
//                     branch: data['branch'],
//                     dutystation: data['dutystation'],
//                     // option1: data['option1'],
//                     // option2: data['option2'],
//                     // option3: data['option3'],
//                     // option4: data['option4'],
//                     // option5: data['option5'],
//                     documentSnapshot: data,
//                   );
//                 },
//               );
//       },
//     );
//   }
// }