import 'package:flutter/material.dart';
import 'package:space_app/main.dart';
import 'package:space_app/presentation/components/app_post.dart';

class AllPosts extends StatelessWidget {
  const AllPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return AppPost(image: images[index]);
      },
    );
  }
}
