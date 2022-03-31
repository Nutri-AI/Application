import 'dart:io';
import 'package:demo/CustomDesign/customColor.dart';
import 'package:demo/MainScreens/analyze/daily_report.dart';
import 'package:demo/MainScreens/analyze/weekly_report.dart';
import 'package:demo/MainScreens/foodLog/inference.dart';
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
  // String baseUrl = 'http://192.168.219.107:8000/log/today/homepage/'; // 영우 집
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
  // late List<Nutridata> _chartData;
  late String userid;
  late Future<NutriStat> analData;
  // late variable: has no value,
  //its value will be initialized in the Future

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
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Appcolor.green,
            toolbarHeight: 10,
            bottom: const TabBar(
              padding: EdgeInsets.only(bottom: 15),
              isScrollable: true,
              tabs: [
                const Text(
                  "Daily Report     ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "     Weekly Report",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              dailyReport(email: userid),
              weeklyReport(email: userid),
            ],
          ),
        ),
      ),
    );
  }
}
  

// class Nutridata {
//   Nutridata(this.nutriCategory, this.nutriResidual, this.nutriIntake);
//   final String nutriCategory;
//   final num nutriResidual;
//   final num nutriIntake;
// }