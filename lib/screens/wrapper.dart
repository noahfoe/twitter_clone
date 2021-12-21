import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/screens/auth/signup.dart';
import 'package:twitter_clone/screens/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);
    if (user == null) {
      // show auth system routes
      return const Signup();
    } else {
      // show main system routes
      return const MyHomePage();
    }
  }
}
