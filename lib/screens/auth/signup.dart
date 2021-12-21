import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/components/signup/email_field.dart';
import 'package:twitter_clone/components/signup/password_field.dart';
import 'package:twitter_clone/screens/auth/signin.dart';
import 'package:twitter_clone/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void signUpAction() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Twitter")),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showToast("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        _showToast("The account already exists for that email.");
      }
    } catch (e) {
      _showToast("An unexpected error has occured.");
    }
  }

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    bool _isObscure = true;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: height / 1.4,
            color: const Color.fromRGBO(29, 161, 242, 1),
            child: myCustomForm(_isObscure),
          ),
          const Spacer(flex: 1),
          ElevatedButton(
            onPressed: () async => {signUpAction()},
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color.fromRGBO(29, 161, 242, 1)),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              fixedSize: MaterialStateProperty.all<Size>(Size(width / 2, 40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                    color: Color.fromRGBO(29, 161, 242, 1),
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              GestureDetector(
                child: const Text(
                  "Sign in here!",
                  style: TextStyle(
                    color: Color.fromRGBO(29, 161, 242, 1),
                  ),
                ),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Signin()),
                  ),
                },
              ),
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  myCustomForm(bool _isObscure) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Form(
        child: Column(
          children: [
            const Spacer(flex: 1),
            const Text(
              "Sign Up",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            const Spacer(flex: 1),
            const SizedBox(
              height: 100,
              width: 100,
              child: Image(
                image: AssetImage("img/logo.png"),
              ),
            ),
            const Spacer(flex: 1),
            EmailField(
              onChanged: (val) => setState(() {
                email = val;
              }),
            ),
            const SizedBox(height: 10),
            PasswordField(
              onChanged: (val) => setState(() {
                password = val;
              }),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  _showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            msg,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
