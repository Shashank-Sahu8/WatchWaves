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
