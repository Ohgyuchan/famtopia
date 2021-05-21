import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/widgets/centered_view.dart';
import 'package:hr_relocation/widgets/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: CenteredView(
        child: Column(
          children: [NavigationBar(), Expanded(child: _buildBody(context))],
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
          return _buildGrid(context);
        });
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 7.0,
      children: posts.map((posts) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              posts.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      _buildCardRow('Level', posts.level.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow('Post', posts.post.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow('Division', posts.division.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow('Branch', posts.branch.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow(
                          'Dutystation', posts.dutystation.toString()),
                      SizedBox(height: 8.0),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          alignment: Alignment.bottomRight,
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
  }

  Row _buildCardRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
