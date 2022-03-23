import 'dart:io';

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

class dailyReport extends StatefulWidget {
  String email;
  dailyReport({Key? key, required this.email}) : super(key: key);

  @override
  State<dailyReport> createState() => _dailyReportState();
}

class _dailyReportState extends State<dailyReport> {
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(5),
          child: FutureBuilder<NutriStat>(
            future: analData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Nutridata> _chartData = [
                  // (category, 권장-섭취, 섭취량)
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
                    child: Column(
                      children: [
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
                        Row(
                          children: [
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
                        Row(
                          children: [
                            const Text(
                              "Total Nutrients Intake",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          // height: MediaQuery.of(context).size.height / 1,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              SfCartesianChart(
                                enableAxisAnimation: true,
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
                                    spacing: 2,
                                  )
                                ],
                                primaryXAxis: CategoryAxis(),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    const SizedBox(height: 35),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   // 콜레스테롤 어딨어!
                                    //   children: [
                                    //     Text(
                                    //         "${snapshot.data!.nutrStatus.Cholesterol}"),
                                    //     const Text("/"),
                                    //     Text(
                                    //         "${snapshot.data!.rdi.Cholesterol}"),
                                    //     const Text("g"),
                                    //   ],
                                    // ),
                                    // const SizedBox(height: 35),
                                    Row(
                                      // 총 식이섬유
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Dietary_Fiber}"),
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Dietary_Fiber}"),
                                        const Text("g"),
                                      ],
                                    ),
                                    const SizedBox(height: 35),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_B6}"),
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Vitamin_B6}"),
                                        const Text("mg"),
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_B12}"),
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Vitamin_B12}"),
                                        const Text("μg"),
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Folic_acid}"),
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Folic_acid}"),
                                        const Text("DFE μg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Niacin}"),
                                        const Text("/"),
                                        Text("${snapshot.data!.rdi.Niacin}"),
                                        const Text("mgNE"),
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_C}"),
                                        const Text("/"),
                                        Text("${snapshot.data!.rdi.Vitamin_C}"),
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_A}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Vitamin_A}"), // 탄수화물 권장 섭취량
                                        const Text("μg RAE"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_D}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Vitamin_D}"), // 탄수화물 권장 섭취량
                                        const Text("μg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_E}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Vitamin_E}"), // 탄수화물 권장 섭취량
                                        const Text("mg α-TE"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Vitamin_K}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Vitamin_K}"), // 탄수화물 권장 섭취량
                                        const Text("μg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Calcium}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Calcium}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Phosphorus}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Phosphorus}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Potassium}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Potassium}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Sodium}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Sodium}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Magnesium}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Magnesium}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Iron}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Iron}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Copper}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Copper}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Zinc}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Zinc}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Manganese}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Manganese}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Selenium}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Selenium}"), // 탄수화물 권장 섭취량
                                        const Text("μg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Leucine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Leucine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Iso_Leucine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Iso_Leucine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Histidine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Histidine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Linoleic_Acid}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Linoleic_Acid}"), // 탄수화물 권장 섭취량
                                        const Text("g"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Alpha_Linolenic_Acid}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Alpha_Linolenic_Acid}"), // 탄수화물 권장 섭취량
                                        const Text("g"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Lysine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Lysine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Methionine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Methionine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Phenylalanine_Tyrosine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Phenylalanine_Tyrosine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Threonine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Threonine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                            "${snapshot.data!.nutrStatus.Valine}"), // 탄수화물 섭취량
                                        const Text("/"),
                                        Text(
                                            "${snapshot.data!.rdi.Valine}"), // 탄수화물 권장 섭취량
                                        const Text("mg"), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
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
}

class Nutridata {
  Nutridata(this.nutriCategory, this.nutriResidual, this.nutriIntake);
  final String nutriCategory;
  final num nutriResidual;
  final num nutriIntake;
}
