import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectint/model/videomodel.dart';

class Videocontroller extends GetxController {
  final Rx<List<videoo>> _videoList = Rx<List<videoo>>([]);
  List<videoo> get videoList => _videoList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .snapshots()
        .map((QuerySnapshot query) {
      List<videoo> retval = [];
      for (var element in query.docs) {
        retval.add(videoo.fromSnap(element));
      }
      return retval;
    }));
  }
}
