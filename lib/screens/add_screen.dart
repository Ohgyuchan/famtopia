// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hr_relocation/screens/layout_template/layout_template.dart';
// import 'package:hr_relocation/screens/sign_in_screen.dart';
// import 'package:hr_relocation/utils/authentication.dart';
// import 'package:image_picker/image_picker.dart';

// class AddScreen extends StatefulWidget {
//   @override
//   _AddScreenState createState() => _AddScreenState();
// }

// CollectionReference postdb = FirebaseFirestore.instance.collection('posts');

// class _AddScreenState extends State<AddScreen> {
//   late File? imageFile = null;
//   final picker = ImagePicker();

//   chooseImage(ImageSource source) async {
//     final pickedFile = await picker.getImage(source: source);

//     setState(() {
//       imageFile = File(pickedFile!.path);
//     });
//   }

//   TextEditingController branchController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController divisionController = TextEditingController();
//   TextEditingController dutystationController = TextEditingController();
//   TextEditingController levelController = TextEditingController();
//   TextEditingController postController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController positionController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Center(child: Text('Add', style: TextStyle(color: Colors.blue),)),
//         leading: TextButton(
//           child: Text('Cancel'),
//           style: TextButton.styleFrom(
//               primary: Colors.black, textStyle: TextStyle(fontSize: 12)),
//           onPressed: () {
//             Navigator.pop(context);

//           },
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Save'),
//             style: TextButton.styleFrom(
//                 primary: Colors.blueAccent, textStyle: TextStyle(fontSize: 12)),
//             onPressed: () {
//               addPost(

//                 titleController.text,
//                 positionController.text,
//                 currentUser.uid,
//                 levelController.text,
//                 postController.text,
//                 divisionController.text,
//                 branchController.text,
//                 dutystationController.text,
//                 descriptionController.text,
//               );
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => LayoutTemplate(user: currentUser),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
// //             Container(
// //               child: imageFile != null?
// //               GestureDetector(
// //                 onTap:(){
// // chooseImage(ImageSource.gallery);
// //                 },
// //                               child: Container(
// //                 height:200,
// //                 width: 200,
// //                 decoration: BoxDecoration(
// //                   image: DecorationImage(
// //                     image:FileImage(imageFile!),
// //                   ),
// //                 ),
// //             ),
// //               )
// //             : Container(
// //               height:200,
// //               width:200,
// //               decoration:BoxDecoration(
// //                 color:Colors.grey
// //               )
// //             ),
// //             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Title",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: titleController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Position",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: positionController,
//             ),
//             TextField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Position Level",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: levelController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Post",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: postController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Division",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: divisionController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Branch",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: branchController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "DutyStation",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: dutystationController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Description",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: descriptionController,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> addPost(

//       String title,
//       String uid,

//       String position,
//       String level,
//       String post,
//       String division,
//       String branch,
//       String dutystation,
//       String description,) {
//     return postdb
//         .add({
//           'title': title,
//           'uid': uid,
//           'position':position,
//           'level': level,
//           'post': post,
//           'division': division,
//           'branch': branch,
//           'dutystation': dutystation,
//           'description': description,
//         })
//         .then((value) => print("Post Added"))
//         .catchError((error) => print("Failed to add Post: $error"));
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/layout_template/layout_template.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    // TextEditingController branchController = TextEditingController();
    // TextEditingController descriptionController = TextEditingController();
    // TextEditingController divisionController = TextEditingController();
    // TextEditingController dutystationController = TextEditingController();
    // TextEditingController levelController = TextEditingController();
    // TextEditingController postController = TextEditingController();
    // TextEditingController titleController = TextEditingController();
    // TextEditingController positionController = TextEditingController();
    var _selectedPositionValue;
    var _selectedLevelValue;
    var _selectedDutyStationValue;
    var _selectedDivisionValue;

    final dropdownState = GlobalKey<FormFieldState>();

    @override
    void initState() {
      _selectedPositionValue = '';
      _selectedLevelValue = '';
      _selectedDutyStationValue = '';
      _selectedDivisionValue = '';

      super.initState();
    }

    final _jobList = [
      'Chef',
      'Data Analyst',
      'Designer',
      'Developer',
      'Doctor',
      'Financial Planner',
      'Marketer',
      'Personnel manager',
      'Project Manager'
    ];

    final _levelList = ['1', '2', '3', '4', '5'];

    final _dutyStationList = [
      'Bangkok',
      'Geneva',
      'Nairobi',
      'New York',
      'Santiago',
      'Vienna',
    ];

    final _divisionList = [
      'Department of Global Communications',
      'Department of Peace Operations',
      'United Nations Environment Programme',
      'Department of Political Affairs and Peace-building',
      'Resident Coordinator System',
      'Department of Safety and Security',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Add',
          style: TextStyle(color: Colors.blue),
        )),
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
                primary: Colors.blueAccent, textStyle: TextStyle(fontSize: 12)),
            onPressed: () {
              addPost(
                titleController.text,
                _selectedPositionValue,
                _selectedLevelValue,
                //postController.text,
                _selectedDutyStationValue,
                _selectedDivisionValue,
                //divisionController.text,
                //branchController.text,
                descriptionController.text,
                currentUser.uid,
                // titleController.text,
                // positionController.text,
                // currentUser.uid,
                // levelController.text,
                // postController.text,
                // divisionController.text,
                // branchController.text,
                // dutystationController.text,
                // descriptionController.text,
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
            Container(
              padding: EdgeInsets.only(left:20,right:20),
                          child: TextField(
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
                      fontSize: 14,
                    )),
                controller: titleController,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              dense: true,
              title: Text('Position',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: DropdownButtonFormField(
                    isExpanded: true,
                    //value: _selectedPositionValue,
                    items: _jobList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPositionValue = value.toString();
                        dropdownState.currentState!
                            .didChange(_selectedPositionValue);
                        //_postItem.position = _selectedPositionValue;
                      });
                    }),
              ),
            ),
            SizedBox(height: 15.0),
            ListTile(
              dense: true,
              title: Text('Position Level',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: DropdownButtonFormField(
                    isExpanded: true,
                    //value: _selectedLevelValue,
                    items: _levelList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLevelValue = value.toString();
                        dropdownState.currentState!
                            .didChange(_selectedPositionValue);
                        //_postItem.level = _selectedLevelValue;
                      });
                    }),
              ),
            ),
            SizedBox(height: 15.0),
            ListTile(
              dense: true,
              title: Text('Duty Station',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: DropdownButtonFormField(
                    isExpanded: true,
                    //value: _selectedDutyStationValue,
                    items: _dutyStationList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDutyStationValue = value.toString();
                        dropdownState.currentState!
                            .didChange(_selectedPositionValue);
                        //_postItem.dutystation = _selectedDutyStationValue;
                      });
                    }),
              ),
            ),

            SizedBox(height: 15.0),
            ListTile(
              dense: true,
              title: Text('Division',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: DropdownButtonFormField(
                    isExpanded: true,
                    //value: _selectedDivisionValue,
                    items: _divisionList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDivisionValue = value.toString();
                        dropdownState.currentState!
                            .didChange(_selectedPositionValue);
                        //_postItem.division = _selectedDivisionValue;
                      });
                    }),
              ),
            ),

            // TextField(
            //   decoration: InputDecoration(
            //       focusedBorder: new UnderlineInputBorder(
            //           borderSide: new BorderSide(
            //               color: Colors.blue,
            //               width: 2,
            //               style: BorderStyle.solid)),
            //       labelText: "Position",
            //       fillColor: Colors.white,
            //       labelStyle: TextStyle(
            //         color: Colors.blue,
            //       )),
            //   controller: positionController,
            // ),
            // TextField(
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //       focusedBorder: new UnderlineInputBorder(
            //           borderSide: new BorderSide(
            //               color: Colors.blue,
            //               width: 2,
            //               style: BorderStyle.solid)),
            //       labelText: "Position Level",
            //       fillColor: Colors.white,
            //       labelStyle: TextStyle(
            //         color: Colors.blue,
            //       )),
            //   controller: levelController,
            // ),
            // TextField(
            //   decoration: InputDecoration(
            //       focusedBorder: new UnderlineInputBorder(
            //           borderSide: new BorderSide(
            //               color: Colors.blue,
            //               width: 2,
            //               style: BorderStyle.solid)),
            //       labelText: "Post",
            //       fillColor: Colors.white,
            //       labelStyle: TextStyle(
            //         color: Colors.blue,
            //       )),
            //   controller: postController,
            // ),
            // TextField(
            //   decoration: InputDecoration(
            //       focusedBorder: new UnderlineInputBorder(
            //           borderSide: new BorderSide(
            //               color: Colors.blue,
            //               width: 2,
            //               style: BorderStyle.solid)),
            //       labelText: "Division",
            //       fillColor: Colors.blue,
            //       labelStyle: TextStyle(
            //         color: Colors.blue,
            //       )),
            //   controller: divisionController,
            // ),
            // TextField(
            //   decoration: InputDecoration(
            //       focusedBorder: new UnderlineInputBorder(
            //           borderSide: new BorderSide(
            //               color: Colors.blue,
            //               width: 2,
            //               style: BorderStyle.solid)),
            //       labelText: "Branch",
            //       fillColor: Colors.blue,
            //       labelStyle: TextStyle(
            //         color: Colors.blue,
            //       )),
            //   controller: branchController,
            // ),
            // TextField(
            //   decoration: InputDecoration(
            //       focusedBorder: new UnderlineInputBorder(
            //           borderSide: new BorderSide(
            //               color: Colors.blue,
            //               width: 2,
            //               style: BorderStyle.solid)),
            //       labelText: "DutyStation",
            //       fillColor: Colors.blue,
            //       labelStyle: TextStyle(
            //         color: Colors.blue,
            //       )),
            //   controller: dutystationController,
            // ),
            SizedBox(height:30),
            Container(
              padding: EdgeInsets.only(left:20,right:20),
                          child: TextField(
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
                      fontSize: 14,
                    )),
                controller: descriptionController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPost(
    String title,
    String position,
    String level,
    //String post,
    String division,
    //String branch,
    String dutystation,
    String description,
    String uid,
  ) {
    return postdb
        .add({
          'title': title,
          'position': position,
          'level': level,
          'dutystation': dutystation,
          //'post': post,
          'division': division,
          //'branch': branch,
          'description': description,
          'uid': uid,
        })
        .then((value) => print("Post Added" + position + ' ' + level))
        .catchError((error) => print("Failed to add Post: $error"));
  }
}

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hr_relocation/screens/layout_template/layout_template.dart';
// import 'package:hr_relocation/screens/sign_in_screen.dart';
// import 'package:hr_relocation/utils/authentication.dart';
// import 'package:image_picker/image_picker.dart';

// class AddScreen extends StatefulWidget {
//   @override
//   _AddScreenState createState() => _AddScreenState();
// }

// CollectionReference postdb = FirebaseFirestore.instance.collection('posts');

// class _AddScreenState extends State<AddScreen> {
//   late File? imageFile = null;
//   final picker = ImagePicker();

//   chooseImage(ImageSource source) async {
//     final pickedFile = await picker.getImage(source: source);

//     setState(() {
//       imageFile = File(pickedFile!.path);
//     });
//   }

//   TextEditingController branchController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController divisionController = TextEditingController();
//   TextEditingController dutystationController = TextEditingController();
//   TextEditingController levelController = TextEditingController();
//   TextEditingController postController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController positionController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Center(child: Text('Add', style: TextStyle(color: Colors.blue),)),
//         leading: TextButton(
//           child: Text('Cancel'),
//           style: TextButton.styleFrom(
//               primary: Colors.black, textStyle: TextStyle(fontSize: 12)),
//           onPressed: () {
//             Navigator.pop(context);

//           },
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Save'),
//             style: TextButton.styleFrom(
//                 primary: Colors.blueAccent, textStyle: TextStyle(fontSize: 12)),
//             onPressed: () {
//               addPost(

//                 titleController.text,
//                 positionController.text,
//                 currentUser.uid,
//                 levelController.text,
//                 postController.text,
//                 divisionController.text,
//                 branchController.text,
//                 dutystationController.text,
//                 descriptionController.text,
//               );
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => LayoutTemplate(user: currentUser),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
// //             Container(
// //               child: imageFile != null?
// //               GestureDetector(
// //                 onTap:(){
// // chooseImage(ImageSource.gallery);
// //                 },
// //                               child: Container(
// //                 height:200,
// //                 width: 200,
// //                 decoration: BoxDecoration(
// //                   image: DecorationImage(
// //                     image:FileImage(imageFile!),
// //                   ),
// //                 ),
// //             ),
// //               )
// //             : Container(
// //               height:200,
// //               width:200,
// //               decoration:BoxDecoration(
// //                 color:Colors.grey
// //               )
// //             ),
// //             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Title",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: titleController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Position",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: positionController,
//             ),
//             TextField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Position Level",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: levelController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Post",
//                   fillColor: Colors.white,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: postController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Division",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: divisionController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Branch",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: branchController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "DutyStation",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: dutystationController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   focusedBorder: new UnderlineInputBorder(
//                       borderSide: new BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                           style: BorderStyle.solid)),
//                   labelText: "Description",
//                   fillColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: Colors.blue,
//                   )),
//               controller: descriptionController,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> addPost(

//       String title,
//       String uid,

//       String position,
//       String level,
//       String post,
//       String division,
//       String branch,
//       String dutystation,
//       String description,) {
//     return postdb
//         .add({
//           'title': title,
//           'uid': uid,
//           'position':position,
//           'level': level,
//           'post': post,
//           'division': division,
//           'branch': branch,
//           'dutystation': dutystation,
//           'description': description,
//         })
//         .then((value) => print("Post Added"))
//         .catchError((error) => print("Failed to add Post: $error"));
//   }
// }
