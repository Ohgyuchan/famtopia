import 'package:flutter/material.dart';
import 'package:hr_relocation/widgets/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/models/posts_repository.dart';

class HomeScreen extends StatefulWidget {
  //HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Query query = FirebaseFirestore.instance.collection('posts');

  refreshPosts() async {
    /// delete all docs
    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((qs) => qs.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(element.id)
                  .delete();
            }));

    posts.forEach((element) {
      FirebaseFirestore.instance.collection('posts').add({
        'title': element.title,
        'level': element.level,
        'post': element.post,
        'division': element.division,
        'branch': element.branch,
        'dutystation': element.dutystation,
        'description': element.description,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 60),
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(children: [
            NavigationBar(),
            Expanded(
              child: _buildBody(context),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => refreshPosts(),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children: posts.map((posts) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    posts.title,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'Level',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Expanded(
                                  child: Text(
                                    posts.level.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  'Post',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Expanded(
                                  child: Text(
                                    posts.post.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  'Division',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Expanded(
                                  child: Text(
                                    posts.division.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  'Branch',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Expanded(
                                  child: Text(
                                    posts.branch.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  'Dutystation',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Expanded(
                                  child: Text(
                                    posts.dutystation.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                  child: Text(
                                    'more',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (_) {
                                    //       return DetailPage(product);
                                    //     },
                                    //   ),
                                    // );
                                    Navigator.pushNamed(context, '/detail');
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
