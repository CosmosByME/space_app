import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_app/presentation/components/icons.dart';

class AppPost extends StatefulWidget {
  final String image;
  const AppPost({super.key, required this.image});

  @override
  State<AppPost> createState() => _AppPostState();
}

class _AppPostState extends State<AppPost> {
  late String name = "J. Webb";
  late String date = "01.03.2026";
  late String caption = "This photo was taken by James Webb Space Telescope 🌌";
  late bool isLiked = false;
  late SvgPicture profile = AppIcons.userIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          "assets/images/profile_pic.png",
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "jwebb@mail.com",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(onTap: () {}, child: AppIcons.moreIcon),
                    SizedBox(height: 3),
                    Text(date, style: TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
          ),
          //#post image
          SizedBox(height: 8),
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            imageUrl: widget.image,
            placeholder: (context, url) => SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) {
              debugPrint(error.toString());
              return SizedBox(height: 200, child: Icon(Icons.error));
            },
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                text: caption,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          //#like share
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: AppIcons.commentIcon,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("Comment"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("270 Likes"),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: isLiked
                          ? SizedBox(
                              height: 25,
                              width: 25,
                              child: AppIcons.likeIconSelected,
                            )
                          : SizedBox(
                              height: 25,
                              width: 25,
                              child: AppIcons.likeIcon,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
