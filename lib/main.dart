import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/screens/auth/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twitter_clone/screens/wrapper.dart';
import 'package:twitter_clone/services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //return ErrorPage();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider(
              create: (context) => context.read<AuthService>().authStateChanges,
              initialData: null,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Twitter',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const Wrapper(),
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
