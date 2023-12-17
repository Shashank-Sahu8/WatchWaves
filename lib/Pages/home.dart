import 'package:flutter/material.dart';

import 'add_video.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

const pageindex = [Text("Home"), add_video(), Text("Profile")];

class _homeState extends State<home> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Upload"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "User"),
        ],
      ),
      body: Center(
        child: pageindex[page],
      ),
    );
  }
}
