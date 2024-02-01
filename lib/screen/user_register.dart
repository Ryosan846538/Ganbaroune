import 'package:flutter/material.dart';
import './login.dart';
import '/service/user_data_repository.dart';
import '/service/api_client.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}
class _UserRegisterState extends State<UserRegister> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    // コントローラを破棄してリソースを解放
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // void _submitData(){
  //   if(passwordController.text == passwordConfirmController.text){
  //     final inputData = {
  //       'password': passwordController.text,
  //     };
  //   } else {
  //     print('パスワードが一致しません');
  //   }
  // }
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
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'ユーザー名',
              ),
            ),
            const SizedBox(height: 16.0),

            // パスワード入力フィールド
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),

            // パスワード確認入力フィールド
            TextField(
              // controller: passwordConfirmController,
              decoration: InputDecoration(
                labelText: 'パスワード確認',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),

            // 登録ボタン
            ElevatedButton(
              onPressed: () async {
                dynamic inputData = {
                  'name': nameController.text,
                  'password': passwordController.text,
                };
                try{
                  await fetchUserData(inputData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=>const LoginPage()),
                  );
                } catch (error){
                  print('Error: $error');
                }
              },
              child:const Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> fetchUserData(dynamic inputData) async {
  // ApiClient apiClient = ApiClient('');
  var userData = UserDataRepository(apiClient);
  try {
    final data = await userData.createUserData(inputData);
    // データの受け取りと処理
    print('User Data: $data');
  } catch (error) {
    // エラーハンドリング
    print('Error: $error');
    print('Error Details: ${error.toString()}');
  }
}