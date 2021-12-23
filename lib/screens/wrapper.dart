import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/screens/auth/signin.dart';
import 'package:twitter_clone/screens/edit_profile_screen.dart';
import 'package:twitter_clone/screens/home_screen.dart';
import 'package:twitter_clone/screens/profile_screen.dart';
import 'package:twitter_clone/screens/tweets/add_tweet.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);
    if (user == null) {
      // show auth system routes
      return const Signin();
    } else {
      // show main system routes
      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/add_tweet': (context) => const AddTweet(),
          '/profile': (context) => const ProfileScreen(),
          '/edit_profile': (context) => const EditProfile(),
        },
      );
    }
  }
}
