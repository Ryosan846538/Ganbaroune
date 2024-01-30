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
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1), // 枠線を追加
            ),
            child: ListTile(
              leading: Icon(
                Icons.circle,
                color: friends[index].statusColor,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      friends[index].name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text('今日の目標: '),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ボタンの動作は変更なし
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
