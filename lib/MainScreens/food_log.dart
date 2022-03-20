import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:demo/json/nutriStat.dart';
import 'dart:async';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

Future<NutriStat> fetchUserData(String userid) async {
  String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/';
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return NutriStat.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class FoodLog extends StatefulWidget {
  String email;
  FoodLog({Key? key, required this.email}) : super(key: key);

  @override
  State<FoodLog> createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  late List<Nutridata> _chartData;
  late String userid;
  late Future<NutriStat> userData;

  @override
  void initState() {
    userid = widget.email;
    userData = fetchUserData(userid);
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 80),
          child: FutureBuilder<NutriStat>(
            future: userData,
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
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          // 이름
                          "안녕하세요 ${snapshot.data!.username}님",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
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
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          "/",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${snapshot.data!.rdi.Calories}", // 기초대사량
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          "kcal",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      // 주요 영양소 title
                      children: [
                        const Text(
                          "주요영양소",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      // 주요 영양소 content
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber[100],
                      ),
                      child: Row(
                        children: [
                          // 탄단지 title, 그래프, 섭취량
                          Container(
                            // 탄단지 그래프
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SfCartesianChart(
                                  // legend: Legend(isVisible: true),
                                  // tooltipBehavior: _tooltipBehavior,
                                  margin: EdgeInsets.only(
                                      top: 0, bottom: 0, left: 0),
                                  series: <ChartSeries>[
                                    StackedBar100Series<Nutridata, String>(
                                      dataSource: _chartData,
                                      xValueMapper: (Nutridata nut, _) =>
                                          nut.nutriCategory,
                                      yValueMapper: (Nutridata nut, _) =>
                                          nut.nutriIntake,
                                      name: '사용자 섭취량',
                                      color: Colors.green,
                                      width: 0.3,
                                      borderRadius: BorderRadius.circular(5),
                                      spacing: 2,
                                    ),
                                    StackedBar100Series<Nutridata, String>(
                                      dataSource: _chartData,
                                      xValueMapper: (Nutridata nut, _) =>
                                          nut.nutriCategory,
                                      yValueMapper: (Nutridata nut, _) =>
                                          nut.nutriResidual,
                                      name: '권장 섭취량',
                                      color: Colors.grey,
                                      width: 0.3,
                                      borderRadius: BorderRadius.circular(5),
                                    )
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // 탄단지 섭취량
                            child: Column(
                              // 탄단지 섭취량, 권장섭취량
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // 탄수화물
                                  children: [
                                    Text(
                                        "${snapshot.data!.nutrStatus.Carbohydrate}"), // 탄수화물 섭취량
                                    const Text("/"),
                                    Text(
                                        "${snapshot.data!.rdi.Carbohydrate}"), // 탄수화물 권장 섭취량
                                    const Text("g"), // 탄수화물 단위
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  // 단백질
                                  children: [
                                    Text(
                                        "${snapshot.data!.nutrStatus.Protein}"), // 단백질 섭취량
                                    const Text("/"),
                                    Text(
                                        "${snapshot.data!.rdi.Protein}"), // 단백질 권장 섭취량
                                    const Text("g"), // 단백질 단위
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  // 지방
                                  children: [
                                    Text(
                                        "${snapshot.data!.nutrStatus.Fat}"), // 지방 섭취량
                                    const Text("/"),
                                    Text(
                                        "${snapshot.data!.rdi.Fat}"), // 지방 권장 섭취량
                                    const Text("g"), // 지방 단위
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Expanded(child: Container()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // 식단 로그 stepper
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Color.fromARGB(180, 100, 205, 0),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.centerRight,
                              )),
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green[600],
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
