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
//   final String id;
//   final String uid;
//   bool selected = false;
//   Applicant(
//     this.name,
//     this.phoneNum,
//     this.gender,
//     this.nationallity,
//     this.currentPosition,
//     this.currentLevel,
//     this.currentDutyStation,
//     this.id,
//     this.uid,
//   );
// }

// class DataTableWidget extends StatefulWidget {
//   final String dbName;
//   final String sqlScript;
//   final Map<String, Applicant> columns;
//   DataTableWidget(
//       {required this.dbName,
//       required this.sqlScript,
//       required this.columns});

//   @override
//   _DataTableWidgetState createState() => _DataTableWidgetState();
// }

// class _DataTableWidgetState extends State<DataTableWidget> {
//   bool _sortAscending = true;
//   int _sortColumnIndex = 0;
//   late List<Map<String, dynamic>> _snapshot;

//   List<Map<String, dynamic>> _getsnapshot() {
//     return _snapshot;
//   }

//   _setsnapshot(AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//     _snapshot = List<Map<String, dynamic>>.from(snapshot.data!);
//   }

//   _sort() {
//     String columnName = _getsnapshot().first.keys.elementAt(_sortColumnIndex);
//     if (_sortAscending)
//       _getsnapshot().sort((a, b) => (b[columnName]).compareTo(a[columnName]));
//     else
//       _getsnapshot().sort((a, b) => (a[columnName]).compareTo(b[columnName]));
//   }

//   Applicant? getApplicant(String columnName) {
//     return widget.columns.containsKey(columnName)
//         ? widget.columns[columnName]
//         : Applicant(
//             name: name,
//             label: columnName,
//             tooltip: columnName,
//             numeric: false,
//             editable: false,
//             editableTextInputType: TextInputType.name);
//   }

//   List<DataColumn> _getDataColumn() {
//     List<DataColumn> listDataColumn = <DataColumn>[];

//     for (var i = 0; i < _getsnapshot()[0].keys.length; i++) {
//       String columnName = _getsnapshot()[0].keys.elementAt(i).toString();

//       Applicant column = getApplicant(columnName)!;

//       if (false == column.show) continue;

//       listDataColumn.add(DataColumn(
//           onSort: (columnIndex, ascending) {
//             setState(() {
//               _sortColumnIndex = columnIndex;
//               _sortAscending = ascending;
//             });
//           },
//           tooltip: column.tooltip,
//           label: Text(column.label, textAlign: TextAlign.center)));
//     }
//     return listDataColumn;
//   }

//   List<DataRow> _getDataRow() {
//     List<DataRow> listDataRow = <DataRow>[];

//     for (var rowIdx = 0; rowIdx < _getsnapshot().length; rowIdx++) {
//       List<DataCell> ldc = <DataCell>[];
//       for (var ceilIdx = 0;
//           ceilIdx < _getsnapshot()[0].keys.length;
//           ceilIdx++) {
//         String columnName =
//             _getsnapshot().first.keys.elementAt(ceilIdx).toString();

//         Applicant column = getApplicant(columnName)!;
//         if (false == column.show) continue;

//         String ceilText = _getsnapshot()[rowIdx][columnName].toString();

//         ldc.add(column.editable
//             ? DataCell(
//                 TextFormField(
//                   controller: TextEditingController(text: ceilText),
//                   //initialValue: ceilText,
//                   keyboardType: column.editableTextInputType,
//                   onFieldSubmitted: (val) {
//                     print('onSubmited $val');
//                   },
//                 ),
//                 showEditIcon: true,
//               )
//             : DataCell(Text(ceilText)));
//       }

//       listDataRow.add(DataRow(
//         // color: MaterialStateColor.resolveWith((states) {
//         //   return rowIdx % 2 == 0 ? Colors.red : Colors.black; //make tha magic!
//         // }),
//         // color: MaterialStateProperty.resolveWith<Color>(
//         //     (Set<MaterialState> states) {
//         //   if (states.contains(MaterialState.selected))
//         //     return Theme.of(context).colorScheme.primary.withOpacity(0.58);
//         //   return null; // Use the default value.
//         // }),
//         // selected: true,
//         // onSelectChanged: (value) {
//         //   setState(() {});
//         // },
//         cells: ldc,
//       ));
//     }
//     return listDataRow;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Container(
//       width: width,
//       height: height,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: FutureBuilder<List<Map<String, dynamic>>>(
//             future: SqliteUtils(widget.dbName).executeReader(widget.sqlScript),
//             builder: (BuildContext c,
//                 AsyncSnapshot<List<Map<String, dynamic>>> aspsh) {
//               debugPrint("build");

//               if (!aspsh.hasData)
//                 return (Center(child: CircularProgressIndicator()));

//               _setsnapshot(aspsh);
//               //sleep(Duration(seconds: 5));
//               _sort();

//               return DataTable(
//                 //headingRowColor:
//                 //    MaterialStateColor.resolveWith((states) => Colors.blue),
//                 sortAscending: _sortAscending,
//                 sortColumnIndex: _sortColumnIndex,
//                 showCheckboxColumn: false,
//                 columns: _getDataColumn(),
//                 rows: _getDataRow(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
