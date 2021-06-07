import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
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

  
  TextEditingController branchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  TextEditingController dutystationController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    //int thumbs = 31;
    Widget titleSection = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
            child: Hero(
                        tag: 'job-${widget._postItem.uid}',
                        child: Image.asset(
                          'assets/jobs/job5.png',
                          //width:300,
                          height: 250,
                          fit: BoxFit.fitHeight,
                          //alignment: Alignment(0,-pageOffset.abs()+posts.id),
                        ),
                      ),
          ),
                Container(
                  
                        padding: EdgeInsets.only(left:10.0),
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.only(bottom: 8),
                      //   child: Text(
                      //     _postItem.title,
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: Text(
                          'Level: ' + '${_postItem.level}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: Text(
                          'Post: ' + '${_postItem.post}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: Text(
                          'Division: ' + '${_postItem.division}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ), 
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: Text(
                          'Branch: ' + '${_postItem.branch}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: Text(
                          'Dutystation: ' + '${_postItem.dutystation}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                   

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
        ],
      ),
    );

    Widget description = Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.all(20.0),
      child: Container(
        child: Text(
          _postItem.description,
          style: TextStyle(color: Colors.blueGrey, fontSize: 15),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.white,
        title: Center(child: Text(
                        _postItem.title,style:TextStyle(color:Colors.black))),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            
                        print(widget._postItem.uid);
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
                                builder: (context) => EditScreen(
                                    user: currentUser, postItem: _postItem),
                              ),
                            );
              } else {}
               
              print(_postItem.uid);
              print(_user.uid);
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
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              // Container(
              //   height: MediaQuery
              //       .of(context)
              //       .size
              //       .height * 0.3,
              //   child: Stack(
              //     children: [
              //       InkWell(
              //         child: Image.network(
              //           _postItem.p,
              //           fit: BoxFit.fitWidth,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              titleSection,
              //Divider(height: 1.0, color: Colors.black),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'creator: <' + _postItem.id + '>',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
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
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> deletePost(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection("posts").doc(doc.id).delete();
}
