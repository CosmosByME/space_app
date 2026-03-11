import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/data/repository/user_repository_impl.dart';
import 'package:space_app/domain/services/token_service.dart';

class FollowUnfollowService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> follow(UserModel otherUser) async {
    final uid = await TokenService.readToken();
    final me = await UserRepositoryImpl().loadUser(uid);

    try {
      //I updated my following collection and following count
      await _db
          .collection("users")
          .doc(uid)
          .collection("following")
          .doc(otherUser.uid)
          .set(otherUser.toJson());
      await _db.collection("users").doc(uid).update({
        "followingCount": FieldValue.increment(1),
      });
      //Someones followers collection updated and followers count incremented
      await _db
          .collection("users")
          .doc(otherUser.uid)
          .collection("followers")
          .doc(uid)
          .set(me!.toJson());
      await _db.collection("users").doc(otherUser.uid).update({
        "followersCount": FieldValue.increment(1),
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> unfollow(UserModel otherUser) async {
    final uid = await TokenService.readToken();
    try {
      //I updated my following collection and following count
      await _db
          .collection("users")
          .doc(uid)
          .collection("following")
          .doc(otherUser.uid)
          .delete();
      await _db.collection("users").doc(uid).update({
        "followingCount": FieldValue.increment(-1),
      });
      //Someones followers collection updated and followers count incremented
      await _db
          .collection("users")
          .doc(otherUser.uid)
          .collection("followers")
          .doc(uid)
          .delete();
      await _db.collection("users").doc(otherUser.uid).update({
        "followersCount": FieldValue.increment(-1),
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
