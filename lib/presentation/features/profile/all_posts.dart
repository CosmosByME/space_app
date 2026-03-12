import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:space_app/data/repository/post_repository_impl.dart';
import 'package:space_app/domain/models/post.dart';
import 'package:space_app/domain/services/token_service.dart';
import 'package:space_app/presentation/components/app_post.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
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

    final newPosts = await _repo.getMyPosts(limit: 10);
    setState(() {
      _posts.addAll(newPosts.map((post) => AppPost(post: post)));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          return SliverFillRemaining(
            child: Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AppPost(
                    post: Post(
                      "jkjashfkj",
                      "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/53970855226_596526383a_c.jpg",
                    ),
                  );
                },
              ),
            ),
          );
        }
        if (asyncSnapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${asyncSnapshot.error}')),
          );
        }

        if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
          return SliverFillRemaining(
            child: Center(child: Text('No posts yet')),
          );
        }

        _posts.clear();
        _posts.addAll(asyncSnapshot.data!);
        return SliverList(delegate: SliverChildListDelegate(_posts));
      },
    );
  }
}
