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
            : ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return ApplicantItem(
                    uid: data['uid'],
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
