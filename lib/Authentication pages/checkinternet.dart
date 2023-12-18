// late StreamSubscription subscription;
// bool isDeviceConnected = false;
// bool isAlertSet = false;
// @override
// void initState() {
//   getConnectivity();
//   countrycode.text = "+91";
//   super.initState();
// }
//
// getConnectivity() async {
//   isDeviceConnected = await InternetConnectionChecker().hasConnection;
//   if (!isDeviceConnected && isAlertSet == false) {
//     showDialogBox();
//     setState(() => isAlertSet = true);
//   }
//   subscription = Connectivity().onConnectivityChanged.listen(
//         (ConnectivityResult result) async {
//       isDeviceConnected = await InternetConnectionChecker().hasConnection;
//       if (!isDeviceConnected && isAlertSet == false) {
//         showDialogBox();
//         setState(() => isAlertSet = true);
//       }
//     },
//   );
// }
//
// @override
// void dispose() {
//   subscription.cancel();
//   super.dispose();
// }

// showDialogBox() => showCupertinoDialog<String>(
//   context: context,
//   builder: (BuildContext context) => CupertinoAlertDialog(
//     title: const Text('No Connection'),
//     content: const Text('Please check your internet connectivity'),
//     actions: <Widget>[
//       TextButton(
//         onPressed: () async {
//           Navigator.pop(context, 'Cancel');
//           setState(() => isAlertSet = false);
//           isDeviceConnected =
//           await InternetConnectionChecker().hasConnection;
//           if (!isDeviceConnected && isAlertSet == false) {
//             showDialogBox();
//             setState(() => isAlertSet = true);
//           }
//         },
//         child: const Text('OK'),
//       ),
//     ],
//   ),
// );

//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:projectint/Pages/Home/video_controller.dart';
//
// class explore extends StatefulWidget {
//   const explore({super.key});
//
//   @override
//   State<explore> createState() => _exploreState();
// }
//
// class _exploreState extends State<explore> {
//   final Videocontroller videocontroller = Get.put(Videocontroller());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             floating: true,
//             toolbarHeight: 50,
//             iconTheme: IconThemeData(color: Colors.green),
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leadingWidth: 80,
//             leading: Image.asset(
//               'assets/WW iconimg.jpg',
//               height: 30,
//             ),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     Fluttertoast.showToast(
//                         msg: videocontroller.videoList.length.toString());
//                   },
//                   icon: Icon(Icons.search))
//             ],
//           ),
//           Obx(() {
//             return SliverList(
//                 delegate: SliverChildBuilderDelegate((context, index) {
//                   return Column(
//                     children: [
//                       Text(videocontroller.videoList.length.toString()),
//                       Container(
//                         height: 220,
//                         color: Colors.green,
//                         width: double.infinity,
//                       )
//                       // Image.network(
//                       //   color: Colors.green,
//                       //   videocontroller.videoList[index].thumbnail,
//                       //   height: 220,
//                       //   width: double.infinity,
//                       //   fit: BoxFit.cover,
//                       // )
//                     ],
//                   );
//                 }, childCount: 10));
//           })
//         ],
//       ),
//     );
//   }
// }
