import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('myPosts')
          .orderBy('date', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, mySnapshot) {
        if (mySnapshot.connectionState == ConnectionState.waiting) {
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
        if (mySnapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${mySnapshot.error}')),
          );
        }

        final myDocs = mySnapshot.data?.docs ?? [];
        if (myDocs.isEmpty) {
          return SliverFillRemaining(
            child: Center(child: Text('No posts yet')),
          );
        }

        final myPostIds = myDocs.map((doc) => doc.id).toList();

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('id', whereIn: myPostIds)
              .snapshots(),
          builder: (context, postsSnapshot) {
            if (postsSnapshot.connectionState == ConnectionState.waiting) {
              return SliverFillRemaining(
                child: Skeletonizer(
                  enabled: true,
                  child: ListView.builder(
                    itemCount: myPostIds.length,
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
            if (postsSnapshot.hasError) {
              return SliverToBoxAdapter(
                child: Center(child: Text('Error: ${postsSnapshot.error}')),
              );
            }

            if (!postsSnapshot.hasData || postsSnapshot.data!.docs.isEmpty) {
              return SliverFillRemaining(
                child: Center(child: Text('No posts yet')),
              );
            }

            // We must preserve the sort order from mySnapshot since whereIn does not preserve order
            final Map<String, Post> postMap = {
              for (var doc in postsSnapshot.data!.docs)
                doc.id: Post.fromMap(doc.data() as Map<String, dynamic>)
            };

            // asyncMap to properly resolve all the async properties
            return FutureBuilder<List<Widget>>(
              future: Future.wait(myPostIds.map((id) async {
                final post = postMap[id];
                if (post == null) return const SizedBox.shrink(); // In case of data inconsistency
                
                final uid = await TokenService.readToken();
                if (post.uid == uid) {
                  post.mine = true;
                }
                if (await PostRepositoryImpl().isPostLiked(post.id)) {
                  post.liked = true;
                }
                return AppPost(post: post);
              })),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        itemCount: myPostIds.length,
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
                
                if (futureSnapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildListDelegate(futureSnapshot.data!),
                  );
                }
                
                return SliverFillRemaining(
                  child: Center(child: Text('Loading posts...')),
                );
              },
            );
          },
        );
      },
    );
  }
}
