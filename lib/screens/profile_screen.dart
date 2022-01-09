import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/screens/tweets/list_tweets.dart';
import 'package:twitter_clone/services/shared_prefs.dart';
import 'package:twitter_clone/services/tweets.dart';
import 'package:twitter_clone/services/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _bannerPicture;
  File? _profilePicture;
  final TweetService _tweetService = TweetService();
  final UserService _userService = UserService();
  final SharedPrefs _prefs = SharedPrefs();

  late bool isPrivateAccount;
  late int followingCount;
  late int followerCount;
  late String username;
  late String name;
  late String bio;
  late String location;

  Future<int?> getFollowing() async {
    followingCount = await _prefs.getFollowingFromSharedPref();
    return followingCount;
  }

  Future<int?> getFollowers() async {
    followerCount = await _prefs.getFollowersFromSharedPref();
    return followerCount;
  }

  Future<String?> getUsername() async {
    username = await _prefs.getUsernameFromSharedPref();
    return username;
  }

  Future<String?> getName() async {
    name = await _prefs.getNameFromSharedPref();
    return name;
  }

  Future<bool?> getIsPrivateAccount() async {
    isPrivateAccount = await _prefs.getIsPrivateAccountFromSharedPrefs();
    return isPrivateAccount;
  }

  Future<String?> getBio() async {
    bio = await _prefs.getBioFromSharedPrefs();
    return bio;
  }

  Future<String?> getLocation() async {
    location = await _prefs.getLocationFromSharedPrefs();
    return location;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: Future.wait([
          getFollowers(),
          getFollowing(),
          getUsername(),
          getName(),
          getIsPrivateAccount(),
          getBio(),
          getLocation(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                StreamProvider.value(
                    value: _tweetService.getTweetsByUser(
                        FirebaseAuth.instance.currentUser!.uid),
                    initialData: null),
                StreamProvider.value(
                    value: _userService
                        .getUserInfo(FirebaseAuth.instance.currentUser!.uid),
                    initialData: null),
              ],
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data![3]),
                      const Text(
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
                                onPressed: () => context.goNamed('edit'),
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                      const BorderSide(color: Colors.black45)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size(size.width / 3, 10)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                            children: [
                              Text(
                                snapshot.data![3],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: snapshot.data![4]
                                    ? const Icon(Icons.lock, size: 21)
                                    : Container(),
                              ),
                            ],
                          ),
                          Text(snapshot.data![2]),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              snapshot.data![5],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Implement on tap location
                                },
                                child: Text(
                                  snapshot.data![6],
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: FaIcon(FontAwesomeIcons.calendarAlt,
                                    size: 18),
                              ),
                              const Text("Joined September 2016"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  snapshot.data![1].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0, right: 10.0),
                                  child: Text(
                                    "Following",
                                  ),
                                ),
                                Text(
                                  snapshot.data![0].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Padding(
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
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color.fromRGBO(
                                                    29, 161, 242, 1)))),
                                    child: const Text('Tweets'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Implement on tap
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color.fromRGBO(
                                                    29, 161, 242, 1)))),
                                    child: const Text('Tweets & replies'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Implement on tap
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color.fromRGBO(
                                                    29, 161, 242, 1)))),
                                    child: const Text('Media'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Implement on tap
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color.fromRGBO(
                                                    29, 161, 242, 1)))),
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
