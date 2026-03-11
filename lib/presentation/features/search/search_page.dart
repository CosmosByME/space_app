import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
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
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return UserTile();
            },
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  const UserTile({super.key});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool isFollowed = false;
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
              backgroundImage: AssetImage("assets/images/profile_pic.png"),
            ),
          ),
          Text("Username"),
          Expanded(child: SizedBox()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowed ? Colors.grey : Colors.blue,
            ),
            onPressed: () {
              setState(() {
                isFollowed = !isFollowed;
              });
            },
            child: Text(isFollowed ? "Unfollow" : "Follow"),
          ),
        ],
      ),
    );
  }
}
