import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/models/posts_repository.dart';

class HomeContentTablet extends StatelessWidget {
  const HomeContentTablet({Key? key}) : super(key: key);

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
          itemCount: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data!.docs[index];
            return PostItem(
              id: data.id,
              title: data['title'],
              description: data['description'],
              level: data['level'],
              post: data['post'],
              division: data['division'],
              branch: data['branch'],
              dutystation: data['dutystation'],
              documentSnapshot: data,
            );
          },
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 6.5 / 7.0,
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
                     Transform.scale(
                        scale:1,
                                              child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Hero(
                            tag: 'job-img-${(posts.id)}',
                            child: Image.asset(
                              'assets/jobs/job${(posts.id)}.png',
                              //width:300,
                              height: 200,
                              fit: BoxFit.fitHeight,
                              //alignment: Alignment(0,-pageOffset.abs()+posts.id),
                            ),
                          ),
                        ),
                      ),
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
                      _buildCardRow(context,'Level', posts.level.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow(context,'Post', posts.post.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow(context,'Division', posts.division.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow(context,'Branch', posts.branch.toString()),
                      SizedBox(height: 4.0),
                      _buildCardRow(context,'Dutystation', posts.dutystation.toString()),
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

  Row _buildCardRow(BuildContext context, String label, String value) {
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
