import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  late final String division;
  late final bool approval;
  late final String dutystation;
  final DocumentSnapshot documentSnapshot;

  PostItem({
    required this.uid,
    required this.id,
    required this.title,
    required this.position,
    required this.level,
    required this.division,
    required this.approval,
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
    return Scaffold(
      body: InkWell(
          child: SizedBox(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18 / 11,
                      child: Hero(
                        tag: 'img-${widget.position}-${widget.id}',
                        child: Image.asset(
                          widget.approval
                              ? 'assets/jobs/officer/${widget.position}.jpg'
                              : 'assets/jobs/officer/Waiting for Approval.png',
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.approval ? widget.title : 'Waiting for Approval',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    SizedBox(height: 16),
                    _buildCardRow(context, 'Level', widget.level),
                    SizedBox(
                        height: 8.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(context, 'Dutystation', widget.dutystation),
                    SizedBox(
                        height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(context, 'Division', widget.division),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(user: currentUser, postItem: widget),
              ),
            );
          }),
    );
  }

  Flex _buildCardRow(BuildContext context, String label, String value) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.left,
            overflow: TextOverflow.fade,
            maxLines: 1,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.right,
            overflow: TextOverflow.fade,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text('This post has not yet been approved!',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
