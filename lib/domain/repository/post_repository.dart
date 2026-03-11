abstract class PostRepository {
  Future<void> likePost();
  Future<void> unlikePost();
  Future<void> addComment();
  Future<void> deleteComment();
  Future<void> addPost();
  Future<void> deletePost();
  Future<void> updatePost();
  Future<void> getPosts();
  Future<void> getPost();
  Future<void> getComments();
  Future<void> getLikes();
}
