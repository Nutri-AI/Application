import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:demo/json/UserInfo.dart';

Future<UserInfo> fetchUserData(String userid) async {
  String baseUrl = 'http://192.168.1.98:8000/user/info/';
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class MyPage extends StatefulWidget {
  String email;
  MyPage({Key? key, required this.email}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<UserInfo> userData;
  late String userid;

  @override
  void initState() {
    userid = widget.email;
    userData = fetchUserData(userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 200,
          height: 200,
          child: FutureBuilder<UserInfo>(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(userid), Text(snapshot.data!.pk)],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          )),
    );
  }
}
