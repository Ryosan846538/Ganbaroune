import 'package:flutter/material.dart';
import '/screen/menu.dart';
import '/screen/stop_watch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _selectPage(int index) {
    switch (index) {
      case 1:
        return const CountUpPage();
      default:
        return const Center(
          child: Text('Hello World'),
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