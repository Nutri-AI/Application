import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:demo/json/UserInfo.dart';

Future<UserInfo> fetchUserData(String userid) async {
  String baseUrl = 'http://10.0.2.2:8000/user/info/'; // 혜원
  // String baseUrl = 'http://192.168.1.98:8000/user/info/'; // 영우
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

String ageCalc(String birth) {
  DateTime birthday = DateFormat("yyyy-mm-dd").parse(birth);
  DateDuration age = AgeCalculator.age(birthday);
  return age.years.toString();
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
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 164, 228, 166),
          ),
          child: FutureBuilder<UserInfo>(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            // height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 165, 226),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 110.0,
                                  ),
                                  const CircleAvatar(
                                    radius: 65.0,
                                    backgroundImage:
                                        AssetImage('assets/greenprofile.jpg'),
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(snapshot.data!.username,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.grey[200],
                            child: Center(
                                child: Card(
                                    margin: EdgeInsets.fromLTRB(
                                        0.0, 45.0, 0.0, 0.0),
                                    child: Container(
                                        width: 310.0,
                                        height: 290.0,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Information",
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.grey[300],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.accessibility,
                                                    color:
                                                        Colors.blueAccent[400],
                                                    size: 35,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Height",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data!.physique
                                                            .height
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.auto_awesome,
                                                    color: Colors
                                                        .yellowAccent[400],
                                                    size: 35,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Weight",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data!.physique
                                                            .weight
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    color:
                                                        Colors.pinkAccent[400],
                                                    size: 35,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Activity Level",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!.physique.PAI
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.medication_rounded,
                                                    color:
                                                        Colors.lightGreen[400],
                                                    size: 35,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Supplements",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data!.nutrSuppl
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )))),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.45,
                        left: 20.0,
                        right: 20.0,
                        child: Card(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child: Column(
                                children: [
                                  Text(
                                    'Sex',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    snapshot.data!.physique.sex,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              )),
                              Container(
                                child: Column(children: [
                                  Text(
                                    'Birthday',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    snapshot.data!.physique.birth,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                  child: Column(
                                children: [
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    ageCalc(snapshot.data!.physique.birth),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                        )))
                  ],
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
