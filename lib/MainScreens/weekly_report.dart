import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as http;
import 'package:demo/json/nutriStat.dart';
import 'dart:async';
import 'dart:convert';

Future<NutriStat> fetchAnalysisData(String userid) async {
  String baseUrl = 'http://10.0.2.2:8000/log/today/homepage/'; // 혜원
  // String baseUrl = 'http://192.168.1.98:8000/log/today/homepage/'; // 영우
  final response = await http.get(Uri.parse(baseUrl + userid));

  if (response.statusCode == 200) {
    return NutriStat.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class weeklyReport extends StatefulWidget {
  String email;
  weeklyReport({Key? key, required this.email}) : super(key: key);

  @override
  State<weeklyReport> createState() => _weeklyReportState();
}

class _weeklyReportState extends State<weeklyReport> {
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
                          height: MediaQuery.of(context).size.height / 0.5,
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
                                    width: 0.5,
                                    borderRadius: BorderRadius.circular(5),
                                    spacing: 3,
                                  ),
                                  StackedBar100Series<Nutridata, String>(
                                    dataSource: _chartData,
                                    xValueMapper: (Nutridata nut, _) =>
                                        nut.nutriCategory,
                                    yValueMapper: (Nutridata nut, _) =>
                                        nut.nutriResidual,
                                    name: '권장 섭취량',
                                    color: Colors.grey,
                                    width: 0.5,
                                    borderRadius: BorderRadius.circular(5),
                                    spacing: 2,
                                  )
                                ],
                                primaryXAxis: CategoryAxis(),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Carbohydrate}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Carbohydrate}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "g",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 38),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 단백질
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Protein}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 단백질 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Protein}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 단백질 권장 섭취량
                                        const Text(
                                          "g",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 단백질 단위
                                      ],
                                    ),
                                    const SizedBox(height: 38),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 지방
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Fat}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 지방 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Fat}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 지방 권장 섭취량
                                        const Text(
                                          "g",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 지방 단위
                                      ],
                                    ),
                                    const SizedBox(height: 38),
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
                                          "${snapshot.data!.nutrStatus.Dietary_Fiber}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Dietary_Fiber}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "g",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 37),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_B6}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_B6}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 37),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_B12}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_B12}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "μg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 37),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Folic_acid}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Folic_acid}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "DFE μg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), //
                                      ],
                                    ),
                                    const SizedBox(height: 38),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Niacin}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Niacin}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "mgNE",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_C}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_C}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_A}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_A}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "μg RAE",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_D}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_D}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "μg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_E}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_E}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg α-TE",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Vitamin_K}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Vitamin_K}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "μg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Calcium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Calcium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Phosphorus}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Phosphorus}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Potassium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Potassium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Sodium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Sodium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Magnesium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Magnesium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Iron}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Iron}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Copper}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Copper}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Zinc}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Zinc}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Manganese}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Manganese}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Selenium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Selenium}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "μg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Leucine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Leucine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Iso_Leucine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Iso_Leucine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Histidine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Histidine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 42),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Linoleic_Acid}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Linoleic_Acid}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "g",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Alpha_Linolenic_Acid}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Alpha_Linolenic_Acid}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "g",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 42),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Lysine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Lysine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 42),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Methionine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Methionine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Phenylalanine_Tyrosine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Phenylalanine_Tyrosine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Threonine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Threonine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // 탄수화물
                                      children: [
                                        Text(
                                          "${snapshot.data!.nutrStatus.Valine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 섭취량
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data!.rdi.Valine}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 권장 섭취량
                                        const Text(
                                          "mg",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ), // 탄수화물 단위
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
