import 'dart:io';

import 'package:flutter/material.dart';
import 'package:space_app/data/repository/post_repository_impl.dart';
import 'package:space_app/domain/models/post.dart';
import 'package:space_app/domain/services/img_picker_service.dart';
import 'package:space_app/domain/services/supabase_storage_service.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/components/snack_bars.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController controller = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          image != null
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(image!, fit: BoxFit.cover),
                )
              : SizedBox.shrink(),
          TextField(
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Caption",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addMedia(),
              ElevatedButton(
                onPressed: image == null
                    ? null
                    : () async {
                        try {
                          final imgUrl =
                              await SupabaseStorageService.uploadPostImage(
                                image!,
                              );
                          final post = Post(controller.text, imgUrl);
                          await PostRepositoryImpl().addPost(post);
                          showSuccessSnackBar(
                            context,
                            "Post added successfully",
                          );
                        } on Exception catch (e) {
                          debugPrint(e.toString());
                          showErrorSnackBar(context, "Something went wrong");
                        }
                      },
                child: Text("Post"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addMedia() {
    return GestureDetector(
      onTap: () async {
        final img = await ImgPickerService.pickImage();
        setState(() {
          image = img;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [AppIcons.mediaIcon, SizedBox(width: 10), Text("Add Media")],
      ),
    );
  }
}
