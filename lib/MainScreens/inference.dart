import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<dynamic> sendInfData(
  String userid,
  String imgKey,
  List<String> classList,
  List<String> foodList,
) async {
  Map<String, dynamic> data = {
    'userid': userid,
    'image_key': imgKey,
    'class_list': classList,
    'food_list': foodList,
  };
  // String baseUrl = 'http://10.0.2.2:8000/log/post/meal/log/'; // 혜원
  String baseUrl = 'http://192.168.1.98:8000/log/post/meal/log/'; // 영우
  final response = await http.post(
    Uri.parse(baseUrl),
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
  String uri;
  List<dynamic>? subcat;
  String s3Key;
  List<dynamic>? classCat;

  Inference(
      {Key? key,
      required this.uri,
      this.subcat,
      required this.s3Key,
      this.classCat})
      : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  late String url;
  late List<dynamic>? foodList;
  late String key;
  late List<dynamic>? classType;
  dynamic? dropdownValue;
  // List<dynamic> foodSelection = ['x', 'x'];
  List<dynamic> foodSelection = [];

  @override
  void initState() {
    url = widget.uri;
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
              Row(
                children: [
                  // Column(children: [
                  //   Image.network(
                  //     url,
                  //     width: 300,
                  //     height: 300,
                  //   ),
                  // ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < classType!.length; i++)
                        Text(
                          classType![i] + '의 세부카테고리:   ',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < classType!.length; i++)
                        DropdownButton<dynamic>(
                          value: dropdownValue = foodList![i][0],
                          //value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              // foodSelection[i] = dropdownValue;
                              foodSelection.add(dropdownValue);
                              // print(i);
                              print(foodSelection);
                            });
                          },
                          items: foodList![i]
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: Colors.amber, // default가 green이네?
                ),
                child: ElevatedButton(
                    onPressed: () async {}, child: const Text("Confirm")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
