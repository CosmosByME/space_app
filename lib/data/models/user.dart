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

  User({
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
  });
}
