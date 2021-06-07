import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/layout_template/layout_template.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';
import 'package:hr_relocation/utils/authentication.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

CollectionReference postdb = FirebaseFirestore.instance.collection('posts');

class _AddScreenState extends State<AddScreen> {
  late File? imageFile = null;
  final picker = ImagePicker();

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  TextEditingController branchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  TextEditingController dutystationController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add')),
        leading: TextButton(
          child: Text('Cancel'),
          style: TextButton.styleFrom(
              primary: Colors.black, textStyle: TextStyle(fontSize: 12)),
          onPressed: () {
            Navigator.pop(context);
            
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            style: TextButton.styleFrom(
                primary: Colors.white, textStyle: TextStyle(fontSize: 12)),
            onPressed: () {
              addPost(
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//             Container(
//               child: imageFile != null?
//               GestureDetector(
//                 onTap:(){
// chooseImage(ImageSource.gallery);
//                 },
//                               child: Container(
//                 height:200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image:FileImage(imageFile!),
//                   ),
//                 ),
//             ),
//               )
//             : Container(
//               height:200,
//               width:200,
//               decoration:BoxDecoration(
//                 color:Colors.grey
//               )
//             ),
//             ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Title",
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              controller: titleController,
            ),

            TextField(
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
            TextField(
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
            TextField(
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
            TextField(
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
            TextField(
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
          ],
        ),
      ),
    );
  }

  Future<void> addPost(
    
      String title,
      String uid,
      String level,
      String post,
      String division,
      String branch,
      String dutystation,
      String description,) {
    return postdb
        .add({
          'title': title,
          'uid': uid,
          'level': level,
          'post': post,
          'division': division,
          'branch': branch,
          'dutystation': dutystation,
          'description': description,
        })
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add Post: $error"));
  }
}
