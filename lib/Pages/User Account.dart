import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectint/Pages/Home/Explore.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("sign out"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("nav"),
            ),
          ],
        ),
      ),
    );
  }
}
