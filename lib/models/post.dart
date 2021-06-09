import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/detail_screen.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

class PostItem extends StatefulWidget {
  final String uid;
  final String id;
  final String title;
  late final String position;
  final String description;
  late final String level;
  //final String post;
  late final String division;
  final bool approval;
  //final String branch;
  late final String dutystation;
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
    required this.position,
    required this.level,
    //required this.post,
    required this.division,
    required this.approval,
    //required this.branch,
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
    return InkWell(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18 / 11,
                      child: Hero(
                        tag: 'img-${widget.position}-${widget.id}',
                        child: Image.asset(
                          'assets/jobs/${widget.position}.png',
                          height: 250,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
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
                    SizedBox(height: 16),
                    SizedBox(
                        height: 8.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(
                        context, 'Position', widget.position.toString()),
                    SizedBox(
                        height: 8.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(context, 'Level', widget.level.toString()),
                    SizedBox(
                        height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(context, 'Dutystation', widget.dutystation),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(user: currentUser, postItem: widget),
            ),
          );
        });
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