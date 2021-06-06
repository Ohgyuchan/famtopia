import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final int level;
  final String post;
  final String division;
  final String branch;
  final String dutystation;
  final DocumentSnapshot documentSnapshot;
  PostItem({
    required this.id,
    required this.title,
    required this.level,
    required this.post,
    required this.division,
    required this.branch,
    required this.dutystation,
    required this.description,
    required this.documentSnapshot,
  });

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Transform.scale(
                    scale: 1,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Hero(
                        tag: 'job-img-2',
                        child: Image.asset(
                          'assets/jobs/job2.png',
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
                          widget.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  _buildCardRow(context, 'Level', widget.level.toString()),
                  SizedBox(height: 4.0),
                  _buildCardRow(context, 'Post', widget.post),
                  SizedBox(height: 4.0),
                  _buildCardRow(context, 'Division', widget.division),
                  SizedBox(height: 4.0),
                  _buildCardRow(context, 'Branch', widget.branch),
                  SizedBox(height: 4.0),
                  _buildCardRow(context, 'Dutystation', widget.dutystation),
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

// class Post {
//   const Post(
//       {required this.id,
//       required this.title,
//       required this.level,
//       required this.post,
//       required this.division,
//       required this.branch,
//       required this.dutystation,
//       required this.description});
//
//   final int id;
//   final String title;
//   final String description;
//   final int level;
//   final String post;
//   final String division;
//   final String branch;
//   final String dutystation;
//
//   @override
//   String toString() => "$title (id=$id)";
//
//   Post.fromMap(Map snapshot, int id)
//       : id = id,
//         title = snapshot['title'] ?? '',
//         level = snapshot['level'] ?? '',
//         post = snapshot['post'] ?? '',
//         division = snapshot['division'] ?? '',
//         branch = snapshot['branch'] ?? '',
//         dutystation = snapshot['dutystation'] ?? '',
//         description = snapshot['description'] ?? '';
// }
