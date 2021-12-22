import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/models/tweet.dart';

class TweetService {
  Future saveTweet(String text) async {
    await FirebaseFirestore.instance.collection("tweets").add({
      'text': text,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  List<TweetModel> _tweetListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return TweetModel(
        doc.id,
        (doc.data() as Map)['uid'] ?? '',
        (doc.data() as Map)['text'] ?? '',
        (doc.data() as Map)['time'] ?? Timestamp(0, 0),
      );
    }).toList();
  }

  Stream<List<TweetModel>> getTweetsByUser(uid) {
    return FirebaseFirestore.instance
        .collection("tweets")
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_tweetListFromSnapshot);
  }
}
