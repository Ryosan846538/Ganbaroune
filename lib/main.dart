import 'package:flutter/material.dart';
import '/screen/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('がんばろうね'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
        bottomNavigationBar: Menu(
          currentIndex: _selectIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}