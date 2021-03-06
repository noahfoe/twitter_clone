import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/models/tweet.dart';

class ListTweets extends StatefulWidget {
  const ListTweets({Key? key}) : super(key: key);

  @override
  _ListTweetsState createState() => _ListTweetsState();
}

class _ListTweetsState extends State<ListTweets> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final tweets = Provider.of<List<TweetModel>?>(context) ?? [];

    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        final tweet = tweets[index];
        DateTime date = tweet.time.toDate().toLocal();
        return ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          title: Row(
            children: [
              // tweet.user
              Text(tweet.user),
              // TODO: Add lock only if user is a private account
              const Icon(
                Icons.lock,
                size: 15,
              ),
              // tweet.username
              Text(" " + tweet.username + " "),
              const FaIcon(
                FontAwesomeIcons.solidCircle,
                size: 3,
              ),
              // tweet.time - converted
              Text(DateFormat(' dd LLL yy').format(date)),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tweet.text),
              SizedBox(height: size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // TODO: Change values of comments, likes, retweets to actual values
                children: const [
                  FaIcon(FontAwesomeIcons.comment, size: 20),
                  Spacer(flex: 1),
                  // tweet.comments.length
                  Text("1"),
                  Spacer(flex: 4),
                  FaIcon(FontAwesomeIcons.retweet, size: 20),
                  Spacer(flex: 1),
                  // tweet.retweets.length
                  Text("10"),
                  Spacer(flex: 4),
                  FaIcon(FontAwesomeIcons.heart, size: 20),
                  Spacer(flex: 1),
                  // tweet.likes.length
                  Text("1"),
                  Spacer(flex: 4),
                  FaIcon(FontAwesomeIcons.shareAlt, size: 20),
                  Spacer(flex: 2),
                  FaIcon(FontAwesomeIcons.chartBar),
                  Spacer(flex: 2),
                ],
              )
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              // TODO: Implement on Tap of Profile pic
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
        );
      },
    );
  }
}
