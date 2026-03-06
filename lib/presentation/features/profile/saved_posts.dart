import 'package:flutter/material.dart';
import 'package:space_app/main.dart';
import 'package:space_app/presentation/components/app_post.dart';

class SavedPosts extends StatelessWidget {
  const SavedPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return AppPost(image: images[(index % 4 + 1) % images.length]);
      },
    );
  }
}
