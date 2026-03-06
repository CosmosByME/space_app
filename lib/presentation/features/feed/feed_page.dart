import 'package:flutter/material.dart';
import 'package:space_app/main.dart';
import 'package:space_app/presentation/components/add_post.dart';
import 'package:space_app/presentation/components/app_post.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Widget> posts = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      posts.add(AppPost(image: images[i % images.length]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [AddPost(), ...posts],
        ),
      ),
    );
  }
}
