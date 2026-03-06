import 'package:flutter/material.dart';
import 'package:space_app/presentation/components/icons.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Widget> notifications = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      notifications.add(
        UserNotificationTile(index: i, removeNotification: removeNotification),
      );
    }
  }

  void removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton(
                    child: Text(
                      "Clear All",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                        notifications.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
            SliverList.separated(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return notifications[index];
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserNotificationTile extends StatelessWidget {
  final Function(int) removeNotification;
  final int index;
  const UserNotificationTile({
    super.key,
    required this.index,
    required this.removeNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(index),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        removeNotification(index);
      },
      background: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 20,
                child: AppIcons.userIconUnSelected,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username", style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  "Started following you",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Text("1 m", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
