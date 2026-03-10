import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_app/data/repository/user_repository.dart';
import 'package:space_app/domain/models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<void> addUser(UserModel user) async {
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(user.uid).set(user.toJson());
  }

  @override
  Future<UserModel?> loadUser(String uid) async {
    final db = FirebaseFirestore.instance;
    try {
      final jsonSnapshot = await db.collection("users").doc(uid).get();
      UserModel user = UserModel.fromJson(jsonSnapshot.data()!);
      return user;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(user.uid).update(user.toJson());
  }
}
