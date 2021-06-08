import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

import 'home/home_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: _postItem.title);
    TextEditingController levelController =
        TextEditingController(text: _postItem.level);
    // TextEditingController postController =
    //     TextEditingController(text: _postItem.post);
    TextEditingController divisionController =
        TextEditingController(text: _postItem.division);
    // TextEditingController branchController =
    //     TextEditingController(text: _postItem.branch);
    TextEditingController descriptionController =
        TextEditingController(text: _postItem.description);

    final _jobList = [
      'Chef',
      'Data Analyst',
      'Designer',
      'Developer',
      'Doctor',
      'Fanancial Planner',
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

    var _selectedPositionValue = widget._postItem.position;
    var _selectedLevelValue = widget._postItem.level;
    var _selectedDutyStationValue = widget._postItem.dutystation;
    var _selectedDivisionValue = widget._postItem.division;

    AppBar appBarSection() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            //Center(child: Text(_postItem.title)
            TextFormField(
          decoration: InputDecoration(
              focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.blue, width: 2, style: BorderStyle.solid)),
              labelText: "Title",
              fillColor: Colors.white,
              labelStyle: TextStyle(
                color: Colors.blue,
              )),
          controller: titleController,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            print(_postItem.uid);
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              updatePost(
                _postItem.id,
                titleController.text,
                _selectedPositionValue,
                _selectedLevelValue,
                //postController.text,
                _selectedDutyStationValue,
                _selectedDivisionValue,
                //divisionController.text,
                //branchController.text,
                descriptionController.text,
              );
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
      );
    }

    Widget PositionInfo = Container(
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
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    title: Text('Position',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _selectedPositionValue,
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
                              _postItem.position = _selectedPositionValue;
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  ListTile(
                    dense: true,
                    title: Text('Position Level',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _selectedLevelValue,
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
                               _postItem.level = _selectedLevelValue;
                            });
                          }),
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.5,
                  //   padding: EdgeInsets.only(bottom: 10.0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //         focusedBorder: new UnderlineInputBorder(
                  //             borderSide: new BorderSide(
                  //                 color: Colors.blue,
                  //                 width: 2,
                  //                 style: BorderStyle.solid)),
                  //         labelText: "Post",
                  //         fillColor: Colors.white,
                  //         labelStyle: TextStyle(
                  //           color: Colors.blue,
                  //         )),
                  //     controller: postController,
                  //   ),
                  // ),

                  SizedBox(height: 15.0),
                  ListTile(
                    dense: true,
                    title: Text('Duty Station',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _selectedDutyStationValue,
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
                              _postItem.dutystation = _selectedDutyStationValue;
                            });
                          }),
                    ),
                  ),

                  SizedBox(height: 15.0),
                  ListTile(
                    dense: true,
                    title: Text('Division',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          value: _selectedDivisionValue,
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
                              _postItem.division = _selectedDivisionValue;
                            });
                          }),
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.4,
                  //   padding: EdgeInsets.only(bottom: 10.0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //         focusedBorder: new UnderlineInputBorder(
                  //             borderSide: new BorderSide(
                  //                 color: Colors.blue,
                  //                 width: 2,
                  //                 style: BorderStyle.solid)),
                  //         labelText: "Division",
                  //         fillColor: Colors.blue,
                  //         labelStyle: TextStyle(
                  //           color: Colors.blue,
                  //         )),
                  //     controller: divisionController,
                  //   ),
                  // ),

                  SizedBox(height: 15.0),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.4,
                  //   padding: EdgeInsets.only(bottom: 10.0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //         focusedBorder: new UnderlineInputBorder(
                  //             borderSide: new BorderSide(
                  //                 color: Colors.blue,
                  //                 width: 2,
                  //                 style: BorderStyle.solid)),
                  //         labelText: "Branch",
                  //         fillColor: Colors.blue,
                  //         labelStyle: TextStyle(
                  //           color: Colors.blue,
                  //         )),
                  //     controller: branchController,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Widget description = Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.all(20.0),
      child: Container(
        child: TextFormField(
          decoration: InputDecoration(
              focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.blue, width: 2, style: BorderStyle.solid)),
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
      appBar: appBarSection(),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              PositionInfo,
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

  Future<void> updatePost(
    String id,
    String title,
    String position,
    String level,
    //String post,
    String dutystation,
    String division,
    //String branch,
    String description,
  ) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"title": title});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"position": position});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"level": level});
    // await FirebaseFirestore.instance
    //     .collection("posts")
    //     .doc(id)
    //     .update({"post": post});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"dutystation": dutystation});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"division": division});
    // await FirebaseFirestore.instance
    //     .collection("posts")
    //     .doc(id)
    //     .update({"branch": branch});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"description": description});
  }
}
