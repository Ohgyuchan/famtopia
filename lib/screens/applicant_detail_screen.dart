import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/applicants.dart';
<<<<<<< HEAD
=======
import 'package:hr_relocation/screens/sign_in_screen.dart';
>>>>>>> master

class ApplicantDetailScreen extends StatefulWidget {
  const ApplicantDetailScreen(
      {Key? key, required User user, required ApplicantItem applicantItem})
      : _user = user,
        _applicantItem = applicantItem,
        super(key: key);

  final User _user;
  final ApplicantItem _applicantItem;

  @override
  _ApplicantDetailScreenState createState() => _ApplicantDetailScreenState();
}

class _ApplicantDetailScreenState extends State<ApplicantDetailScreen> {
  late User _user;
  late ApplicantItem _applicantItem;

  @override
  void initState() {
    _user = widget._user;
    _applicantItem = widget._applicantItem;

    super.initState();
  }

  late String id;

  @override
  Widget build(BuildContext context) {
    AppBar appBarSection() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
                _applicantItem.firstName + ' ' + _applicantItem.secondName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    Widget positionInfo = ListView(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(children: [
                  _buildListTile(context, 'ID #', _applicantItem.idnum),
                  _buildListTile(
                      context, 'Position', _applicantItem.currentPosition),
                  _buildListTile(context, 'Level', _applicantItem.currentLevel),
                  _buildListTile(context, 'Duty Station',
                      _applicantItem.currentDutyStation),
                  _buildListTile(
                      context, 'Nationality', _applicantItem.nationality),
                  _buildListTile(context, 'Gender', _applicantItem.gender),
                  _buildListTile(context, 'Email', _applicantItem.email),
                  _buildListTile(context, 'Phone', _applicantItem.phoneNum),
                ]),
              ),
            ),
          ],
        ),
      ),
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarSection(),
      body: Container(
        child: Column(children: [
          Expanded(child: positionInfo),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: _user.uid == hrUid || _user.uid == hmUid
                  ? buttonBuild()
                  : null),
        ]),
      ),
    );
  }

  //widget.approval ? widget.title : 'Waiting for Approval',

  ElevatedButton buttonBuild() {
    return ElevatedButton(
      child: Text('Hiring'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  ListTile _buildListTile(BuildContext context, String label, String value) {
    return ListTile(
      dense: true,
      title: Text(
        label,
        style: TextStyle(color: Colors.blue, fontSize: 14),
      ),
      subtitle: Container(
        padding: EdgeInsets.only(top: 8, bottom: 15),
        child: Text(
          value,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text('Your posting have to be approved before you apply!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
      ),
    );
  }
}

Future<void> deletePost(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection("posts").doc(doc.id).delete();
}

Future<void> updateApproval(DocumentSnapshot doc, bool approval) async {
  await FirebaseFirestore.instance
      .collection("posts")
      .doc(doc.id)
      .update({"approval": approval});
}

Future<void> updateApproved(String uid, bool approved) async {
  await FirebaseFirestore.instance
      .collection("approved")
      .doc(uid)
      .update({"approved": approved});
}

Future<void> updatePosted(String uid, bool posted) async {
  await FirebaseFirestore.instance
      .collection("approved")
      .doc(uid)
      .update({"posted": posted});
}
