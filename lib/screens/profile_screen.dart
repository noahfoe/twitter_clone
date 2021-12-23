import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/screens/edit_profile_screen.dart';
import 'package:twitter_clone/screens/tweets/list_tweets.dart';
import 'package:twitter_clone/services/tweets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TweetService _tweetService = TweetService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value:
          _tweetService.getTweetsByUser(FirebaseAuth.instance.currentUser!.uid),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Noah Foley"),
              Text(
                "2 Tweets",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: FaIcon(FontAwesomeIcons.search),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: FaIcon(FontAwesomeIcons.ellipsisV),
            ),
          ],
        ),
        body: Column(
          children: [
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ),
              ),
              child: const Text("Edit Profile"),
            ),
            const Expanded(
              child: ListTweets(),
            ),
          ],
        ),
      ),
    );
  }
}
