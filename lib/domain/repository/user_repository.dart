import 'package:space_app/domain/models/user.dart';
import 'package:space_app/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> addUser(UserModel user);
  Future<User?> loadUser(String uid);
  Future<void> updateUser(UserModel user);
}
