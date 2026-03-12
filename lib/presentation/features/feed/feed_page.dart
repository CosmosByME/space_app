import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:space_app/data/repository/post_repository_impl.dart';
import 'package:space_app/domain/models/post.dart';
import 'package:space_app/domain/services/token_service.dart';
import 'package:space_app/presentation/components/add_post.dart';
import 'package:space_app/presentation/components/app_post.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _repo = PostRepositoryImpl();
  final _scrollController = ScrollController();
  final List<Widget> _posts = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Trigger load when near bottom
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_repo.hasMore) return;
    setState(() => _isLoading = true);

    final newPosts = await _repo.getPosts(limit: 10);
    setState(() {
      _posts.addAll(newPosts.map((post) => AppPost(post: post)));
      _isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    _repo.reset();
    _posts.clear();
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await _onRefresh();
        },
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('date', descending: true)
              .limit(10)
              .snapshots()
              .asyncMap((snapshot) async {
                // 👈 asyncMap instead of map
                final futures = snapshot.docs.map((doc) async {
                  final a = Post.fromMap(doc.data());
                  if (a.uid == await TokenService.readToken()) {
                    a.mine = true;
                  }
                  if (await PostRepositoryImpl().isPostLiked(a.id)) {
                    a.liked = true;
                  }
                  return AppPost(post: a);
                });
                return Future.wait(futures); // 👈 awaits all futures together
              }),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Skeletonizer(
                child: ListView(
                  children: [
                    // Skeleton for AddPost
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: Text("What's on your mind?"),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Add Media"),
                              ElevatedButton(
                                onPressed: null,
                                child: Text("Post"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Skeleton AppPosts
                    ...List.generate(
                      5,
                      (index) => AppPost(
                        post: Post(
                          "jkjashfkj",
                          "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/53970855226_596526383a_c.jpg",
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error: ${asyncSnapshot.error}'));
            }

            if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  AddPost(),
                  SizedBox(
                    height: 300,
                    child: Center(child: Text('No posts yet')),
                  ),
                ],
              );
            }

            _posts.clear();
            _posts.addAll(asyncSnapshot.data!);
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [AddPost(), ..._posts],
            );
          },
        ),
      ),
    );
  }
}
