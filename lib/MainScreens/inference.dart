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
  String baseUrl = 'http://10.0.2.2:8000/log/post/meal/log/'; // 혜원
  // String baseUrl = 'http://192.168.1.98:8000/log/post/meal/log/'; // 영우
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
  late List<dynamic> foodSelection = [
    for (var x = 0; x < foodList!.length; x++) foodList![x][0].toString()
  ];

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
          child: Row(
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
                children: <Widget>[
                  for (var i = 0; i < classType!.length; i++)
                    DropdownButton<dynamic>(
                      // value: dropdownValue = foodList![i][0],
                      value: foodSelection[i],
                      icon: const Icon(Icons.arrow_downward),
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
                          child: Text(value),
                        );
                      }).toList(),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
