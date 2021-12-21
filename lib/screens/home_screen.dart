import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/services/auth_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    return Scaffold(
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
            // TODO: Handle on tap profile pic
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            // TODO: Change to user profile picture
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "img/headshot.jpg",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("Home Page"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create a new tweet
        },
        backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
        child: const FaIcon(FontAwesomeIcons.featherAlt),
      ),
    );
  }
}
