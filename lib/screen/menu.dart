import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.green[400],
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: 'まなびウォッチ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'まなびストック',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'まなびフレンド',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '設定',
        ),
      ],
    );
  }
}
