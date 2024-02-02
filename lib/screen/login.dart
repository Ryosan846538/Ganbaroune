import 'package:flutter/material.dart';
import '/screen/user_register.dart';
import './home.dart';
import '/service/user_data_repository.dart';
import '/service/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const storage = FlutterSecureStorage();
class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('がんばろうね'),
        backgroundColor: Colors.orange[300],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 32,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ユーザー名を入力してください',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                ),
              ),

              Center(
                child: ElevatedButton(
                    child: const Text('ログイン'),
                      onPressed: () async {
                        dynamic inputData = {
                          'name': nameController.text,
                          'password': passwordController.text,
                        };
                        try{
                          dynamic responseData=await fetchUserDataLogin(inputData); // Pass context here
                          if (!mounted) return;
                          if(responseData["message"]!="error"){
                            await storage.write(key: "username", value: nameController.text);
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder:(context)=>const Home()),
                            );
                          }else{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:const Text("エラー"),
                                  content: const Text("ユーザー名またはパスワードが間違っています。"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // ダイアログを閉じる
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (error){
                          // print('Error: $error');
                        }
                    },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text('ユーザ登録'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=>const UserRegister()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> fetchUserDataLogin(dynamic inputData) async {
  final String apiUrl =dotenv.get('API_SERVER');
  ApiClient apiClient = ApiClient(apiUrl);
  var userData = UserDataRepository(apiClient);
  dynamic responseData;
  try {
    responseData =await userData.postLogin(inputData);
    // データの受け取りと処理はここで行う
      //print(responseData);
    // 例えば、結果をログに出力するなど
  } catch (error) {
    responseData ={
      "message":"error"
    };
    //print(responseData);
  }
  return responseData;
}