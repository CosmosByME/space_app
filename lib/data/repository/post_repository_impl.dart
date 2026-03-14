import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/data/repository/user_repository_impl.dart';
import 'package:space_app/domain/models/post.dart';
import 'package:space_app/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _currentUid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addComment() {
    throw UnimplementedError();
  }

  @override
  Future<void> addPost(Post post) async {
    String uid = _currentUid;
    UserModel me = (await UserRepositoryImpl().loadUser(uid))!;
    post.uid = me.uid;
    post.fullname = me.name;
    post.imgUser = me.profileImageUrl;
    post.date = DateTime.now().toIso8601String();

    post.id = "${post.date}_${post.uid}";

    await _firestore.collection("posts").doc(post.id).set(post.toJson());

    // Add reference to myPosts subcollection
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("myPosts")
        .doc(post.id)
        .set({'postId': post.id, 'date': post.date});

    // Increment user's post count
    await _firestore.collection("users").doc(uid).update({
      "postsCount": FieldValue.increment(1),
    });
  }

  @override
  Future<void> deleteComment() {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(Post post) async {
    await _firestore.collection("posts").doc(post.id).delete();

    // Remove reference from myPosts subcollection
    await _firestore
        .collection("users")
        .doc(post.uid)
        .collection("myPosts")
        .doc(post.id)
        .delete();

    // Decrement user's post count
    await _firestore.collection("users").doc(post.uid).update({
      "postsCount": FieldValue.increment(-1),
    });
  }

  @override
  Future<void> getComments() {
    throw UnimplementedError();
  }

  @override
  Future<void> getLikes() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isPostLiked(String postId) async {
    final doc = await _firestore
        .collection("users")
        .doc(_currentUid)
        .collection("likedPosts")
        .doc(postId)
        .get();
    return doc.exists;
  }

  @override
  Future<List<Post>> getMyPosts({int limit = 10}) async {
    String uid = _currentUid;
    List<Post> posts = [];

    // Get post IDs from myPosts subcollection
    final mySnapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("myPosts")
        .orderBy("date", descending: true)
        .limit(limit)
        .get();

    if (mySnapshot.docs.isEmpty) return posts;

    final myPostIds = mySnapshot.docs.map((doc) => doc.id).toList();

    var querySnapshot = _firestore
        .collection("posts")
        .where("id", whereIn: myPostIds)
        .limit(limit);

    if (lastDocument != null) {
      querySnapshot = querySnapshot.startAfterDocument(lastDocument!);
    }

    final snapshot = await querySnapshot.get();
    if (snapshot.docs.length < limit || snapshot.docs.isEmpty) {
      hasMore = false;
    }

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }

    final Map<String, Post> postMap = {
      for (var result in snapshot.docs) result.id: Post.fromMap(result.data()),
    };

    // Keep the order from mySnapshot
    for (var id in myPostIds) {
      final post = postMap[id];
      if (post != null) {
        post.mine = true;
        if (await isPostLiked(post.id)) {
          post.liked = true;
        }
        posts.add(post);
      }
    }
    return posts;
  }

  @override
  Future<List<Post>> getPosts({int limit = 10}) async {
    String uid = _currentUid;
    List<Post> posts = [];
    var querySnapshot = _firestore
        .collection("posts")
        .orderBy("date", descending: true)
        .limit(limit);

    if (lastDocument != null) {
      querySnapshot = querySnapshot.startAfterDocument(lastDocument!);
    }

    final snapshot = await querySnapshot.get();
    if (snapshot.docs.length < limit || snapshot.docs.isEmpty) {
      hasMore = false;
    }

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }
    for (var result in snapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      if (await isPostLiked(post.id)) {
        post.liked = true;
      }
      posts.add(post);
    }
    return posts;
  }

  @override
  void reset() {
    lastDocument = null;
    hasMore = true;
  }

  @override
  Future<List<Post>> loadLikedPosts({int limit = 10}) async {
    String uid = _currentUid;
    List<Post> posts = [];

    // Get liked post IDs from the subcollection
    final likedSnapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("likedPosts")
        .orderBy("likedAt", descending: true)
        .limit(limit)
        .get();

    if (likedSnapshot.docs.isEmpty) return posts;

    final likedPostIds = likedSnapshot.docs.map((doc) => doc.id).toList();

    // Fetch the actual posts by their IDs
    var querySnapshot = _firestore
        .collection("posts")
        .where("id", whereIn: likedPostIds)
        .limit(limit);

    if (lastDocument != null) {
      querySnapshot = querySnapshot.startAfterDocument(lastDocument!);
    }

    final snapshot = await querySnapshot.get();
    if (snapshot.docs.length < limit || snapshot.docs.isEmpty) {
      hasMore = false;
    }

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }
    for (var result in snapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      post.liked = true; // All posts from likedPosts are liked by definition
      posts.add(post);
    }
    return posts;
  }

  @override
  Future<void> likePost(Post post) async {
    String uid = _currentUid;

    // Increment likes count on the post
    await _firestore.collection("posts").doc(post.id).update({
      "likesCount": FieldValue.increment(1),
    });

    // Add to likedPosts subcollection
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("likedPosts")
        .doc(post.id)
        .set({'postId': post.id, 'likedAt': FieldValue.serverTimestamp()});
  }

  @override
  Future<void> unlikePost(Post post) async {
    String uid = _currentUid;

    // Decrement likes count on the post
    await _firestore.collection("posts").doc(post.id).update({
      "likesCount": FieldValue.increment(-1),
    });

    // Remove from likedPosts subcollection
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("likedPosts")
        .doc(post.id)
        .delete();
  }

  @override
  Future<void> updatePost() {
    throw UnimplementedError();
  }
}
