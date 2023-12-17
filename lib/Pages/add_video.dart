import 'package:flutter/material.dart';

class add_video extends StatefulWidget {
  const add_video({super.key});

  @override
  State<add_video> createState() => _add_videoState();
}

class _add_videoState extends State<add_video> {
  showDialogsel(BuildContext) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {},
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
                  onPressed: () {},
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
                      children: [Text("Close")],
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
