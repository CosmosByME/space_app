class User {
  final String uid;
  final String name;
  final String email;
  final String username;
  final String bio;
  final String profileImageUrl;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final DateTime createdAt;
  final bool followed;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
    required this.followersCount,
    required this.followingCount,
    required this.postsCount,
    required this.createdAt,
    required this.followed,
  });

  User copyWith({
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
    return User(
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
