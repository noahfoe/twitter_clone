import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twitter_clone/screens/auth/signin.dart';
import 'package:twitter_clone/screens/auth/signup.dart';
import 'package:twitter_clone/screens/edit_profile_screen.dart';
import 'package:twitter_clone/screens/home_screen.dart';
import 'package:twitter_clone/screens/profile_screen.dart';
import 'package:twitter_clone/screens/tweets/add_tweet.dart';
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
    final _router = GoRouter(
      initialLocation: '/signin',
      routes: [
        GoRoute(
          name: 'signin',
          path: '/signin',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const Signin(),
          ),
        ),
        GoRoute(
          name: 'signup',
          path: '/signup',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const Signup(),
          ),
        ),
        GoRoute(
            name: 'home',
            path: '/home',
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const MyHomePage(),
                ),
            // subroutes
            routes: [
              GoRoute(
                name: 'profile',
                path: 'profile',
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const ProfileScreen(),
                ),
                routes: [
                  GoRoute(
                    name: 'edit',
                    path: 'edit',
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: const EditProfile(),
                    ),
                  ),
                ],
              ),
              GoRoute(
                name: 'tweet',
                path: 'tweet', // e.g. /home/tweet
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const AddTweet(),
                ),
              ),
            ]),
      ],
      // TODO: Style error page
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      ),
    );
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
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routeInformationParser: _router.routeInformationParser,
                routerDelegate: _router.routerDelegate,
                title: 'Twitter',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
              ),
              /*
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Twitter',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const Wrapper(),
              ),
              */
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
