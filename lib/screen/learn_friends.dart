import 'package:flutter/material.dart';

class Friend {
  final String name;
  final int status;

  Friend({required this.name, required this.status});

  Color get statusColor {
    switch (status) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
  List<Friend> friends = [
    Friend(name: 'やまだ', status: 1),
    Friend(name: 'みと', status: 0),
    Friend(name: 'かたやま', status: 2),
  ];

  void addFriend(String name) {
    setState(() {
      friends.add(Friend(name: name, status: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('まなびフレンド'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.circle,
              color: friends[index].statusColor,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('今日の目標: '),
                Text(friends[index].name),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String? name;
              return AlertDialog(
                title: const Text('いっしょにがんばる?'),
                icon: const Icon(
                  Icons.handshake,
                  size: 50,
                ),
                content: TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(hintText: "名前を入力してね"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('がんばる!'),
                    onPressed: () {
                      if (name != null && name!.isNotEmpty) {
                        addFriend(name!);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
