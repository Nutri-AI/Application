import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as http;
import 'package:demo/json/nutriStat.dart';
import 'dart:async';
import 'dart:convert';

Future<NutriStat> fetchAnalysisData(String userid) async {
  // String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/'; // 혜원
  // String baseUrl = 'http://192.168.1.7:8000/log/today/homepage/'; // 영우
  String baseUrl = 'http://52.78.143.49:8000/log/today/homepage/';
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return NutriStat.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.all(5),
          child: FutureBuilder<NutriStat>(
            future: analData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Nutridata> _chartData = [
                  // (category, 권장-섭취, 섭취량)
                  Nutridata(
                      "Valine",
                      max(
                          snapshot.data?.rdi.Valine -
                              snapshot.data?.nutrStatus.Valine,
                          0),
                      snapshot.data?.nutrStatus.Valine),
                  Nutridata(
                      "Threonine",
                      max(
                          snapshot.data?.rdi.Threonine -
                              snapshot.data?.nutrStatus.Threonine,
                          0),
                      snapshot.data?.nutrStatus.Threonine),
                  Nutridata(
                      '''Phenylalanine\nTyrosine''',
                      max(
                          snapshot.data?.rdi.Phenylalanine_Tyrosine -
                              snapshot.data?.nutrStatus.Phenylalanine_Tyrosine,
                          0),
                      snapshot.data?.nutrStatus.Phenylalanine_Tyrosine),
                  Nutridata(
                      "Methionine",
                      max(
                          snapshot.data?.rdi.Methionine -
                              snapshot.data?.nutrStatus.Methionine,
                          0),
                      snapshot.data?.nutrStatus.Methionine),
                  Nutridata(
                      "Lysine",
                      max(
                          snapshot.data?.rdi.Lysine -
                              snapshot.data?.nutrStatus.Lysine,
                          0),
                      snapshot.data?.nutrStatus.Lysine),
                  Nutridata(
                      '''α-Linolenic\nAcid''',
                      max(
                          snapshot.data?.rdi.Alpha_Linolenic_Acid -
                              snapshot.data?.nutrStatus.Alpha_Linolenic_Acid,
                          0),
                      snapshot.data?.nutrStatus.Alpha_Linolenic_Acid),
                  Nutridata(
                      "Linoleic Acid",
                      max(
                          snapshot.data?.rdi.Linoleic_Acid -
                              snapshot.data?.nutrStatus.Linoleic_Acid,
                          0),
                      snapshot.data?.nutrStatus.Linoleic_Acid),
                  Nutridata(
                      "Histidine",
                      max(
                          snapshot.data?.rdi.Histidine -
                              snapshot.data?.nutrStatus.Histidine,
                          0),
                      snapshot.data?.nutrStatus.Histidine),
                  Nutridata(
                      "Iso Leucine",
                      max(
                          snapshot.data?.rdi.Iso_Leucine -
                              snapshot.data?.nutrStatus.Iso_Leucine,
                          0),
                      snapshot.data?.nutrStatus.Iso_Leucine),
                  Nutridata(
                      "Leucine",
                      max(
                          snapshot.data?.rdi.Leucine -
                              snapshot.data?.nutrStatus.Leucine,
                          0),
                      snapshot.data?.nutrStatus.Leucine),
                  Nutridata(
                      "Selenium",
                      max(
                          snapshot.data?.rdi.Selenium -
                              snapshot.data?.nutrStatus.Selenium,
                          0),
                      snapshot.data?.nutrStatus.Selenium),
                  Nutridata(
                      "Manganese",
                      max(
                          snapshot.data?.rdi.Manganese -
                              snapshot.data?.nutrStatus.Manganese,
                          0),
                      snapshot.data?.nutrStatus.Manganese),
                  Nutridata(
                      "Zinc",
                      max(
                          snapshot.data?.rdi.Zinc -
                              snapshot.data?.nutrStatus.Zinc,
                          0),
                      snapshot.data?.nutrStatus.Zinc),
                  Nutridata(
                      "Copper",
                      max(
                          snapshot.data?.rdi.Copper -
                              snapshot.data?.nutrStatus.Copper,
                          0),
                      snapshot.data?.nutrStatus.Copper),
                  Nutridata(
                      "Iron",
                      max(
                          snapshot.data?.rdi.Iron -
                              snapshot.data?.nutrStatus.Iron,
                          0),
                      snapshot.data?.nutrStatus.Iron),
                  Nutridata(
                      "Magnesium",
                      max(
                          snapshot.data?.rdi.Magnesium -
                              snapshot.data?.nutrStatus.Magnesium,
                          0),
                      snapshot.data?.nutrStatus.Magnesium),
                  Nutridata(
                      "Sodium",
                      max(
                          snapshot.data?.rdi.Sodium -
                              snapshot.data?.nutrStatus.Sodium,
                          0),
                      snapshot.data?.nutrStatus.Sodium),
                  Nutridata(
                      "Potassium",
                      max(
                          snapshot.data?.rdi.Potassium -
                              snapshot.data?.nutrStatus.Potassium,
                          0),
                      snapshot.data?.nutrStatus.Potassium),
                  Nutridata(
                      "Phosphorus",
                      max(
                          snapshot.data?.rdi.Phosphorus -
                              snapshot.data?.nutrStatus.Phosphorus,
                          0),
                      snapshot.data?.nutrStatus.Phosphorus),
                  Nutridata(
                      "Calcium",
                      max(
                          snapshot.data?.rdi.Calcium -
                              snapshot.data?.nutrStatus.Calcium,
                          0),
                      snapshot.data?.nutrStatus.Calcium),
                  Nutridata(
                      "Vit K",
                      max(
                          snapshot.data?.rdi.Vitamin_K -
                              snapshot.data?.nutrStatus.Vitamin_K,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_K),
                  Nutridata(
                      "Vit E",
                      max(
                          snapshot.data?.rdi.Vitamin_E -
                              snapshot.data?.nutrStatus.Vitamin_E,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_E),
                  Nutridata(
                      "Vit D",
                      max(
                          snapshot.data?.rdi.Vitamin_D -
                              snapshot.data?.nutrStatus.Vitamin_D,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_D),
                  Nutridata(
                      "Vit A",
                      max(
                          snapshot.data?.rdi.Vitamin_A -
                              snapshot.data?.nutrStatus.Vitamin_A,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_A),
                  Nutridata(
                      "Vit C",
                      max(
                          snapshot.data?.rdi.Vitamin_C -
                              snapshot.data?.nutrStatus.Vitamin_C,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_C),
                  Nutridata(
                      "Niacin",
                      max(
                          snapshot.data?.rdi.Niacin -
                              snapshot.data?.nutrStatus.Niacin,
                          0),
                      snapshot.data?.nutrStatus.Niacin),
                  Nutridata(
                      "Folate",
                      max(
                          snapshot.data?.rdi.Folic_acid -
                              snapshot.data?.nutrStatus.Folic_acid,
                          0),
                      snapshot.data?.nutrStatus.Folic_acid),
                  Nutridata(
                      "Vit B12",
                      max(
                          snapshot.data?.rdi.Vitamin_B12 -
                              snapshot.data?.nutrStatus.Vitamin_B12,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_B12),
                  Nutridata(
                      "Vit B6",
                      max(
                          snapshot.data?.rdi.Vitamin_B6 -
                              snapshot.data?.nutrStatus.Vitamin_B6,
                          0),
                      snapshot.data?.nutrStatus.Vitamin_B6),
                  Nutridata(
                      "Fiber",
                      max(
                          snapshot.data?.rdi.Dietary_Fiber -
                              snapshot.data?.nutrStatus.Dietary_Fiber,
                          0),
                      snapshot.data?.nutrStatus.Dietary_Fiber),
                  //  Nutridata(
                  // "Cholesterol",
                  // snapshot.data?.rdi.Cholesterol - snapshot.data?.nutrStatus.Cholesterol,
                  // snapshot.data?.nutrStatus.Cholesterol),
                  Nutridata(
                      "Fat",
                      max(
                          snapshot.data?.rdi.Fat -
                              snapshot.data?.nutrStatus.Fat,
                          0),
                      snapshot.data?.nutrStatus.Fat), // 32-10=22, 10(섭취량)
                  Nutridata(
                      "Protein",
                      max(
                          snapshot.data?.rdi.Protein -
                              snapshot.data?.nutrStatus.Protein,
                          0),
                      snapshot.data?.nutrStatus.Protein), // 150-90=60, 90(섭취량)
                  Nutridata(
                      "Carbohydrate",
                      max(
                          snapshot.data?.rdi.Carbohydrate -
                              snapshot.data?.nutrStatus.Carbohydrate,
                          0),
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
                              DateFormat("MM/dd").format(DateTime.now()),
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
                              "${snapshot.data!.nutrStatus.Calories}/${snapshot.data!.rdi.Calories}kcal", // 섭취 칼로리
                              style: const TextStyle(fontSize: 18),
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
                          height: MediaQuery.of(context).size.height / 0.4,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(100, 247, 239, 153),
                            borderRadius: BorderRadius.circular(10),
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
                                    color: Color.fromARGB(255, 62, 165, 65),
                                    width: 0.4,
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
                                    color: Color.fromARGB(255, 92, 92, 92),
                                    width: 0.4,
                                    borderRadius: BorderRadius.circular(5),
                                    spacing: 2,
                                  )
                                ],
                                primaryXAxis: CategoryAxis(),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 32),
                                    // Expanded(child: Container()),

                                    Text(
                                      "${snapshot.data!.nutrStatus.Carbohydrate}/${snapshot.data!.rdi.Carbohydrate}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 38),
                                    Expanded(child: Container()),

                                    Text(
                                      "${snapshot.data!.nutrStatus.Protein}/${snapshot.data!.rdi.Protein}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ), // 단백질 섭취량
                                    // const SizedBox(height: 38),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Fat}/${snapshot.data!.rdi.Fat}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 38),
                                    // Text(
                                    //       "${snapshot.data!.nutrStatus.Cholesterol}/${snapshot.data!.rdi.Cholesterol}g",
                                    //       style: TextStyle(
                                    //         fontSize: 12,
                                    //       ),
                                    //     ),
                                    // const SizedBox(height: 35),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Dietary_Fiber}/${snapshot.data!.rdi.Dietary_Fiber}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 37),
                                    Expanded(child: Container()),

                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_B6}/${snapshot.data!.rdi.Vitamin_B6}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 37),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_B12}/${snapshot.data!.rdi.Vitamin_B12}\n(μg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 37),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Folic_acid}/${snapshot.data!.rdi.Folic_acid}\n(μgDFE)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 38),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Niacin}/${snapshot.data!.rdi.Niacin}\n(mgNE)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_C}/${snapshot.data!.rdi.Vitamin_C}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_A}/${snapshot.data!.rdi.Vitamin_A}\n(μg RAE)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_D}/${snapshot.data!.rdi.Vitamin_D}\n(μg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_E}/${snapshot.data!.rdi.Vitamin_E}\n(mg α-TE)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Vitamin_K}/${snapshot.data!.rdi.Vitamin_K}\n(μg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Calcium}/${snapshot.data!.rdi.Calcium}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Phosphorus}/${snapshot.data!.rdi.Phosphorus}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Potassium / 1000}/${snapshot.data!.rdi.Potassium / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Sodium / 1000}/${snapshot.data!.rdi.Sodium / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Magnesium}/${snapshot.data!.rdi.Magnesium}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Iron}/${snapshot.data!.rdi.Iron}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Copper}/${snapshot.data!.rdi.Copper}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Zinc}/${snapshot.data!.rdi.Zinc}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Manganese}/${snapshot.data!.rdi.Manganese}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Selenium}/${snapshot.data!.rdi.Selenium}\n(μg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Leucine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Leucine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Iso_Leucine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Iso_Leucine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Histidine}/${snapshot.data!.rdi.Histidine}\n(mg)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 42),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Linoleic_Acid}/${snapshot.data!.rdi.Linoleic_Acid}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${snapshot.data!.nutrStatus.Alpha_Linolenic_Acid}/${snapshot.data!.rdi.Alpha_Linolenic_Acid}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 42),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Lysine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Lysine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 42),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Methionine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Methionine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Phenylalanine_Tyrosine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Phenylalanine_Tyrosine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Threonine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Threonine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 40),
                                    Expanded(child: Container()),
                                    Text(
                                      "${(snapshot.data!.nutrStatus.Valine / 1000).toStringAsFixed(1)}/${snapshot.data!.rdi.Valine / 1000}\n(g)",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    // const SizedBox(height: 30),
                                    Expanded(child: Container()),
                                    const SizedBox(height: 18),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CupertinoActivityIndicator();
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
