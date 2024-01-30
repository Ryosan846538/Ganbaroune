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
        title:const Text('ユーザー登録しよう！'),
        backgroundColor: Colors.orange[300],
        centerTitle: true,
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ユーザー名入力フィールド
           const TextField(
              decoration: InputDecoration(
                labelText: 'ユーザー名',
              ),
            ),
           const SizedBox(height: 16.0),

            // パスワード入力フィールド
           const TextField(
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              obscureText: true,
            ),
           const SizedBox(height: 16.0),

            // パスワード確認入力フィールド
           const TextField(
              decoration: InputDecoration(
                labelText: 'パスワード確認',
              ),
              obscureText: true,
            ),
           const SizedBox(height: 32.0),

            // 登録ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=>const LoginPage()),
                );
              },
              child:const Text('登録'),

            ),
          ],
        ),
      ),
    );
  }
}
