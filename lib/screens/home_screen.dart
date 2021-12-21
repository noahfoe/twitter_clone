import 'package:flutter/material.dart';
import 'package:twitter_clone/services/auth_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twitter"),
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.black)),
            label: const Text("Sign Out"),
            icon: const Icon(Icons.logout),
            onPressed: () async {
              _authService.signOutAction(context);
            },
          )
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
    );
  }
}
