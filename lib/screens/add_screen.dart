import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/screens/layout_template/layout_template.dart';
import 'package:hr_relocation/screens/sign_in_screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

CollectionReference postdb = FirebaseFirestore.instance.collection('posts');
CollectionReference approveddb =
    FirebaseFirestore.instance.collection('approved');

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    //TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

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
          'Create HR Relocation',
          style: TextStyle(color: Colors.black),
        )),
        leading: TextButton(
          child: Text('Cancel'),
          style: TextButton.styleFrom(
              primary: Colors.black, textStyle: TextStyle(fontSize: 12)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            ListTile(
              dense: true,
              title: Text('Position',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
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
                        dropdownState.currentState!
                            .didChange(_selectedLevelValue);
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
                        dropdownState.currentState!
                            .didChange(_selectedDutyStationValue);
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
                        dropdownState.currentState!
                            .didChange(_selectedDivisionValue);
                        //_postItem.division = _selectedDivisionValue;
                      });
                    }),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                child: Text('Request approval for posting'),
                onPressed: () {
                  addPost(
                    _selectedPositionValue,
                    _selectedLevelValue,
                    _selectedDutyStationValue,
                    _selectedDivisionValue,
                    descriptionController.text,
                    currentUser.uid,
                  );
                  updatePosted(currentUser.uid, true);
                  setState(() {
                    posted = true;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LayoutTemplate(user: currentUser),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPost(
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
          'title': position,
          'position': position,
          'level': level,
          'dutystation': dutystation,
          'division': division,
          'approval': false,
          'description': description,
          'uid': uid,
        })
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add Post: $error"));
  }

  Future<void> updatePosted(String uid, bool posted) async {
    await FirebaseFirestore.instance
        .collection("approved")
        .doc(uid)
        .update({"posted": posted});
  }
}
