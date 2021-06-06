import 'post.dart';

// List<Post> posts = [
//   Post(id: 00, title: 'Position1',level: 1, post: 'XX', division: 'A',branch: 'A', dutystation: 'City A', description: 'Developer'),
//   Post(id: 01, title: 'Position2', level: 1, post: 'XX', division: 'A',branch: 'A', dutystation: 'City A', description: 'Maketer'),
//   Post(id: 02, title: 'Position3', level: 1, post: 'XX', division: 'A',branch: 'A', dutystation: 'City A', description: 'Financial Planner'),
//   Post(id: 03, title: 'Position4', level: 1, post: 'XX', division: 'A',branch: 'A', dutystation: 'City A', description: 'Designer'),
//   Post(id: 04, title: 'Position5', level: 1, post: 'XX', division: 'A',branch: 'A', dutystation: 'City A', description: 'Designer'),
//   Post(id: 05, title: 'Position6', level: 1, post: 'XX', division: 'A',branch: 'A', dutystation: 'City A', description: 'Guardian'),
// ];
// Widget _buildGrid(BuildContext context) {
//   return GridView.count(
//     crossAxisCount: 2,
//     padding: EdgeInsets.all(16.0),
//     childAspectRatio: 6.5 / 7.0,
//     children: posts.map((posts) {
//       return Card(
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Transform.scale(
//                       scale: 1,
//                       child: AspectRatio(
//                         aspectRatio: 16 / 9,
//                         child: Hero(
//                           tag: 'job-img-${(posts.id)}',
//                           child: Image.asset(
//                             'assets/jobs/job${(posts.id)}.png',
//                             //width:300,
//                             height: 200,
//                             fit: BoxFit.fitHeight,
//                             //alignment: Alignment(0,-pageOffset.abs()+posts.id),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             posts.title,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                             overflow: TextOverflow.fade,
//                             maxLines: 1,
//                             softWrap: false,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8.0),
//                     _buildCardRow(context, 'Level', posts.level.toString()),
//                     SizedBox(height: 4.0),
//                     _buildCardRow(context, 'Post', posts.post.toString()),
//                     SizedBox(height: 4.0),
//                     _buildCardRow(
//                         context, 'Division', posts.division.toString()),
//                     SizedBox(height: 4.0),
//                     _buildCardRow(context, 'Branch', posts.branch.toString()),
//                     SizedBox(height: 4.0),
//                     _buildCardRow(
//                         context, 'Dutystation', posts.dutystation.toString()),
//                     SizedBox(height: 8.0),
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                         alignment: Alignment.bottomRight,
//                         child: InkWell(
//                             child: Text(
//                               'more',
//                               style: TextStyle(
//                                   color: Theme.of(context).accentColor,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             onTap: () {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (_) {
//                               //       return DetailPage(product);
//                               //     },
//                               //   ),
//                               // );
//                               Navigator.pushNamed(context, '/detail');
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList(),
//   );
// }
//
// Row _buildCardRow(BuildContext context, String label, String value) {
//   return Row(
//     children: [
//       Text(
//         label,
//         style: Theme.of(context).textTheme.caption,
//       ),
//       Expanded(
//         child: Text(
//           value,
//           style: Theme.of(context).textTheme.caption,
//           textAlign: TextAlign.right,
//         ),
//       ),
//     ],
//   );
// }
