import 'package:space_app/data/models/user.dart';

abstract class UserRepository {
  Future<User?> loadUser(String uid);
  Future<void> updateUser(User user);
}
