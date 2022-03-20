import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as http;
import 'package:demo/json/nutriStat.dart';
import 'dart:async';
import 'dart:convert';

Future<NutriStat> fetchAnalysisData(String userid) async {
  String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/';
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
  late List<Nutridata> _chartData;
  late String userid;
  late Future<NutriStat> analData;
  // late TooltipBehavior _tooltipBehavior;
  // late variable: has no value,
  //its value will be initialized in the Future

  @override
  void initState() {
    userid = widget.email;
    analData = fetchAnalysisData(userid);
    _chartData = getChartData();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 50),
          child: FutureBuilder<NutriStat>(
            future: analData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  // biggest column
                  children: [
                    Row(
                      // 날짜, 이름
                      children: [
                        Text(
                          // 날짜
                          DateFormat("MM-dd").format(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          // 이름
                          "안녕하세요 ${snapshot.data!.username}!",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      // 총 섭취 칼로리
                      children: [
                        const Text(
                          "총 섭취 칼로리",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
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
                    const SizedBox(height: 30),
                    Row(
                      // 주요 영양소 title
                      children: const [
                        Text(
                          "총 섭취 영양소",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 3,
                      child: SfCartesianChart(
                        // legend: Legend(isVisible: true),
                        // tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          StackedBar100Series<Nutridata, String>(
                              dataSource: _chartData,
                              xValueMapper: (Nutridata nut, _) =>
                                  nut.nutriCategory,
                              yValueMapper: (Nutridata nut, _) =>
                                  nut.nutriIntake,
                              name: '사용자 섭취량',
                              color: Colors.green),
                          StackedBar100Series<Nutridata, String>(
                              dataSource: _chartData,
                              xValueMapper: (Nutridata nut, _) =>
                                  nut.nutriCategory,
                              yValueMapper: (Nutridata nut, _) =>
                                  nut.nutriResidual,
                              name: '권장 섭취량',
                              color: Colors.grey)
                        ],
                        primaryXAxis: CategoryAxis(),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  List<Nutridata> getChartData() {
    // Display 되는 순서의 거꾸로 데이터를 입력해야함
    final List<Nutridata> chartData = [
      Nutridata("지방", 22, 10), // 32-10=22, 10(섭취량)
      Nutridata("단백질", 60, 90), // 150-90=60, 90(섭취량)
      Nutridata("탄수화물", 40, 160), // 200-160 = 40, 160(섭취량)
    ];
    return chartData;
  }
}

class Nutridata {
  Nutridata(this.nutriCategory, this.nutriResidual, this.nutriIntake);
  final String nutriCategory;
  final num nutriResidual;
  final num nutriIntake;
}
