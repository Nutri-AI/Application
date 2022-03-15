// ignore_for_file: unnecessary_const, non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'package:demo/json/UserSignUpInfo.dart';

import 'package:demo/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<UserSignUpInfo> createUser(
  String userid,
  String username,
  String birth,
  String sex,
  String height,
  String weight,
  String PAI,
) async {
  Map<String, dynamic> data = {
    'userid': userid,
    'username': username,
    'physique': {
      'birth': birth,
      'sex': sex,
      'height': height,
      'weight': weight,
      'PAI': PAI,
    },
  };

  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/user/join'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    return UserSignUpInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create data');
  }
}

class InputUserInfo extends StatefulWidget {
  String email;
  InputUserInfo({Key? key, required this.email}) : super(key: key);

  @override
  State<InputUserInfo> createState() => _InputUserInfoState();
}

class _InputUserInfoState extends State<InputUserInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  // final TextEditingController _sexController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  //Future<UserInfo>? _UserInfo;

  String dropdownValue1 = "F";
  String dropdownValue2 = "운동 안 함";

  Map pai = {
    "운동 안 함": "1.2",
    "격렬한 운동 주 1~2회 or 가벼운 운동 주 3~4회": "1.375",
    "격렬한 운동 주 3~4회 or 가벼운 운동 주 5~7회": "1,425",
    "격렬한 운동 주 5~6회": "1.55",
    "격렬한 운동 주 7회 이상": "1.75"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("사용자 정보를 입력해주세요!")),
      // resizeToAvoidBottomInset: false,
      // 이 센터 자체를 overflow 방지해주는 Box 안에 넣자!
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            // 1. 이름
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 20),
            child: TextFormField(
              controller: _nameController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              decoration: const InputDecoration(
                hintText: "이름을 입력하세요.",
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Padding(
            // 2. 생년월일
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextFormField(
              controller: _birthdateController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              decoration: const InputDecoration(
                hintText: "생년월일을 입력하세요. ex. 1998-10-27",
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          // 3. 성별
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: Text(
                    "성별",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ),
                DropdownButton(
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  elevation: 0,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: <String>["F", "M"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            // 4. 키
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextFormField(
              controller: _heightController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              decoration: const InputDecoration(
                hintText: "키를 입력하세요.(cm)",
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Padding(
            // 5. 몸무게
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextFormField(
              controller: _weightController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              decoration: const InputDecoration(
                hintText: "몸무게를 입력하세요.(kg)",
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          // 6. PAI
          Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: const Text(
                    "운동량",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ),
                DropdownButton(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  elevation: 0,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: <String>[
                    "운동 안 함",
                    "격렬한 운동 주 1~2회 or 가벼운 운동 주 3~4회",
                    "격렬한 운동 주 3~4회 or 가벼운 운동 주 5~7회",
                    "격렬한 운동 주 5~6회",
                    "격렬한 운동 주 7회 이상"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
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
                  onPressed: () {
                    createUser(
                      widget.email,
                      _nameController.text,
                      _birthdateController.text,
                      dropdownValue1,
                      _heightController.text,
                      _weightController.text,
                      pai[dropdownValue2],
                    );

                    // route me
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: const Text("Get Started!"))),
        ],
      )),
    );
  }
}
