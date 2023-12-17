import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class upload_video extends StatefulWidget {
  File videofile;
  String videopath;
  upload_video({super.key, required this.videofile, required this.videopath});

  @override
  State<upload_video> createState() => _upload_videoState();
}

class _upload_videoState extends State<upload_video> {
  late VideoPlayerController videoPlayerController;
  TextEditingController titlec = TextEditingController();
  TextEditingController decc = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videofile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.blueGrey),
          title: Image.asset(
            'assets/WW iconimg.jpg',
            height: 50,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.location_on,
                  size: 35,
                  color: Colors.green,
                ))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 420,
                  width: 300,
                  child: VideoPlayer(videoPlayerController),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.blueGrey,
                        controller: titlec,
                        decoration: InputDecoration(
                            hintText: "Caption",
                            border: OutlineInputBorder(),
                            icon: Icon(
                              Icons.closed_caption_off_outlined,
                              color: Colors.green,
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        maxLines: 3,
                        cursorHeight: 20,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.blueGrey,
                        controller: decc,
                        decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Upload"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
