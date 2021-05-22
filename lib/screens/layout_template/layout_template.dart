import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_relocation/locator.dart';
import 'package:hr_relocation/models/posts_repository.dart';
import 'package:hr_relocation/routing/route_names.dart';
import 'package:hr_relocation/routing/router.dart';
import 'package:hr_relocation/services/navigation_service.dart';
import 'package:hr_relocation/widgets/centered_view.dart';
import 'package:hr_relocation/widgets/navigation_bar/navigation_bar.dart';
import 'package:hr_relocation/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  LayoutTemplate({Key? key}) : super(key: key);


  Query query = FirebaseFirestore.instance.collection('posts');

  refreshPosts() async {
    /// delete all docs
    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((qs) => qs.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(element.id)
                  .delete();
            }));

    posts.forEach((element) {
      FirebaseFirestore.instance.collection('posts').add({
        'title': element.title,
        'level': element.level,
        'post': element.post,
        'division': element.division,
        'branch': element.branch,
        'dutystation': element.dutystation,
        'description': element.description,
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: [
              NavigationBar(),
              Expanded(
                  child: Navigator(
                    key: locator<NavigationService>().navigatorKey,
                    onGenerateRoute: generateRoute,
                    initialRoute: HomeRoute,
                    )
                  ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => refreshPosts(),
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
