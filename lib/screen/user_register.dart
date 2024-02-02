import 'package:flutter/material.dart';
import './login.dart';
import '/service/user_data_repository.dart';
import '/service/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);


  @override
  State<UserRegister> createState() => UserRegisterState();
}
class UserRegisterState extends State<UserRegister> {

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
        title: const Text('ユーザー登録しよう！'),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ユーザー名',
              ),
            ),
            const SizedBox(height: 16.0),

            // パスワード入力フィールド
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'パスワード',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),

            // パスワード確認入力フィールド
            const TextField(
              // controller: passwordConfirmController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'パスワード確認',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),

            // 登録ボタン
            // 登録ボタン
            ElevatedButton(
              onPressed: () async {
                dynamic inputData = {
                  'name': nameController.text,
                  'password': passwordController.text,
                };
                try{
                  await fetchUserData(inputData); // Pass context here
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=>const LoginPage()),
                  );
                } catch (error){
                  // print('Error: $error');
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
  final String apiUrl =dotenv.get('API_SERVER');
  ApiClient apiClient = ApiClient(apiUrl);
  var userData = UserDataRepository(apiClient);
  try {
    await userData.createUserData(inputData);
    // データの受け取りと処理はここで行う
    // 例えば、結果をログに出力するなど
  } catch (error) {
    // エラーハンドリング
    // print('Error: $error');
    // print('Error Details: ${error.toString()}');
  }
}