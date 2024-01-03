import 'package:cloud_firestore/cloud_firestore.dart';

class myuser {
  String name;
  String profilepic;
  String uid;
  myuser({required this.name, required this.profilepic, required this.uid});
  //a to f
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilepic": profilepic,
      "uid": uid,
    };
  }

//f to a
  static myuser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myuser(
        name: snapshot['name'],
        profilepic: snapshot['profilepic'],
        uid: snapshot['uid']);
  }
}
