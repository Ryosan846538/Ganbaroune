import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  Menu({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: '勉強記録',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'プロフィール',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '設定',
        ),
      ],
    );
  }
}