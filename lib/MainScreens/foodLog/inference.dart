import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../home_page.dart';

Future<dynamic> sendInfData(
  String userid,
  String imgKey,
  List<dynamic> classList,
  List<dynamic> foodList,
) async {
  Map<String, dynamic> data = {
    // 'userid': userid,
    'image_key': imgKey,
    'class_list': classList,
    'food_list': foodList,
  };
  String baseUrl = 'http://10.0.2.2:8000/log/post/meal/log/'; // 혜원
  // String baseUrl = 'http://192.168.1.98:8000/log/post/meal/log/'; // 영우
  // String baseUrl = 'http://52.78.143.49:8000/log/post/meal/log/'; // 영우
  // String baseUrl = 'http://192.168.219.107:8000/log/post/meal/log/'; // 영우
  final response = await http.post(
    Uri.parse(baseUrl + userid),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create data');
  }
}

class Inference extends StatefulWidget {
  String email;
  String uri;
  List<dynamic>? subcat;
  String s3Key;
  List<dynamic> classCat;

  Inference(
      {Key? key,
      required this.uri,
      required this.email,
      this.subcat,
      required this.s3Key,
      required this.classCat})
      : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  late String userid;
  late String url;
  late List<dynamic>? foodList;
  late String key;
  late List<dynamic> classType;
  late List<dynamic> foodSelection = [
    for (var x = 0; x < foodList!.length; x++) foodList![x][0].toString()
  ];

  @override
  void initState() {
    url = widget.uri;
    userid = widget.email;
    foodList = widget.subcat;
    key = widget.s3Key;
    classType = widget.classCat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Please Select the Detail!",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Image.network(
                url,
                width: MediaQuery.of(context).size.width / 1.1,
                // height: 400,
              ),
              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  for (var i = 0; i < classType.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          classType[i] + ' →     ',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        DropdownButton<dynamic>(
                          // value: dropdownValue = foodList![i][0],
                          value: foodSelection[i],
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              foodSelection[i] = newValue!;
                              print(foodSelection);
                            });
                          },
                          items: foodList![i]
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    var res =
                        sendInfData(userid, key, classType, foodSelection);

                    Navigator.pop(context);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(email: userid),
                    //   ),
                    // );
                  },
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
