import 'package:flutter/material.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/domain/services/follow_unfollow_service.dart';
import 'package:space_app/domain/services/search_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(5),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    SearchService.searchUsers(value).then((value) {
                      users = value;
                    });
                  });
                },
              ),
            ),
          ),
          SliverList.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return UserTile(user: users[index]);
            },
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: widget.user.profileImageUrl.isEmpty
                  ? const AssetImage("assets/images/profile_pic.png")
                  : NetworkImage(widget.user.profileImageUrl),
            ),
          ),
          Text(widget.user.username),
          Expanded(child: SizedBox()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.user.followed ? Colors.grey : Colors.blue,
            ),
            onPressed: () {
              setState(() {
                widget.user.followed = !widget.user.followed;
                if (widget.user.followed) {
                  FollowUnfollowService.follow(widget.user);
                } else {
                  FollowUnfollowService.unfollow(widget.user);
                }
              });
            },
            child: Text(widget.user.followed ? "Unfollow" : "Follow"),
          ),
        ],
      ),
    );
  }
}
