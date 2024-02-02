import 'package:flutter/material.dart';
import '/service/friend_data_repository.dart';
import '/service/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Friend {
  final String name;
  final int status;
  String? emojiReaction;
  String goal;
  DateTime lastReactionDate;

  Friend({required this.name, required this.status, this.emojiReaction,required this.goal,})
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

class FriendName {
  final String friendme;
  final String friendyou;

  FriendName({required this.friendme, required this.friendyou});
}

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
  List<Friend> friends = [];

  @override
  void initState() {
    super.initState();
    fetchFriends();
  }

  void fetchFriends() async {
    try {
      List<Friend> fetchedFriends = await getFriends('john');
      if (fetchedFriends.isNotEmpty) {
        setState(() {
          friends = fetchedFriends;
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _refreshFriends() async {
    final updatedRecords = await getFriends('john');
    if (updatedRecords.isNotEmpty) {
      setState(() {
        friends = updatedRecords;
      });
    }
  }

  TextEditingController friendController = TextEditingController();

  final List<String> emojiOptions = ['None', '🙂', '😊', '😂', '😢', '😠', '👍', '👎'];

  // 絵文字リスト
  final Map<String, int> emojiToInt = {
    'None': 0, // 追加: リアクションなしを示すキー
    '🙂': 1,
    '😊': 2,
    '😂': 3,
    '😢': 4,
    '😠': 5,
    '👍': 6,
    '👎': 7,
  };

  void addFriend(String name) async {
    dynamic inputData = {
      'myself': 'test',
      'yourself': name,
    };
    print(inputData);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await fetchFriend(inputData);
      List<Friend> updatedFriends = await getFriends('test');
      setState(() {
        friends = updatedFriends;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
            content: Text('Error: $error'),
            action: SnackBarAction(
              label: '閉じる',
              onPressed: () {
                // Some code to undo the change
              },
            )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('まなびフレンド'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshFriends,
        child: ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            var friend = friends[index];
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
                          friend.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: friend.emojiReaction ?? 'None',
                          onChanged: (String? newValue) {
                            setState(() {
                              if (!isSameDay(DateTime.now(),
                                  friends[index].lastReactionDate)) {
                                friend.emojiReaction = 'None';
                              }
                              friend.emojiReaction = newValue;
                              friend.lastReactionDate = DateTime.now();
                              // int emojiValue = emojiToInt[newValue!]!;
                              // print('emojiValue: $emojiValue');
                            });
                          },
                          items: emojiOptions.map<DropdownMenuItem<String>>((
                              String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Text('今日の目標: ${friend.goal}'),
                  ],
                ),
              ),
            );
          },
        ),
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
                  controller: friendController,
                  decoration: const InputDecoration(hintText: "名前を入力してね"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('がんばる!'),
                    onPressed: () {
                      if (name != null && name!.isNotEmpty) {
                        addFriend(friendController.text);
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

  // 2つの日付が同じ日であるかどうかを確認
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month &&
        date1.day == date2.day;
  }
}


Future<List<Friend>> fetchFriend(dynamic inputData) async {
  final String apiUrl = dotenv.get('API_SERVER');
  ApiClient apiClient = ApiClient(apiUrl);
  var friend = FriendDataRepository(apiClient);

  try {
    await friend.postFriendAdd(inputData);
    print('API Response: $inputData');
    // データの受け取りと処理はここで行う
    // 例えば、結果をログに出力するなど
    List<Friend> updatedFriends = await getFriends('john');
    return updatedFriends;
  } catch (error) {
    // エラーハンドリング
    print('Error: $error');
    print('Error Details: ${error.toString()}');
    return [];
  }
}

Future<List<Friend>> getFriends(String username) async {
  final String apiUrl = dotenv.get('API_SERVER');
  ApiClient apiClient = ApiClient(apiUrl);
  var friend = FriendDataRepository(apiClient);
  List<Friend> friends = [];

  try{
    dynamic responseData = await friend.getFriendName(username);
    if(responseData['message'] == 'succeed'){
      List<Map<String, dynamic>> dataList = List.castFrom(responseData['friend_data']);
      print(dataList);
      friends = dataList.map((data) {
        String friendName = data['friend_name'].toString();
        int status=data['user_login'].toInt();
        String goal = data['goal'].toString();
        print(status);
        return Friend(
          name: friendName, // Use friendyou as the name
          status: status,
          goal: goal,// or any default status
        );
      }).toList();

    } else {
      // Handle the case when the API response is not successful
      //print('API response indicates failure');
    }
  } catch (error) {
    // Text(e);
  }
  return friends;
}