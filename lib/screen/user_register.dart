import 'package:flutter/material.dart';
import './login.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}
class _UserRegisterState extends State<UserRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー登録しよう！'),
        backgroundColor: Colors.orange[300],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ユーザー名入力フィールド
            TextField(
              decoration: InputDecoration(
                labelText: 'ユーザー名',
              ),
            ),
            SizedBox(height: 16.0),

            // パスワード入力フィールド
            TextField(
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            // パスワード確認入力フィールド
            TextField(
              decoration: InputDecoration(
                labelText: 'パスワード確認',
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),

            // 登録ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=>const LoginPage()),
                );
              },
              child: Text('登録'),

            ),
          ],
        ),
      ),
    );
  }
}
