import 'package:flutter/material.dart';
import '/screen/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  runApp( const MaterialApp(
    home: LoginPage(),
  ),);
}

