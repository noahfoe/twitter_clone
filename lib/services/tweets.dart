import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/models/tweet.dart';

class TweetService {
  Future saveTweet(String text, String username, String user) async {
    await FirebaseFirestore.instance.collection("tweets").add({
      'text': text,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'username': username,
      'user': user,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  List<TweetModel> _tweetListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return TweetModel(
        (doc.data() as Map)['uid'] ?? '',
        (doc.data() as Map)['user'] ?? '',
        (doc.data() as Map)['username'] ?? '',
        (doc.data() as Map)['text'] ?? '',
        (doc.data() as Map)['timestamp'] ?? Timestamp(0, 0),
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

  Stream<List<TweetModel>> getAllTweets() {
    return FirebaseFirestore.instance
        .collection("tweets")
        .snapshots()
        .map(_tweetListFromSnapshot);
  }
}
