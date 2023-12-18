import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:projectint/Pages/upload%20video/upload_video.dart';
import 'package:video_player/video_player.dart';

class upload_video extends StatefulWidget {
  File videofile;
  String videopath;
  upload_video({super.key, required this.videofile, required this.videopath});

  @override
  State<upload_video> createState() => _upload_videoState();
}

class _upload_videoState extends State<upload_video> {
  bool loading = false;
  late VideoPlayerController videoPlayerController;
  TextEditingController titlec = TextEditingController();
  TextEditingController decc = TextEditingController();
  Videoupload videoupload = Get.put(Videoupload());
  String currentaddress = "No location";
  late Position currentposition;
  Future<String> _determinePosition() async {
    bool serviceenabled;
    LocationPermission permission;

    serviceenabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceenabled) {
      Fluttertoast.showToast(msg: "Please keep your location on");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        Fluttertoast.showToast(msg: "Location permission is denied");
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Permission is denied forever");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      setState(() {
        currentposition = position;
        currentaddress = "${place.locality},${place.country}";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return currentaddress.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    _determinePosition();
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              videoPlayerController.dispose();
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: Colors.blueGrey),
          title: Image.asset(
            'assets/WW iconimg.jpg',
            height: 50,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _determinePosition();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Your current Location"),
                        content: Container(
                          height: 85,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Latitude- " +
                                  "${currentposition.latitude.toString()}"),
                              Text(
                                  "Longitude- ${currentposition.longitude.toString()}"),
                              Text("Address- ${currentaddress.toString()}")
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _determinePosition();
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: currentaddress.toString());
                            },
                            child: Text("Relocate"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          ),
                        ],
                      );
                    },
                  );
                },
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
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          videoupload.uploadvid(
                              titlec.text.toString(),
                              decc.text.toString(),
                              currentaddress.toString(),
                              "entertain",
                              widget.videopath);
                          videoPlayerController.pause();
                          //loading = false;
                        },
                        child: loading == true
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircularProgressIndicator(
                                  color: Colors.blueGrey,
                                ),
                              )
                            : Text("Upload"),
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
