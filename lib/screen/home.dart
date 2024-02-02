import 'package:flutter/material.dart';
import '/screen/menu.dart';
import '/screen/stop_watch.dart';
import '/screen/learn_friends.dart';
import '/screen/learn_stock.dart';
import './login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _selectPage(int index) {
    switch (index) {
      case 0:
        return const CountUpPage();
      case 1:
        return const LearnStock();
      case 2:
        return const FriendList();
      default:
        return Center(
          child: OutlinedButton(
            onPressed:() async{
              await storage.delete(key: "username");
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text(
              'ログアウト',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: const Text('がんばろうね'),
          centerTitle: true,
        ),
        body: _selectPage(_selectIndex),
        bottomNavigationBar: Menu(
          key: const Key('Menu'),
          currentIndex: _selectIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
