import 'package:flutter/material.dart';
import 'package:projectint/Pages/User_details.dart';
import 'Home/Explore.dart';
import 'User Account.dart';
import 'upload video/add_video.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

const pageindex = [explore(), add_video(), user_details()];

class _homeState extends State<home> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff00A36e),
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
