import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:projectint/Pages/Home/play_video.dart';
import 'package:projectint/Pages/upload%20video/add_video.dart';
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
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.6,
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        leading: Image.asset('assets/WW iconimg.jpg'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('videos').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              height: 220,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => videoplayer(
                                                path: "docs[index]['videourl']",
                                              )));
                                },
                                child: Stack(
                                  children: [
                                    Image.network(
                                      docs[index]['thumbnail'].toString(),
                                      loadingBuilder: (BuildContext,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: RefreshProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
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
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Text(
                                          "20:00",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: 7.0,
                                  bottom: 20.0),
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: FirebaseFirestore.instance
                                            .collection('User')
                                            .doc(docs[index]['uid'])
                                            .toString());
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        FirebaseFirestore.instance
                                            .collection('User')
                                            .doc(docs[index]['uid'])
                                            .collection('profile_pic')
                                            .toString()),
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        docs[index]['cation'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )),
                                      Flexible(
                                        child: Text(
                                          "${docs[index]['username']} . ${docs[index]['like']} likes . 3 days ago",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.blueGrey.shade700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {}, child: Icon(Icons.more_vert))
                              ]),
                            )
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.green,
                ));
              }
            }),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
