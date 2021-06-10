// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hr_relocation/models/post.dart';
// import 'package:hr_relocation/screens/apply_screen.dart';
// import 'edit_screen.dart';

// class ApplyStateScreen extends StatefulWidget {
//   const ApplyStateScreen(
//       {Key? key, required User user, required PostItem postItem})
//       : _user = user,
//         _postItem = postItem,
//         super(key: key);

//   final User _user;
//   final PostItem _postItem;

//   @override
//   _ApplyStateScreenState createState() => _ApplyStateScreenState();
// }

// class _ApplyStateScreenState extends State<ApplyStateScreen> {
//   //bool thumup = false;
//   late User _user;
//   late PostItem _postItem;

//   @override
//   void initState() {
//     _user = widget._user;
//     _postItem = widget._postItem;

//     super.initState();
//   }

//   late String id;

//   @override
//   Widget build(BuildContext context) {
//     //int thumbs = 31;

//     AppBar appBarSection() {
//       return AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: Center(
//               child: Text('Apply Status',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black))),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.filter_list,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 //TODO:filtering
//               },
//             ),
//           ]);
//     }

//     Widget applicantList = ListView(children: [
//       Expanded(
//         child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           PaginatedDataTable(
//             header: Text('Header Text'),
//             rowsPerPage: 4,
//             columns: [
//               DataColumn(label: Text('Header A')),
//               DataColumn(label: Text('Header B')),
//               DataColumn(label: Text('Header C')),
//               DataColumn(label: Text('Header D')),
//             ],
//             source: _DataSource(context),
//           ),
//         ],
//       ),
//       ),
//     ]
//     );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: appBarSection(),
//       body: Container(
//         child: Column(children: [
//           Expanded(child: applicantList),
//         ]),
//       ),
//     );
//   }

// }

// class _Row {
//   _Row(
//     this.valueA,
//     this.valueB,
//     this.valueC,
//     this.valueD,
//   );

//   final String valueA;
//   final String valueB;
//   final String valueC;
//   final int valueD;

//   bool selected = false;
// }

// class _DataSource extends DataTableSource {
//   _DataSource(this.context) {
//     _rows = <_Row>[
//       _Row('Cell A1', 'CellB1', 'CellC1', 1),
//       _Row('Cell A2', 'CellB2', 'CellC2', 2),
//       _Row('Cell A3', 'CellB3', 'CellC3', 3),
//       _Row('Cell A4', 'CellB4', 'CellC4', 4),
//     ];
//   }

//   final BuildContext context;
//   List<_Row> _rows;

//   int _selectedCount = 0;

//   @override
//   DataRow? getRow(int index) {
//     assert(index >= 0);
//     if (index >= _rows.length) return null;
//     final row = _rows[index];
//     return DataRow.byIndex(
//       index: index,
//       selected: row.selected,
//       onSelectChanged: (value) {
//         if (row.selected != value) {
//           _selectedCount += value ? 1 : -1;
//           assert(_selectedCount >= 0);
//           row.selected = value!;
//           notifyListeners();
//         }
//       },
//       cells: [
//         DataCell(Text(row.valueA)),
//         DataCell(Text(row.valueB)),
//         DataCell(Text(row.valueC)),
//         DataCell(Text(row.valueD.toString())),
//       ],
//     );
//   }

//   @override
//   int get rowCount => _rows.length;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => _selectedCount;
// }

// class Containor {}

// Future<void> deletePost(DocumentSnapshot doc) async {
//   await FirebaseFirestore.instance.collection("posts").doc(doc.id).delete();
// }









// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hr_relocation/models/post.dart';

// class Applicant {
//   final String name;
//   final String phoneNum;
//   final String gender;
//   final String nationallity;
//   final String currentPosition;
//   final String currentLevel;
//   final String currentDutyStation;
//   final String uid;

//   final DocumentSnapshot documentSnapshot;

//   bool selected = false;

//   Applicant({
//     required this.name,
//     required this.phoneNum,
//     required this.gender,
//     required this.nationallity,
//     required this.currentPosition,
//     required this.currentLevel,
//     required this.currentDutyStation,
//     required this.uid,
//     required this.documentSnapshot,
//   });
// }

// class ApplyStateScreen extends StatefulWidget {
//   const ApplyStateScreen(
//       {Key? key,
//       required User user,
//       required PostItem postItem,
//       required Applicant applicant})
//       : _user = user,
//         _postItem = postItem,
//         _applicant = applicant,
//         super(key: key);

//   final User _user;
//   final PostItem _postItem;
//   final Applicant _applicant;

//   @override
//   _ApplyStateScreenState createState() => _ApplyStateScreenState();
// }

// class _ApplyStateScreenState extends State<ApplyStateScreen> {
//   //bool thumup = false;
//   late User _user;
//   late PostItem _postItem;
//   late Applicant _applicant;

//   @override
//   void initState() {
//     _user = widget._user;
//     _postItem = widget._postItem;

//     super.initState();
//   }

//   late String id;

//   int _defalutRowPageCount = PaginatedDataTable.defaultRowsPerPage;
//   late int _sortColumnIndex = 0;
//   bool _sortAscending = true;
//   MyTable table = MyTable();

//   void _sort(Comparable getField(Applicant s), int index, bool b) {
//     table._sort(getField, b);
//     setState(() {
//       this._sortColumnIndex = index;
//       this._sortAscending = b;
//     });
//   }

//   List<DataColumn> getColumn() {
//     return [
//       DataColumn(
//           label: Text('Name'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.name, i, b);
//           }),
//       DataColumn(
//           label: Text('Phone Number'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.phoneNum, i, b);
//           }), //
//       DataColumn(
//           label: Text('Gender'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.gender, i, b);
//           }), //
//       DataColumn(
//           label: Text('Nationallity'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.nationallity, i, b);
//           }), //
//       DataColumn(
//           label: Text('Current Position'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.currentPosition, i, b);
//           }),
//       DataColumn(
//           label: Text('Current Level'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.currentLevel, i, b);
//           }),
//       DataColumn(
//           label: Text('Current Duty Station'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.currentDutyStation, i, b);
//           }),
//       DataColumn(
//           label: Text('uid'),
//           onSort: (i, b) {
//             _sort((Applicant p) => p.uid, i, b);
//           }),
//     ];
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarSection(),
//       body: _buildStream(context),
//       //getPaginatedDataTable(),
//     );
//   }

//   AppBar appBarSection() {
//     return AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Center(
//             child: Text('Apply Status',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.black))),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.filter_list,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               //TODO:filtering
//             },
//           ),
//         ]);
//   }

//   Widget _buildStream(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("posts")
//             .orderBy('level')
//             .snapshots(),
//         builder: (context, snapshot) {
//           return !snapshot.hasData
//               ? Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: PaginatedDataTable(
//                     rowsPerPage: _defalutRowPageCount,
//                     onRowsPerPageChanged: (value) {
//                       setState(() {
//                         _defalutRowPageCount = value!;
//                       });
//                     },
//                     sortColumnIndex: _sortColumnIndex,
//                     initialFirstRowIndex: 0,
//                     sortAscending: _sortAscending,
//                     availableRowsPerPage: [5, 10],
//                     onPageChanged: (value) {
//                       //print('$value');
//                     },
//                     //onSelectAll: table.selectAll(),
//                     header: Text('Applicant List'),
//                     columns: getColumn(),
//                     source: table,
//                   ),
//                 );
//         });
//   }
// }

// class MyTable extends DataTableSource {
//   // List _applicants = [
//   //   Applicant('SeinKim', '010-1234-5678', 'Female', 'Korean', 'Designer', '3',
//   //       'Seoul', 'uid'),
//   //   Applicant('Gyuchan', '010-1234-5678', 'Male', 'Korean', 'Developer', '3',
//   //       'Seoul', 'uid'),
//   //   Applicant('Hyesung', '010-1234-5678', 'Female', 'Korean', 'Marketer', '3',
//   //       'Seoul', 'uid'),
//   //   Applicant('Junyoung', '010-1234-5678', 'Male', 'Korean', 'Finance Manager',
//   //       '3', 'Seoul', 'uid'),
//   // ];
// DocumentSnapshot data = snapshot.data!.docs[index];
                  
//   Applicant _applicants = [
//     uid:
//   ];
//   int _selectCount = 0;
//   bool _isRowCountApproximate = false;

//   @override
//   DataRow getRow(int index) {
//     if (index >= _applicants.length || index < 0)
//       throw FlutterError('Data Error!');

//     final Applicant applicant = _applicants[index];
//     return DataRow.byIndex(
//         cells: [
//           DataCell(Text(applicant.name)),
//           DataCell(Text(applicant.phoneNum)),
//           DataCell(Text(applicant.gender)),
//           DataCell(Text(applicant.nationallity)),
//           DataCell(Text(applicant.currentPosition)),
//           DataCell(Text(applicant.currentLevel)),
//           DataCell(Text(applicant.currentDutyStation)),
//           DataCell(Text(applicant.uid)),
//         ],
//         selected: applicant.selected,
//         index: index,
//         onSelectChanged: (isSelected) {
//           selectOne(index, isSelected!);
//         });
//   }

//   @override
//   bool get isRowCountApproximate => _isRowCountApproximate;

//   @override
//   int get rowCount => _applicants.length;

//   @override
//   int get selectedRowCount => _selectCount;

//   void selectOne(int index, bool isSelected) {
//     Applicant applicant = _applicants[index];
//     if (applicant.selected != isSelected) {
//       _selectCount = _selectCount += isSelected ? 1 : -1;
//       applicant.selected = isSelected;

//       notifyListeners();
//     }
//   }

//   void selectAll(bool checked) {
//     for (Applicant _applicant in _applicants) {
//       _applicant.selected = checked;
//     }
//     _selectCount = checked ? _applicants.length : 0;
//     notifyListeners();
//   }

//   void _sort(Comparable getField(Applicant applicant), bool b) {
//     _applicants.sort((s1, s2) {
//       if (!b) {
//         final Applicant temp = s1;
//         s1 = s2;
//         s2 = temp;
//       }
//       final Comparable s1Value = getField(s1);
//       final Comparable s2Value = getField(s2);
//       return Comparable.compare(s1Value, s2Value);
//     });
//     notifyListeners();
//   }
// }
