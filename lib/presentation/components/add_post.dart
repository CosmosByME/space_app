import 'dart:io';

import 'package:flutter/material.dart';
import 'package:space_app/domain/services/img_picker_service.dart';
import 'package:space_app/presentation/components/icons.dart';

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
        color: Colors.white,
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
              hintText: "What's on your mind?",
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addMedia(),
              ElevatedButton(onPressed: () {}, child: Text("Post")),
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
