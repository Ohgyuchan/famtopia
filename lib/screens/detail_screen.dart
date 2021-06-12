import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/apply_screen.dart';
import 'package:hr_relocation/screens/apply_state_screen.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';
import 'edit_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required User user, required PostItem postItem})
      : _user = user,
        _postItem = postItem,
        super(key: key);

  final User _user;
  final PostItem _postItem;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late User _user;
  late PostItem _postItem;

  @override
  void initState() {
    _user = widget._user;
    _postItem = widget._postItem;

    super.initState();
  }

  late String id;

  @override
  Widget build(BuildContext context) {
    //int thumbs = 31;

    AppBar appBarSection() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(_postItem.title,
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
        actions: <Widget>[
          if (_postItem.uid == _user.uid)
            IconButton(
              icon: Icon(
                Icons.create,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EditScreen(user: _user, postItem: _postItem),
                  ),
                );
              },
            ),
          if (_postItem.uid == _user.uid ||
              _user.uid == hrUid ||
              _user.uid == hmUid)
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () {
                  deletePost(_postItem.documentSnapshot);
                  updateApproved(_postItem.uid, false);
                  updatePosted(_postItem.uid, false);
                  setState(() {
                    posted = false;
                  });
                  Navigator.pop(context);
                }),
        ],
      );
    }

    Widget positionInfo = ListView(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              child: Hero(
                tag: 'img-${widget._postItem.position}-${widget._postItem.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    'assets/jobs/officer/${widget._postItem.position}.jpg',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(children: [
                  _buildListTile(context, 'Position', _postItem.position),
                  _buildListTile(context, 'Level', _postItem.level),
                  _buildListTile(
                      context, 'Duty Station', _postItem.dutystation),
                  _buildListTile(context, 'Division', _postItem.division),
                ]),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.all(20.0),
        child: _buildListTile(context, 'Description', _postItem.description),
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
              child: buttonBuild()),
        ]),
      ),
    );
  }

  //widget.approval ? widget.title : 'Waiting for Approval',

  ElevatedButton buttonBuild() {
    if (_user.uid == '6fR2eH8V7pfagW6qpKPfsqNuUWK2') if (_postItem.approval)
      return ElevatedButton(
        child: Text('Apply Status'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ApplyStateScreen(
                postItem: _postItem,
                user: _user,
              ),
            ),
          );
        },
      );
    else
      return ElevatedButton(
        child: Text('Approve'),
        onPressed: () {
          updateApproval(_postItem.documentSnapshot, true);
          updateApproved(_postItem.uid, true);
          Navigator.pop(context);
        },
      );
    else if (_user.uid != _postItem.uid)
      return ElevatedButton(
        child: Text('Apply'),
        onPressed: () {
          if (approved == false)
            Navigator.of(context).restorablePush(_dialogBuilder);
          else
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ApplyScreen(
                  postItem: _postItem,
                  user: _user,
                ),
              ),
            );
        },
      );
    else
      return ElevatedButton(
        child: Text('Apply Status'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ApplyStateScreen(
                postItem: _postItem,
                user: _user,
              ),
            ),
          );
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
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey,
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
