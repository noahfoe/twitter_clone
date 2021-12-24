import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setNameFromSharedPref(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', val);
  }

  Future<String> getNameFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    if (name != null) {
      return name;
    } else {
      return "";
    }
  }

  Future<void> setUsernameFromSharedPref(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', val);
  }

  Future<String> getUsernameFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      return "@$username";
    } else {
      return "";
    }
  }

  Future<void> setFollowingFromSharedPref(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('following', val);
  }

  Future<int> getFollowingFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? following = prefs.getInt('following');

    if (following != null) {
      return following;
    } else {
      return 0;
    }
  }

  Future<void> setFollowersFromSharedPref(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('followers', val);
  }

  Future<int> getFollowersFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? followers = prefs.getInt('followers');
    if (followers != null) {
      return followers;
    } else {
      return 0;
    }
  }

  Future<void> setIsPrivateAccountFromSharedPrefs(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('private', val);
  }

  Future<bool> getIsPrivateAccountFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isPrivate = prefs.getBool('private');
    if (isPrivate != null) {
      return isPrivate;
    } else {
      return false;
    }
  }
}
