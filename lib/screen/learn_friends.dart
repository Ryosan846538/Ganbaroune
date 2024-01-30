import 'package:flutter/material.dart';

class Friend {
  final String name;
  final int status;
  String? emojiReaction;
  DateTime lastReactionDate;

  Friend({required this.name, required this.status, this.emojiReaction})
      : lastReactionDate = DateTime.now();

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

  // 絵文字リスト
  final List<String> emojiOptions = ['🙂', '😊', '😂', '😢', '😠', '👍', '👎'];

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
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: ListTile(
              leading: Icon(
                Icons.circle,
                color: friends[index].statusColor,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        friends[index].name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: friends[index].emojiReaction ?? 'None',
                        onChanged: (String? newValue) {
                          setState(() {
                            // 現在の日付と最後のリアクション日付が異なる場合、リアクションをリセット
                            if (!isSameDay(DateTime.now(), friends[index].lastReactionDate)) {
                              friends[index].emojiReaction = 'None';
                            }
                            friends[index].emojiReaction = newValue;
                            friends[index].lastReactionDate = DateTime.now(); // リアクション日付を更新
                          });
                        },
                        items: ['None', ...emojiOptions].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
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

  // 2つの日付が同じ日であるかどうかを確認
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}
