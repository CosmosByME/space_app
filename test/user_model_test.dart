import 'package:flutter_test/flutter_test.dart';
import 'package:space_app/data/models/user.dart';
import 'package:space_app/domain/models/user_model.dart';

void main() {
  group('UserModel', () {
    final now = DateTime.now();
    final userJson = {
      'uid': '123',
      'name': 'John Doe',
      'email': 'john@example.com',
      'username': 'johndoe',
      'bio': 'Test bio',
      'profileImageUrl': 'https://example.com/image.jpg',
      'followersCount': 100,
      'followingCount': 50,
      'postsCount': 10,
      'createdAt': now.toIso8601String(),
    };

    test('should be a subclass of User', () {
      final model = UserModel.fromJson(userJson);
      expect(model, isA<User>());
    });

    test('fromJson should return a valid model', () {
      final model = UserModel.fromJson(userJson);

      expect(model.uid, '123');
      expect(model.name, 'John Doe');
      expect(model.email, 'john@example.com');
      expect(model.username, 'johndoe');
      expect(model.followersCount, 100);
      expect(model.createdAt.toIso8601String(), now.toIso8601String());
    });

    test('toJson should return a valid Map', () {
      final model = UserModel(
        uid: '123',
        name: 'John Doe',
        email: 'john@example.com',
        username: 'johndoe',
        bio: 'Test bio',
        profileImageUrl: 'https://example.com/image.jpg',
        followersCount: 100,
        followingCount: 50,
        postsCount: 10,
        createdAt: now,
      );

      final result = model.toJson();

      expect(result, userJson);
    });
  });
}
