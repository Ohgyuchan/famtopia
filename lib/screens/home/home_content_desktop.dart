import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/models/posts_repository.dart';

class HomeContentDesktop extends StatefulWidget {
  const HomeContentDesktop({Key? key}) : super(key: key);

  @override
  _HomeContentDesktopState createState() => _HomeContentDesktopState();
}

class _HomeContentDesktopState extends State<HomeContentDesktop> {
  //late PageController pageController;
  //double pageOffset = 0;

  // void initState() {
  //   super.initState();
  //   pageController = PageController(viewportFraction: 0.7);
  //   pageController.addListener(() {
  //     setState(() {
  //       pageOffset=pageController.page!;
  //     });
  //     });
  // }
  //https://www.youtube.com/watch?v=8Rl47Eb0rjg

  @override
  Widget build(BuildContext context) {
    return _buildStream(context);
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .orderBy('level')
          .snapshots(),
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
                  return PostItem(
                    id: data['id'],
                    title: data['title'],
                    description: data['description'],
                    level: data['level'],
                    post: data['post'],
                    division: data['division'],
                    branch: data['branch'],
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
