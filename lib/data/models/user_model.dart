import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_app/domain/models/user.dart';

class UserModel extends User {
  UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.username,
    required super.bio,
    required super.profileImageUrl,
    required super.followersCount,
    required super.followingCount,
    required super.postsCount,
    required super.createdAt,
    required super.followed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      followersCount: json['followersCount'] as int,
      followingCount: json['followingCount'] as int,
      postsCount: json['postsCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      followed: json['followed'] as bool,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      username: map['username'] as String? ?? '',
      bio: map['bio'] as String? ?? '',
      profileImageUrl: map['profileImageUrl'] as String? ?? '',
      followersCount: map['followersCount'] as int? ?? 0,
      followingCount: map['followingCount'] as int? ?? 0,
      postsCount: map['postsCount'] as int? ?? 0,
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      followed: map['followed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'username': username,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postsCount': postsCount,
      'createdAt': createdAt.toIso8601String(),
      'followed': followed,
    };
  }

  @override
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? username,
    String? bio,
    String? profileImageUrl,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    DateTime? createdAt,
    bool? followed,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      createdAt: createdAt ?? this.createdAt,
      followed: followed ?? this.followed,
    );
  }
}
