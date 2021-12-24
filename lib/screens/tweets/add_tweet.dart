import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/services/tweets.dart';

class AddTweet extends StatefulWidget {
  const AddTweet({Key? key}) : super(key: key);

  @override
  _AddTweetState createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {
  final TweetService _tweetService = TweetService();
  String tweetText = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.times,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () async {
                if (tweetText != "") {
                  _tweetService.saveTweet(tweetText);
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "Tweet",
                style: TextStyle(
                    color: (tweetText == "")
                        ? const Color.fromRGBO(127, 127, 127, 1)
                        : Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: (tweetText == "")
                    ? MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(14, 77, 119, 1))
                    : MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(29, 161, 242, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: "What's Happening?",
              border: InputBorder.none,
              // TODO: Change to user pfp
              icon: GestureDetector(
                onTap: () {
                  // TODO: Handle on tap profile pic
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
            ),
            onChanged: (val) {
              setState(() {
                tweetText = val;
              });
            },
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
