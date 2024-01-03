import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectint/Pages/upload%20video/caption,details,etc.dart';

class user_details extends StatefulWidget {
  const user_details({super.key});

  @override
  State<user_details> createState() => _user_detailsState();
}

class _user_detailsState extends State<user_details> {
  imageselect(ImageSource src) async {
    final imagee = await ImagePicker().pickImage(source: src);
    if (imagee != null) {
      String k = _uplodepropic(imagee.path);
      Fluttertoast.showToast(
          msg: "uploaded successfully", backgroundColor: Colors.grey);
    } else {
      Fluttertoast.showToast(msg: "Erroe in Selection");
    }
  }

  _uplodepropic(String imagepath) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilepic')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(File(imagepath.toString()));
    TaskSnapshot snapshot = await uploadTask;
    String imagedurl = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'profile_pic': imagedurl, 'name': "shashank"});
    return imagedurl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  imageselect(ImageSource.gallery);
                },
                child: CircleAvatar(backgroundColor: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
