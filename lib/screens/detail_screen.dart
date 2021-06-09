import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/apply_screen.dart';
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
  //bool thumup = false;
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
          IconButton(
            icon: Icon(
              Icons.create,
              color: Colors.black,
            ),
            onPressed: () {
              if (_postItem.uid == _user.uid) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EditScreen(user: _user, postItem: _postItem),
                  ),
                );
              } else {}
              // if (_postItem.id == _user.uid) {
              //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              //       builder: (context) => EditPage(user: _user, productItem: _postItem)),
              //           (Route<dynamic> route) => false);
              // }
              // else {
              // }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              if (_postItem.uid == _user.uid) {
                deletePost(_postItem.documentSnapshot);
                Navigator.pop(context);
              } else {}
            },
          ),
        ],
      );
    }

    Widget positionInfo = 
    Column(
    children: [Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            child: Hero(
              tag: 'img-${widget._postItem.position}-${widget._postItem.id}',
              child: Image.asset(
                'assets/jobs/${widget._postItem.position}.png',
                height: 250,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(children: [
                _buildListTile(context, 'Position', _postItem.position),
                _buildListTile(context, 'Level', _postItem.level),
                _buildListTile(context, 'Duty Station', _postItem.dutystation),
                _buildListTile(context, 'Division', _postItem.division),
              ]),
            ),
          ),
          // IconButton(
          //   icon: (thumup
          //       ? Icon(Icons.thumb_up)
          //       : Icon(Icons.thumb_up_outlined)),
          //   onPressed: () {
          //     setState(() {
          //       if (thumup == false) {
          //         thumbs = thumbs + 1;
          //         thumup = !thumup;
          //       }
          //     });
          //   },
          //   iconSize: 30,
          //   color: Colors.red,
          // ),
          // Text('${thumbs}',
          //     style: TextStyle(
          //       color: Colors.redAccent,
          //       fontSize: 30,
          //     )),
        ],
      ),
    ),
    Container(
      //height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.all(20.0),
      child: Container(
        child: _buildListTile(context, 'Description', _postItem.description),
      ),
    ),
    ]
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarSection(),
      body: Container(
        child: Column(
          children: [
          Expanded(child: positionInfo),
          ElevatedButton(
            child: Text('APPLY'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ApplyScreen(
                    postItem: _postItem,
                    user: _user,
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'creator: <' + _postItem.id + '>',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 20),
          //   child: Text(_postItem..toDate().toString() +
          //       ' created',
          //     style: TextStyle(color: Colors.grey, fontSize: 10),
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.only(left: 20),
          //   child: Text(_postItem.modified.toDate().toString() +
          //       ' modified',
          //     style: TextStyle(color: Colors.grey, fontSize: 10),
          //   ),
          // ),
        ]),
      ),
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
}

class Containor {}

Future<void> deletePost(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection("posts").doc(doc.id).delete();
}
