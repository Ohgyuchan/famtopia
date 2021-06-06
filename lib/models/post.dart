import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/detail_screen.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

class PostItem extends StatefulWidget {
  final String uid;
  final String id;
  final String title;
  final String description;
  final String level;
  final String post;
  final String division;
  final String branch;
  final String dutystation;
  // final String option1;
  // final String option2;
  // final String option3;
  // final String option4;
  // final String option5;

  final DocumentSnapshot documentSnapshot;
  PostItem({
    required this.uid,
    required this.id,
    required this.title,
    required this.level,
    required this.post,
    required this.division,
    required this.branch,
    required this.dutystation,
    required this.description,
    required this.documentSnapshot,
    // required this.option1,
    // required this.option2,
    // required this.option3,
    // required this.option4,
    // required this.option5,
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
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Transform.scale(
                    scale: 1,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Hero(
                        tag: 'job-img-${widget.id}',
                        child: Image.asset(
                          'assets/jobs/job2.png',
                          //width:300,
                          height: 250,
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
                  SizedBox(
                      height: 8.0 / MediaQuery.of(context).size.height * 0.2),
                  _buildCardRow(context, 'Level', widget.level.toString()),
                  SizedBox(
                      height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                  _buildCardRow(context, 'Post', widget.post),
                  SizedBox(
                      height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                  _buildCardRow(context, 'Division', widget.division),
                  SizedBox(
                      height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                  _buildCardRow(context, 'Branch', widget.branch),
                  SizedBox(
                      height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                  _buildCardRow(context, 'Dutystation', widget.dutystation),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(0),
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    user: currentUser, postItem: widget),
                              ),
                            );
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