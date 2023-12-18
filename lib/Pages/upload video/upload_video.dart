import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:projectint/model/videomodel.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class Videoupload extends GetxController {
  var uuid = Uuid();
  static Videoupload instance = Get.find();
  //5 select thumbnail
  Future<File> _getthumb(String videopath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videopath);
    return thumbnail;
  }

//4 upload thumbnail to storage
  Future<String> _uploadvideothumbtostorage(String id, String videopath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask uploadTask = reference.putFile(await _getthumb(videopath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

//1  main videoupload method
  uploadvid(String caption, String des, String loc, String cat,
      String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();
      //_uploadvidtostorage(uuid.v1(), videoPath);
      String thumbnail = await _uploadvideothumbtostorage(uuid.v1(), videoPath);

      videoo video = videoo(
          username: "Shashank",
          uid: uid,
          id: uuid.v1(),
          like: [],
          commentsCount: 0,
          description: des,
          cat: cat,
          caption: caption,
          location: loc,
          profilepic: "no pic",
          thumbnail: thumbnail,
          videourl: await _uploadvidtostorage(uuid.v1(), videoPath));

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(uuid.v1())
          .set(video.toJson());
      Fluttertoast.showToast(
          msg: "Uploaded successfully", backgroundColor: Colors.grey);
      Get.back();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.grey);
    }
  }

//2 video to storage method
  Future<String> _uploadvidtostorage(String videoid, String videopath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("videos").child(videoid);
    UploadTask uploadTask =
        reference.putFile(await _compressvideo(videopath.toString()));
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

//3 compress video
  _compressvideo(String videopath) async {
    final compressedvideo = await VideoCompress.compressVideo(videopath,
        quality: VideoQuality.MediumQuality);
    return compressedvideo!.file;
  }
}
