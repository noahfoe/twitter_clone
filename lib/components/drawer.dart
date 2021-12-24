import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/screens/profile_screen.dart';
import 'dart:math' as math;

class MyDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool isPrivateAccount;
  final int followingCount;
  final int followerCount;

  const MyDrawer(
      {Key? key,
      required this.scaffoldKey,
      required this.isPrivateAccount,
      required this.followingCount,
      required this.followerCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 178,
            child: DrawerHeader(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          scaffoldKey!.currentState?.openDrawer();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          // TODO: Change to user profile picture
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "img/defaultPfp.jpg",
                              width: size.width / 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: [
                      const Text(
                        "Noah Foley",
                        style: TextStyle(color: Colors.black),
                      ),
                      const Spacer(flex: 1),
                      isPrivateAccount
                          ? const Icon(
                              Icons.lock,
                              size: 15,
                            )
                          : Container(),
                      const Spacer(flex: 30),
                      Transform.rotate(
                        angle: -90 * math.pi / 180,
                        child: const Icon(Icons.chevron_left),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: const [
                      Text(
                        "@NFooley1999",
                        style:
                            TextStyle(color: Color.fromRGBO(140, 148, 155, 1)),
                      ),
                    ],
                  ),
                  const Spacer(flex: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        followingCount.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Text(
                        " Following",
                        style:
                            TextStyle(color: Color.fromRGBO(140, 148, 155, 1)),
                      ),
                      const Spacer(flex: 1),
                      Text(
                        followerCount.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Text(
                        " Followers",
                        style:
                            TextStyle(color: Color.fromRGBO(140, 148, 155, 1)),
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                ],
              ),
              decoration: const BoxDecoration(color: Colors.white),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const Divider(thickness: 1),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.user),
                  title: const Text("Profile"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.listAlt),
                  title: Text("Lists"),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.commentDots),
                  title: Text("Topics"),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.bookmark),
                  title: Text("Bookmarks"),
                ),
                const ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.twitterSquare,
                    color: Colors.blue,
                  ),
                  title: Text("Twitter Blue"),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.bolt),
                  title: Text("Moments"),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.moneyBillAlt),
                  title: Text("Monetization"),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.userPlus),
                  title: Text("Follower requests"),
                ),
                const Divider(thickness: 1),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.rocket),
                  title: Text("Twitter for Professionals"),
                ),
                const Divider(thickness: 1),
                const ListTile(
                  title: Text("Settings and privacy"),
                ),
                const ListTile(
                  title: Text("Help Center"),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: const [
                Spacer(flex: 1),
                FaIcon(FontAwesomeIcons.lightbulb),
                Spacer(flex: 10),
                FaIcon(FontAwesomeIcons.qrcode),
                Spacer(flex: 1)
              ],
            ),
          )
        ],
      ),
    );
  }
}
