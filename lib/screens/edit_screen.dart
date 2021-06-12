import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/models/post.dart';

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

//CollectionReference postdb = FirebaseFirestore.instance.collection('posts');

class _EditScreenState extends State<EditScreen> {
  late User _user;
  late PostItem _postItem;

  var _selectedPositionValue;
  var _selectedLevelValue;
  var _selectedDutyStationValue;
  var _selectedDivisionValue;

  @override
  void initState() {
    _user = widget._user;
    _postItem = widget._postItem;

    _selectedPositionValue = _postItem.position;
    _selectedLevelValue = _postItem.level;
    _selectedDutyStationValue = _postItem.dutystation;
    _selectedDivisionValue = _postItem.division;
    super.initState();
  }

  late String id;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: _postItem.title);
    TextEditingController descriptionController =
        TextEditingController(text: _postItem.description);

    final dropdownState = GlobalKey<FormFieldState>();

    final _jobList = [
      'Economic Affairs Officer',
      'Data Analyst',
      'Humanitarian Affairs Officer',
      'Rule of Law Officer',
      'Doctor',
      'Finance Officer',
      'Criminal Justice Officer',
      'Human Resources Officer',
      'Programme Officer'
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

    AppBar appBarSection() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextFormField(
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
          },
        ),
        
      );
    }

    Widget PositionInfo = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (MediaQuery.of(context).devicePixelRatio * MediaQuery.of(context).size.width > 1200.0)
            Container(
              child: Hero(
                tag: 'img-${widget._postItem.position}-${widget._postItem.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    'assets/jobs/officer/${widget._postItem.position}.jpg',
                    height: 250,
                    fit: BoxFit.cover,
                  ),
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
                          hint: Text(_postItem.position),
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
                              _selectedPositionValue = value.toString();
                              dropdownState.currentState!
                                  .didChange(_selectedPositionValue);
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
                          hint: Text(_postItem.level),
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
                              _selectedLevelValue = value.toString();
                              dropdownState.currentState!
                                  .didChange(_selectedLevelValue);
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  ListTile(
                    dense: true,
                    title: Text('Duty Station',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField(
                          hint: Text(_postItem.dutystation),
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
                              _selectedDutyStationValue = value.toString();
                              dropdownState.currentState!
                                  .didChange(_selectedDutyStationValue);
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
                          hint: Text(_postItem.division),
                          isExpanded: true,
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
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 15.0),
                   ElevatedButton(
            child: Text('Save'),
            onPressed: () {
              updatePost(
                _postItem.id,
                _selectedPositionValue,
                _selectedLevelValue,
                _selectedDutyStationValue,
                _selectedDivisionValue,
                descriptionController.text,
              );
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Widget description = Container(
      //height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.all(20.0),
      child: Container(
        child: TextFormField(
          maxLines: 5,
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
              description,
            ],
          ),
        ),
      ),
    );
  }



  Future<void> updatePost(
    String id,
    String position,
    String level,
    String dutystation,
    String division,
    String description,
  ) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"title": position});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"position": position});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"level": level});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"dutystation": dutystation});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"division": division});
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"description": description});
  }
}