import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/detail_screen.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

class ApplicantItem extends StatefulWidget {
  final String idnum;
  final String firstName;
  final String secondName;
  final String phoneNum;
  final String email;
  final String gender;
  final String nationality;
  final String currentPosition;
  final String currentLevel;
  final String currentDutyStation;
  final String applicant;
  final String poster;
  final String id;
  final DocumentSnapshot documentSnapshot;

  ApplicantItem({
    required this.idnum,
    required this.firstName,
    required this.secondName,
    required this.phoneNum,
    required this.email,
    required this.gender,
    required this.nationality,
    required this.currentPosition,
    required this.currentLevel,
    required this.currentDutyStation,
    required this.applicant,
    required this.poster,
    required this.id,
    required this.documentSnapshot,
  });

  @override
  _ApplicantItemState createState() => _ApplicantItemState();
}

class _ApplicantItemState extends State<ApplicantItem> {
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
                    SizedBox(height: 16),
                    Text(
                      widget.firstName + ' ' + widget.secondName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    SizedBox(height: 16),
                    _buildCardRow(context, 'Current Position', widget.currentPosition),
                    SizedBox(
                        height: 8.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(context, 'Current Level', widget.currentLevel),
                    SizedBox(
                        height: 4.0 / MediaQuery.of(context).size.height * 0.2),
                    _buildCardRow(context, 'Current Dutystation', widget.currentDutyStation),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         ApplicantDetailScreen(user: currentUser, ApplicantItem: widget),
            //   ),
            // );
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
