import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/applicants.dart';
import 'package:hr_relocation/models/post.dart';

class ApplyStateScreen extends StatefulWidget {
  const ApplyStateScreen(
      {Key? key, required User user, required PostItem postItem})
      : _user = user,
        _postItem = postItem,
        super(key: key);

  final User _user;
  final PostItem _postItem;

  @override
  _ApplyStateScreenState createState() => _ApplyStateScreenState();
}

CollectionReference postdb = FirebaseFirestore.instance.collection('posts');

class _ApplyStateScreenState extends State<ApplyStateScreen> {
  late User _user;
  late PostItem _postItem;

  @override
  void initState() {
    _user = widget._user;
    _postItem = widget._postItem;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection(),
      body: _buildStream(context),
    );
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: postdb.doc(_postItem.id).collection(_postItem.uid).snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    childAspectRatio: MediaQuery.of(context).size.width >= 949
                        ? 7.0 / 1.2
                        : MediaQuery.of(context).size.width >= 598 ? 7.0 / 2.0 : 7.0 / 3.0,
                    crossAxisCount: 1),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return ApplicantItem(
                    idnum: data['idnum'],
                    firstName: data['First Name'],
                    secondName: data['Second Name'],
                    phoneNum: data['Phone Number'],
                    email: data['Email'],
                    gender: data['Gender'],
                    nationality: data['Nationality'],
                    currentPosition: data['Current Position'],
                    currentLevel: data['Current Level'],
                    currentDutyStation: data['Current Duty Station'],
                    applicant: data['applicant'],
                    poster: data['poster'],
                    id: data.id,
                    documentSnapshot: data,
                  );
                },
              );
      },
    );
  }

  AppBar appBarSection() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
            child: Text('Apply Status',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onPressed: () {
              //TODO:filtering
            },
          ),
        ]);
  }
}
