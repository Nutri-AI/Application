import 'dart:io';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as http;
import 'package:demo/json/nutriStat.dart';
import 'dart:async';
import 'dart:convert';

Future<NutriStat> fetchAnalysisData(String userid) async {
  // String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/'; // 혜원
  String baseUrl = 'http://192.168.1.98:8000/log/today/homepage/'; // 영우
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return NutriStat.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Analyze extends StatefulWidget {
  String email;
  Analyze({Key? key, required this.email}) : super(key: key);

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  late String userid;
  late Future<NutriStat> analData;

  @override
  void initState() {
    userid = widget.email;
    analData = fetchAnalysisData(userid);
    // _chartData = getChartData();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<NutriStat>(
          future: analData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Nutridata> _chartData = [
                Nutridata(
                    "지방",
                    snapshot.data?.rdi.Fat - snapshot.data?.nutrStatus.Fat,
                    snapshot.data?.nutrStatus.Fat), // 32-10=22, 10(섭취량)
                Nutridata(
                    "단백질",
                    snapshot.data?.rdi.Protein -
                        snapshot.data?.nutrStatus.Protein,
                    snapshot.data?.nutrStatus.Protein), // 150-90=60, 90(섭취량)
                Nutridata(
                    "탄수화물",
                    snapshot.data?.rdi.Carbohydrate -
                        snapshot.data?.nutrStatus.Carbohydrate,
                    snapshot.data?.nutrStatus
                        .Carbohydrate), // 200-160 = 40, 160(섭취량)
              ];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                            // 날짜
                            DateFormat("MM-dd").format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            // 이름
                            "Hello ${snapshot.data!.username}!",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(children: [
                          const Text(
                            "Total Calorie Intake",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "${snapshot.data!.nutrStatus.Calories}", // 섭취 칼로리
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "/",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "${snapshot.data!.rdi.Calories}", // 기초대사량
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text(
                            "kcal",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                        ),
                        const SizedBox(height: 25),
                    Row(),

                  ]),
                ),
              ),
            }
          },
        ),
      ),
    );
  }
}
