import 'package:demo/Input_UserInfo.dart';
import 'package:demo/home_page.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> fetchUser(String userid) async {
  // String baseUrl = 'http://192.168.0.242:8000/user/info/'; // 혜원
  // String baseUrl = 'http://192.168.1.7:8000/user/info/'; // 영우
  // String baseUrl = 'http://192.168.219.107:8000/user/info/'; // 영우 집
  // String baseUrl = 'http://172.30.1.40:8000/user/info/'; // 프릳츠
  String baseUrl = 'http://192.168.45.181:8000/user/info/'; // spc
  // String baseUrl = 'http://192.1.1.232:8000/user/info/'; // moi

  final response = await http.get(Uri.parse(baseUrl + userid));
  if (response.statusCode == 404) {
    return false;
  } else {
    return true;
  }
}

void main() async {
  // void: main 함수를 실행하고 아무런 값도 반환하지 않는다.
  runApp(const NutriaiApp()); // runApp은 widget을 인자로 받음
}

class NutriaiApp extends StatelessWidget {
  const NutriaiApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      // theme: appTheme,
      home: const MyLoginPage(title: 'NutriAI Login Demo'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Image.asset('assets/Login_design.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 10, bottom: 20),
              child: TextFormField(
                controller: _usernameController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                cursorColor: Colors.pink,
                decoration: const InputDecoration(
                  hintText: "Input your Email as UserID.",
                  hintStyle: TextStyle(color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  bool user = await fetchUser(_usernameController.text);
                  if (user) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePage(email: _usernameController.text),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InputUserInfo(email: _usernameController.text),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
