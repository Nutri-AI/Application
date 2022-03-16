import 'package:demo/Input_UserInfo.dart';
import 'package:demo/home_page.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> fetchUser(String userid) async {
  String baseUrl = 'http://10.0.2.2:8000/user/info/';
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.body == 'null') {
    return false;
  } else {
    return true;
  }
}

void main() {
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
      theme: ThemeData(primarySwatch: Colors.lightGreen),
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
      // backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Image.asset('assets/NutriAI.png'),
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
            Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber,
                ),
                child: ElevatedButton(
                    onPressed: () async {
                      bool user = await fetchUser(_usernameController.text);
                      if (user) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
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
                    child: const Text("Login"))),
          ],
        ),
      ),
    );
  }
}
