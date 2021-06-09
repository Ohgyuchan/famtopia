import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({Key? key, required User user, required PostItem postItem})
      : _user = user,
        _postItem = postItem,
        super(key: key);

  final User _user;
  final PostItem _postItem;

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

CollectionReference applicationdb =
    FirebaseFirestore.instance.collection('apllications');

class _ApplyScreenState extends State<ApplyScreen> {
  late User _user;
  late PostItem _postItem;

  var _selectedGenderValue;
  var _selectedNationalityValue;
  var _selectedCurrentPositionValue;
  var _selectedCurrentLevelValue;
  var _selectedCurrentDutyStationValue;

  late String id;

  @override
  Widget build(BuildContext context) {
    TextEditingController idNumController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();

    final dropdownState = GlobalKey<FormFieldState>();

    @override
    void initState() {
      _user = widget._user;
      _postItem = widget._postItem;

      _selectedGenderValue = '';
      _selectedNationalityValue = '';
      _selectedCurrentPositionValue = '';
      _selectedCurrentLevelValue = '';
      _selectedCurrentDutyStationValue = '';

      super.initState();
    }

    final _genderList = [
      'Male',
      'Female',
    ];

    final _nationalityList = [
      'American',
      'British',
      'Canadian',
      'Chinese',
      'French',
      'Indian',
      'Italian',
      'Japanese',
      'Korean',
      'Russian',
    ];

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

    AppBar appBarSection() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            Center(child: Text('Application', style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold))),
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
          TextButton(
            child: Text('Save'),
            onPressed: () {
              addApplication(
                _postItem.id,
                idNumController.text,
                firstNameController.text,
                secondNameController.text,
                _selectedGenderValue,
                _selectedNationalityValue,
                _selectedCurrentPositionValue,
                _selectedCurrentLevelValue,
                _selectedCurrentDutyStationValue,
              );
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
      );
    }

    Widget BasicInfo = Container(
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.blue,
                              width: 2,
                              style: BorderStyle.solid)),
                      labelText: "ID #",
                      fillColor: Colors.blue,
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      )),
                  controller: idNumController,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                    style: BorderStyle.solid)),
                            labelText: "First Name",
                            fillColor: Colors.blue,
                            labelStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            )),
                        controller: firstNameController,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                              focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              labelText: "Second Name",
                              fillColor: Colors.blue,
                              labelStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              )),
                          controller: secondNameController,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                dense: true,
                title: Text('Gender',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                subtitle: Container(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonFormField(
                      isExpanded: true,
                      items: _genderList.map(
                        (value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGenderValue = value.toString();
                          //_postItem.position = _selectedPositionValue;
                        });
                      }),
                ),
              ),
              SizedBox(height: 15.0),
              ListTile(
                dense: true,
                title: Text('Nationality',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                subtitle: Container(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonFormField(
                      isExpanded: true,
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
                          _selectedNationalityValue = value.toString();
                          //_postItem.level = _selectedLevelValue;
                        });
                      }),
                ),
              ),
              SizedBox(height: 15.0),
              ListTile(
                dense: true,
                title: Text('Current Position',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                subtitle: Container(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonFormField(
                      isExpanded: true,
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
                          _selectedCurrentPositionValue = value.toString();
                          //_postItem.dutystation = _selectedDutyStationValue;
                        });
                      }),
                ),
              ),
              SizedBox(height: 15.0),
              ListTile(
                dense: true,
                title: Text('Current level',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                subtitle: Container(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonFormField(
                      isExpanded: true,
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
                          _selectedCurrentLevelValue = value.toString();
                          //_postItem.division = _selectedDivisionValue;
                        });
                      }),
                ),
              ),
              
              SizedBox(height: 15.0),
              ListTile(
                dense: true,
                title: Text('Current Duty Station',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                subtitle: Container(
                  alignment: Alignment.centerLeft,
                  child: DropdownButtonFormField(
                      isExpanded: true,
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
                          _selectedCurrentDutyStationValue = value.toString();
                          //_postItem.division = _selectedDivisionValue;
                        });
                      }),
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
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
              BasicInfo,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addApplication(
    String idnum,
    String firstName,
    String secondName,
    String gender,
    String nationallity,
    String currentPosition,
    String currentLevel,
    String currentDutyStation,
    String uid,
  ) {
    return applicationdb
        .add({
          'id #': idnum,
          'First Name': firstName,
          'Second Name': secondName,
          'Gender': gender,
          'Nationallity': nationallity,
          'Current Position': currentPosition,
          'Current Level': currentLevel,
          'Current Duty Station': currentDutyStation,
          'uid': uid,
        })
        .then((value) => print("Application Added"))
        .catchError((error) => print("Failed to add Post: $error"));
  }
}
