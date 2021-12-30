import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/services/my_utils.dart';

class UserService {
  final UtilsService _utilsService = UtilsService();
  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            id: snapshot.id,
            name: (snapshot.data() as Map)['name'],
            email: (snapshot.data() as Map)['email'],
            bannerImage: (snapshot.data() as Map)['bannerImage'],
            profileImage: (snapshot.data() as Map)['profileImage'],
          )
        : UserModel(
            id: "id",
            name: "name",
            email: "email",
            bannerImage: "bannerImage",
            profileImage: "profileImage",
          );
  }

  Stream<UserModel> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Future<void> updateProfile(
    File? _banner,
    File? _profile,
    String? username,
  ) async {
    String _bannerUrl = '';
    String _profileUrl = '';

    if (_banner != null) {
      _bannerUrl = await _utilsService.uploadFile(_banner,
          'user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }

    if (_profile != null) {
      _profileUrl = await _utilsService.uploadFile(_profile,
          'user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile');
    }

    Map<String, Object> data = HashMap();
    if (username != '') data['name'] = username!;
    if (_bannerUrl != '') data['bannerImage'] = _bannerUrl;
    if (_profileUrl != '') data['profileImage'] = _profileUrl;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }
}
