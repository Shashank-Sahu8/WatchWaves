import 'package:cloud_firestore/cloud_firestore.dart';

class videoo {
  String username;
  String uid;
  String id;
  List like;
  int commentsCount;
  String caption;
  String description;
  String location;
  String cat;
  String videourl;
  String thumbnail;
  String profilepic;
  videoo(
      {required this.username,
      required this.uid,
      required this.id,
      required this.like,
      required this.commentsCount,
      required this.description,
      required this.cat,
      required this.caption,
      required this.location,
      required this.profilepic,
      required this.thumbnail,
      required this.videourl});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "like": like,
        "commentsCount": commentsCount,
        "cation": caption,
        "description": description,
        "location": location,
        "cat": cat,
        "profilepic": profilepic,
        "thumbnail": thumbnail,
        "videourl": videourl
      };

  static videoo fromSnap(DocumentSnapshot snap) {
    var ss = snap.data() as Map<String, dynamic>;
    return videoo(
        username: ss["username"],
        uid: ss["uid"],
        id: ss["id"],
        like: ss["like"],
        commentsCount: ss["commentsCount"],
        description: ss["description"],
        cat: ss["cat"],
        caption: ss["caption"],
        location: ss["location"],
        profilepic: ss["profilepic"],
        thumbnail: ss["thumbnail"],
        videourl: ss["videourl"]);
  }
}
