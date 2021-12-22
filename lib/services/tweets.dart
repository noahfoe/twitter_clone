import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TweetService {
  Future saveTweet(String text) async {
    await FirebaseFirestore.instance.collection("tweets").add({
      'text': text,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
