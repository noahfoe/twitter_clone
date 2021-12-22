import 'package:cloud_firestore/cloud_firestore.dart';

class TweetModel {
  final String id;
  final String user;
  final String text;
  final Timestamp time;

  TweetModel(this.id, this.user, this.text, this.time);
}
