import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:space_app/data/repository/post_repository_impl.dart';
import 'package:space_app/domain/models/post.dart';
import 'package:space_app/presentation/components/app_post.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({super.key});

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
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

    final newPosts = await _repo.loadLikedPosts(limit: 10);
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
          .collection('likedPosts')
          .orderBy('likedAt', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, likedSnapshot) {
        if (likedSnapshot.connectionState == ConnectionState.waiting) {
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
        if (likedSnapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${likedSnapshot.error}')),
          );
        }

        final likedDocs = likedSnapshot.data?.docs ?? [];
        if (likedDocs.isEmpty) {
          return SliverFillRemaining(
            child: Center(child: Text('No saved posts yet')),
          );
        }

        final likedPostIds = likedDocs.map((doc) => doc.id).toList();

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('id', whereIn: likedPostIds)
              .snapshots(),
          builder: (context, postsSnapshot) {
            if (postsSnapshot.connectionState == ConnectionState.waiting) {
              return SliverFillRemaining(
                child: Skeletonizer(
                  enabled: true,
                  child: ListView.builder(
                    itemCount: likedPostIds.length,
                    itemBuilder: (context, index) {
                      return AppPost(post: Post("jkjashfkj", "jksdhfkjsdhkj"));
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
                child: Center(child: Text('No saved posts yet')),
              );
            }

            final postWidgets = postsSnapshot.data!.docs.map((doc) {
              final post = Post.fromMap(doc.data() as Map<String, dynamic>);
              post.liked = true;
              return AppPost(post: post);
            }).toList();

            return SliverList(delegate: SliverChildListDelegate(postWidgets));
          },
        );
      },
    );
  }
}
