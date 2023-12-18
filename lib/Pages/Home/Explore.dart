import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:projectint/Pages/Home/video_controller.dart';

class explore extends StatefulWidget {
  const explore({super.key});

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        leading: Image.asset('assets/WW iconimg.jpg'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('videos').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              docs[index]['thumbnail'],
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 8.0,
                              right: 8.0,
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Text(
                                  "20:00",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(children: [
                          CircleAvatar(),
                          Column(
                            children: [
                              Flexible(child: Text(docs[index]['cat'])),
                              Flexible(
                                child: Text(
                                    "${docs[index]['username']} . ${docs[index]['like']} likes . 3 days ago"),
                              ),
                            ],
                          )
                        ])
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

//
//
// StreamBuilder(
// stream:
// FirebaseFirestore.instance.collection('videos').snapshots(),
// builder: (context, snapshots) {
// if (snapshots.connectionState == ConnectionState.waiting) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// } else {
// final docs = snapshots.data!.docs;
// return ListView.builder(
// itemCount: docs.length,
// itemBuilder: (context, index) {
// return Container(
// height: 220,
// decoration: BoxDecoration(
// image: DecorationImage(
// image:
// NetworkImage(docs[index]['thumbnail']))),
// );
// });
// }
// })
