import 'package:elastic_client/elastic_client.dart';
import 'package:demo/json/nutriStat.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:demo/json/UserInfo.dart';

Future<void> main() async {
  final transport = HttpTransport(url: 'http://localhost:9200/');
  final client = Client(transport);

  final rs1 = await client.search(
    index: 'es_food',
    type: '_doc',
    query: Query.term('food_nm', ['토마토']),
    source: ['food_nm'],
  );
  print(rs1.toMap());

  print('---');

  final rs2 = await client.search(
      index: 'es_food',
      type: '_doc',
      query: Query.term('food_nm', ['닭갈비']),
      source: [
        'food_nm',
        'food_cd'
      ],
      sort: [
        {'food_cd': 'asc'},
      ]);
  print(rs2.toMap());

  await transport.close();
}

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

class SearchTest extends StatefulWidget {
  String email;
  SearchTest({Key? key, required this.email}) : super(key: key);

  @override
  State<SearchTest> createState() => _SearchTestState();
}

class _SearchTestState extends State<SearchTest> {
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
      body: Container(),
    );
  }
}
