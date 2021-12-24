import 'dart:io';

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
  File? _bannerPicture;
  File? _profilePicture;
  final TweetService _tweetService = TweetService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Implement on tap
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height / 4,
                    child: _bannerPicture != null
                        ? Image.file(
                            _bannerPicture!,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            "img/defaultBanner.png",
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: size.height / 13,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        ),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(color: Colors.black45)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(size.width / 3, 10)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                color: Color.fromRGBO(29, 161, 242, 1),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement on tap
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _profilePicture != null
                            ? Image.file(
                                _profilePicture!,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                "img/defaultPfp.jpg",
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                // TODO: Add profile info
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "Noah Foley",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.lock, size: 21),
                      ),
                    ],
                  ),
                  const Text("@NFooley1999"),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "App Developer for Aderoo\nTexas State University Alumni - Computer Science major, minors in Comm Studies and Applied Math",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement on tap location
                        },
                        child: const Text(
                          "Carthage, TX",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: FaIcon(FontAwesomeIcons.calendarAlt, size: 18),
                      ),
                      const Text("Joined September 2016"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: const [
                        Text(
                          "263",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 10.0),
                          child: Text(
                            "Following",
                          ),
                        ),
                        Text(
                          "91",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            "Followers",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement on tap
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0,
                                        color:
                                            Color.fromRGBO(29, 161, 242, 1)))),
                            child: const Text('Tweets'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement on tap
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0,
                                        color:
                                            Color.fromRGBO(29, 161, 242, 1)))),
                            child: const Text('Tweets & replies'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement on tap
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0,
                                        color:
                                            Color.fromRGBO(29, 161, 242, 1)))),
                            child: const Text('Media'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement on tap
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2.0,
                                        color:
                                            Color.fromRGBO(29, 161, 242, 1)))),
                            child: const Text('Likes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
