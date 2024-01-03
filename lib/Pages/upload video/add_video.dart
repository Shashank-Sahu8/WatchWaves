import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectint/Pages/upload%20video/caption,details,etc.dart';

class add_video extends StatefulWidget {
  const add_video({super.key});

  @override
  State<add_video> createState() => _add_videoState();
}

String uid = FirebaseAuth.instance.currentUser!.uid;

class _add_videoState extends State<add_video> {
  videoselect(ImageSource src) async {
    final XFile? video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Fluttertoast.showToast(
          msg: "Video Selectes ${video.path}", backgroundColor: Colors.grey);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => upload_video(
                  videofile: File(video.path), videopath: video.path)));
    } else {
      Fluttertoast.showToast(msg: "Erroe in Selection");
    }
  }

  showDialogsel(BuildContext) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    videoselect(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.drive_folder_upload,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Select from Gallery"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    videoselect(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Open Camera"),
                    ],
                  ),
                ),
                SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Close",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showDialogsel(context);
          },
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/addvid-removebg-preview.png'))),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.touch_app,
                    color: Colors.green,
                    size: 35,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "click here to Add Video",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
