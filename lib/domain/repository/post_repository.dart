import 'package:space_app/domain/models/post.dart';

abstract class PostRepository {
  Future<void> likePost(Post post);
  Future<void> unlikePost(Post post);
  Future<bool> isPostLiked(String postId);
  Future<List<Post>> loadLikedPosts({int limit = 10});
  Future<void> addComment();
  Future<void> deleteComment();
  Future<void> addPost(Post post);
  Future<void> deletePost(Post post);
  Future<void> updatePost();
  Future<List<Post>> getPosts({int limit = 10});
  Future<List<Post>> getMyPosts({int limit = 10});
  Future<void> getComments();
  Future<void> getLikes();
  void reset();
}
