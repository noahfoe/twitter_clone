import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/components/drawer.dart';
import 'package:twitter_clone/screens/tweets/add_tweet.dart';
import 'package:twitter_clone/screens/tweets/list_tweets.dart';
import 'package:twitter_clone/services/auth_service.dart';
import 'package:twitter_clone/services/shared_prefs.dart';
import 'package:twitter_clone/services/tweets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final TweetService _tweetService = TweetService();
  final SharedPrefs _prefs = SharedPrefs();

  late bool isPrivateAccount;
  late int followingCount;
  late int followerCount;
  late String username;
  late String name;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    return FutureBuilder(
        future: Future.wait([
          getFollowers(),
          getFollowing(),
          getUsername(),
          getName(),
          getIsPrivateAccount(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider.value(
              value: _tweetService.getAllTweets(),
              initialData: null,
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: SizedBox(
                    width: size.width / 12,
                    child: const Image(
                      color: Color.fromRGBO(29, 161, 242, 1),
                      image: AssetImage("img/logo.png"),
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: GestureDetector(
                    onTap: () {
                      scaffoldKey!.currentState?.openDrawer();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      // TODO: Change to user profile picture
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "img/defaultPfp.jpg",
                          width: size.width / 11,
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton.icon(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(29, 161, 242, 1))),
                      label: const Text(""),
                      icon: const Icon(Icons.logout),
                      onPressed: () async {
                        _authService.signOutAction(context);
                      },
                    ),
                  ],
                ),
                drawer: MyDrawer(
                  scaffoldKey: scaffoldKey,
                  isPrivateAccount: snapshot.data![4],
                  followingCount: snapshot.data![0],
                  followerCount: snapshot.data![1],
                  username: snapshot.data![2],
                  name: snapshot.data![3],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTweet(),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
                  child: const FaIcon(FontAwesomeIcons.featherAlt),
                ),
                body: const ListTweets(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
