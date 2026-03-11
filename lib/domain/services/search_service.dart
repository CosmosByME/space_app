import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/domain/services/token_service.dart';

class SearchService {
  static final _db = FirebaseFirestore.instance;

  static Future<List<UserModel>> searchUsers(String query) async {
    final List<UserModel> list = [];
    final uid = await TokenService.readToken();
    final result = await _db
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThan: '${query}z')
        .get();

    var follow_list = await _db
        .collection("users")
        .doc(uid)
        .collection("following")
        .get();

    List<String> maps = follow_list.docs
        .map((doc) => UserModel.fromJson(doc.data()).uid)
        .toList();

    for (var item in result.docs) {
      var a = UserModel.fromJson(item.data());
      if (maps.contains(a.uid)) {
        a.followed = true;
      }
      list.add(a);
    }
    return list;
  }
}
