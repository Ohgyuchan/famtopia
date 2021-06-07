import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

import 'layout_template/layout_template.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required User user, required PostItem postItem})
      : _user = user,
        _postItem = postItem,
        super(key: key);

  final User _user;
  final PostItem _postItem;

  @override
  _EditScreenState createState() => _EditScreenState();
}


CollectionReference postdb = FirebaseFirestore.instance.collection('posts');

class _EditScreenState extends State<EditScreen> {
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
                        ),
                      ),
          ),
                Container(
                  
                        padding: EdgeInsets.only(left:10.0),
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Position Level",
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: levelController,
            ),
                      ),

                      
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Post",
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: postController,
            ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child:    TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Division",
                  fillColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: divisionController,
            ),
                        ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child: TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Branch",
                  fillColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: branchController,
            ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom:10.0),
                        child:  TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "DutyStation",
                  fillColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: dutystationController,
            ),
                      ),
                      
                    ],
                   

                  ),
                ),
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
        child: 
        // Text(
        //   _postItem.description,
        //   style: TextStyle(color: Colors.blueGrey, fontSize: 15),
        // ),
                  TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Description",
                  fillColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: descriptionController,
            ),
      ),
      
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.white,
        title: Center(child: Text(_postItem.title)
        // TextField(
        //       decoration: InputDecoration(
        //           focusedBorder: new UnderlineInputBorder(
        //               borderSide: new BorderSide(
        //                   color: Colors.blue,
        //                   width: 2,
        //                   style: BorderStyle.solid)),
        //           labelText: "Title",
        //           fillColor: Colors.white,
        //           labelStyle: TextStyle(
        //             color: Colors.blue,
        //           )),
        //       controller: titleController,
        //     ),
                        ),
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
          TextButton(
            child: Text('Save'),
            //style: TextStyle(color: ) 
            // TextButton.styleFrom(
            //     primary: Colors.white, textStyle: TextStyle(fontSize: 12)),
            onPressed: () {
              editPost(
                titleController.text,
                currentUser.uid,
                levelController.text,
                postController.text,
                divisionController.text,
                branchController.text,
                dutystationController.text,
                descriptionController.text,
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LayoutTemplate(user: currentUser),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              titleSection,
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

  Future<void> editPost(
    
      String title,
      String uid,
      String level,
      String post,
      String division,
      String branch,
      String dutystation,
      String description,) {
    return postdb
        .doc(currentUser.uid).update({
          'title': title,
          'uid': uid,
          'level': level,
          'post': post,
          'division': division,
          'branch': branch,
          'dutystation': dutystation,
          'description': description,
        })
        .then((value) => print("Post edited"))
        .catchError((error) => print("Failed to add Post: $error"));
  }
}