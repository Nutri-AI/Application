import 'dart:ffi';

import 'elasticsearchdelegate.dart';
import 'package:flutter/material.dart';
import 'package:elastic_client/console_http_transport.dart';
import 'package:elastic_client/elastic_client.dart' as elastic;
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:demo/json/UserInfo.dart';

Future<UserInfo> fetchUserData(String userid) async {
  // String baseUrl = 'http://10.0.2.2:8000/user/info/'; // 혜원
  // String baseUrl = 'http://192.168.0.243:8000/user/info/'; // 후웨이즈
  String baseUrl = 'http://192.168.219.107:8000/user/info/'; // 영우집
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

class foodSearch extends StatefulWidget {
  String email;
  foodSearch({Key? key, required this.email}) : super(key: key);

  @override
  State<foodSearch> createState() => _foodSearchState();
}

class _foodSearchState extends State<foodSearch> {
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
    return Container();
  }
}
